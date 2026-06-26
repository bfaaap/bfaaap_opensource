/*
  bFaaaP Pro — Pico main-board firmware DRAFT for the stepper successor (approach A)
  =================================================================================
  ⚠️  AI DRAFT — UNTESTED.  A clean *starting skeleton* for H. Narusawa to bench-test
      and finalise. It is meant to compile and run the motion/airjack flow so the
      maker can iterate; the closed-loop driver protocol bytes are left as a clearly
      marked TODO (they depend on which driver is chosen).

  Chosen path (Narusawa, 2026-06-26) = "approach A": a CLOSED-LOOP NEMA17 — either
  MKS SERVO42C/D + a NEMA17, or an integrated closed-loop NEMA17 with a built-in
  driver — driven STEP/DIR, with the pressing-force step read from the driver's
  LOAD over serial (recovers the IQ "press until the reaction force rises" idea).

  Board: Raspberry Pi Pico / Pico 2  (arduino-pico / Philhower core).

  Pin map (confirmed 2026-06-24; this draft FIXES the v052B STEP/DIR clash, where
  the step pulse shared GP13 with the buzzer):
    Serial1  GP0 TX / GP1 RX   <-  BLE board, 1 byte 0..99   (Nordic UART bridge)
    Serial2  GP4 TX / GP5 RX   <-> closed-loop driver (load read / optional position cmd)
    GP14  STEP  ->  driver STEP
    GP15  DIR   ->  driver DIR
    GP12  ->  2SK4017 MOSFET  ->  air pump (airback)
    (GP2/GP3 unused in the successor — NO HX711; the airback is a fixed-time inflate, valve normally closed)
    A0 / GP26 ->  slide volume (upper-limit / force setpoint)
    GP16  ->  buzzer / status LED            [optional; moved OFF GP13 so STEP is clean]

  Differences from v052B snapshot: setup()/loop() are properly closed; move() has a
  single, consistent signature; STEP=GP14 / DIR=GP15 (no GP13 clash); the force read
  goes through readLoad() so you can switch ADC-current <-> driver-serial in one place.
*/

// ---------------- configuration ----------------
#define PIN_STEP    14
#define PIN_DIR     15
#define PIN_PUMP    12
#define PIN_BUZZER  16
#define PIN_SLIDER  A0          // GP26 / ADC0  — slide volume

// #define READ_LOAD_FROM_DRIVER  // uncomment to read load over Serial2 from the closed-loop driver

const int   STEPS_PER_MM   = 50;     // microsteps per 1 mm of push-rod travel (tune to lead 16 mm/rev + microstep)
const int   TRAVEL_CAP_MM  = 50;     // safety: never drive the rod out past 50 mm
const int   STEP_PULSE_US  = 350;    // STEP half-period (us). Narusawa flagged 80 us as TOO FAST
                                     //   (the pedal may not follow); slower = safer. TUNE on the bench.
const int   MOVE_HYST      = 2;      // ignore head jitter smaller than this (0..99 units)

// Force thresholds (driver-load units). Piano-dependent — set on the bench / from the slider.
// On the IQ version this was motor POWER 20..35 W; here it is the closed-loop driver's load.
int LOAD_THRESH_UP   = 600;          // "hit the mechanical top" load
int LOAD_THRESH_DOWN = 600;          // "pressing the pedal hard enough" load (too high -> rod slips)

// Airback (successor, Narusawa 2026-06-26): NO pressure sensor (no HX711). The pump runs for a
// FIXED time; the air valve is NORMALLY CLOSED (holds the air) and is released only when the unit
// is removed from the piano (manual / removal-actuated — not driven by this firmware).
const unsigned long AIR_INFLATE_MS = 40000UL;    // fixed 40 s of pumping

// ---------------- state ----------------
long cu_steps   = 0;     // current push-rod position, in steps
long up_pos     = 0;     // upper (released) limit, in steps
long down_pos   = 0;     // lower (pressed) mechanical limit, in steps
int  last_byte  = 0;     // last 0..99 value acted on

// ---------------- helpers ----------------
float mapf(float x, float a, float b, float c, float d) {
  return (x - a) * (d - c) / (b - a) + c;
}

void buzz(int ms) { digitalWrite(PIN_BUZZER, 1); delay(ms); digitalWrite(PIN_BUZZER, 0); }

// STEP/DIR motion. steps > 0 drives DOWN (toward the pedal); steps < 0 drives UP.
void moveSteps(long steps) {
  digitalWrite(PIN_DIR, steps >= 0 ? HIGH : LOW);
  long n = labs(steps);
  for (long i = 0; i < n; i++) {
    digitalWrite(PIN_STEP, HIGH); delayMicroseconds(STEP_PULSE_US);
    digitalWrite(PIN_STEP, LOW);  delayMicroseconds(STEP_PULSE_US);
  }
  cu_steps += steps;
}

// Read the actuator load. APPROACH A: ask the closed-loop driver over Serial2.
//   TODO(maker): fill in your driver's "read load / following-error / current" command.
//   - MKS SERVO42C/D: serial/UART or CAN protocol (see makerbase docs) -> parse the reply.
//   - integrated closed-loop NEMA17: vendor serial command.
// Fallback (default): an ADC current proxy so the skeleton runs on the bench.
int readLoad() {
#ifdef READ_LOAD_FROM_DRIVER
  // --- TODO: replace with the real query/parse for the chosen driver ---
  // Serial2.write(<driver query bytes>);
  // ... read reply, return the load value ...
  return 0;
#else
  // bench fallback: average an analog "current" proxy (A1 / GP27). NOT the final force source.
  analogReadResolution(10);
  long t = 0;
  for (int i = 0; i < 64; i++) t += analogRead(A1);
  return (int)(t / 64);
#endif
}

// Slide volume -> a 0..99 setpoint used as the upper-limit / force offset.
int readSlider() {
  analogReadResolution(10);
  long t = 0;
  for (int i = 0; i < 64; i++) t += analogRead(PIN_SLIDER);
  return (int)mapf(t / 64.0, 0, 1023, 0, 99);
}

// Airback: run the pump for a FIXED 40 s to inflate the WINBAG. No pressure sensor.
// The valve is normally closed, so the air is held after pumping; to DEFLATE, the valve is
// released when the unit is taken off the piano (not driven here).
void autoAirJack() {
  Serial.println("airjack: pumping 40 s (fixed)...");
  digitalWrite(PIN_PUMP, 1);
  delay(AIR_INFLATE_MS);                 // 40 s
  digitalWrite(PIN_PUMP, 0);
  Serial.println("airjack: done (valve normally closed; release on removal)");
}

// Find the mechanical top, then drive down until the pedal-press load is reached.
// Mirrors v052B auto_set, with a hard step cap so it can never run away.
void autoCalibrate() {
  const long CAP = (long)TRAVEL_CAP_MM * STEPS_PER_MM;
  long guard = 0;

  // 1) drive UP until the load rises (hit the top), then back off 5 mm = up_pos
  while (readLoad() < LOAD_THRESH_UP && guard++ < CAP * 2) moveSteps(-STEPS_PER_MM);
  moveSteps(5 * STEPS_PER_MM);
  up_pos = cu_steps;

  // 2) drive DOWN until the press load is reached OR the 50 mm travel cap, then up 10 mm = down_pos
  guard = 0;
  while (readLoad() < LOAD_THRESH_DOWN && (cu_steps - up_pos) < CAP && guard++ < CAP * 2)
    moveSteps(STEPS_PER_MM);
  moveSteps(-10 * STEPS_PER_MM);
  down_pos = cu_steps;

  Serial.print("calibrated up_pos="); Serial.print(up_pos);
  Serial.print(" down_pos="); Serial.println(down_pos);
}

// ---------------- setup / loop ----------------
void setup() {
  pinMode(PIN_STEP, OUTPUT);
  pinMode(PIN_DIR, OUTPUT);
  pinMode(PIN_PUMP, OUTPUT);
  pinMode(PIN_BUZZER, OUTPUT);

  Serial.begin(115200);        // USB debug
  Serial1.begin(115200);       // BLE board (GP0/GP1)
  Serial2.setTX(4); Serial2.setRX(5);
  Serial2.begin(115200);       // closed-loop driver (GP4/GP5)

  delay(2000);
  Serial.println("bFaaaP Pro stepperA draft 20260626 (AI draft, untested)");

  // force setpoint from the slide volume (optional: scale the thresholds)
  // LOAD_THRESH_DOWN = base + readSlider();   // TODO(maker): how the slider maps to force

  autoAirJack();      // anchor the unit with the airback
  autoCalibrate();    // find top/bottom + the press position
}

void loop() {
  if (Serial1.available() > 0) {
    int b = Serial1.read();                     // 0..99 from the BLE bridge
    if (b < 0 || b > 99) return;
    if (abs(b - last_byte) > MOVE_HYST) {       // ignore small head jitter
      long target = (long)mapf(b, 0, 99, up_pos, down_pos);
      moveSteps(target - cu_steps);             // go to the target and hold
      last_byte = b;
    }
  }
}
