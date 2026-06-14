# Hardware availability & alternatives

> English first; 日本語・ドイツ語版は後日 `i18n/` 配下に追加予定。
>
> Some parts used in the original design are **end‑of‑life (EOL)** or hard to
> source. This page records what changed and gives **concrete, currently‑available
> alternatives** plus **tips for adapting the firmware**. The "tips" are the
> maintainers' engineering opinion — verify against your exact parts.
> Always re‑check vendor stock; availability changes over time.

## Summary

| Component (original, per BOM) | Status | Suggested replacement | Code change |
|----------------------|--------|-----------------------|-------------|
| **IQ‑FORTIQ‑M42BLS‑100** (IQ motor, 100 W) — **current reference (v039B)** | **EOL** — firmware notes IQ supply stopped | **Closed‑loop stepper** with a **DRV8825‑compatible** interface (integrated option: MKS SERVO42C/D). *Note:* DRV8825 itself is the old standard module used only in early plain‑stepper tests; it is **not** the new motor | Moderate (STEP/DIR or serial position) |
| **nRF52840 BLE board** — Pro uses **Akizuki `AE-NRF52840` (g117484)** ✅ (confirmed: cheaper, same BLE module, same board ID); **Adafruit Feather nRF52840 (4062)** is a compatible alternative. *Not* ItsyBitsy (that's the Switch's DotStar LED variant). | Current | any nRF52840 + Adafruit nRF52 BSP | Minimal (same Bluefruit API; Pro firmware has no LED routine) |
| **Raspberry Pi Pico** main board | Current | **Pico** / **Pico 2 (RP2350)** | None (mind ADC pins) |
| **HX711** (air‑pressure sensor) | Current/common | Any HX711 breakout | None |
| **n‑MOSFET 2SK4017** (pump drive) | Common | any logic‑level n‑MOSFET | None |
| **AC100→DC24V** PSU | Generic | any 24 V switching PSU | None |

---

## 1. Drive motor — IQ / Fortiq → closed‑loop stepper

**What happened.** The **current reference** Pro device (firmware **v039B**) uses
the **IQ‑FORTIQ‑M42BLS‑100** (IQ Motion Control, 100 W; ≈¥33,000 on Crowd Supply).
The project's own firmware notes the **IQ motor supply stopped**
(`IQモーターの供給停止…`); the **next** version is being rewritten for a
**closed‑loop stepping motor** (which exposes a **DRV8825‑compatible** STEP/DIR
interface). **The specific successor motor is not yet decided** (device co‑author,
2026‑06‑14). Early plain‑stepper tests used a stock **DRV8825** module (see the
`DRV8825_TEST` / `updown_test_naru` design notes) — but **DRV8825 is an old,
standard module, not the new motor itself**, and the stepper sketch (`v052B`) is
still early development. IQ Motion Control now operates
as **Vertiq**; the small IQ modules are no longer easy to obtain, while the
industrial **Fortiq** line may still exist — confirm directly with the vendor.
(An even earlier prototype used an **Oriental Motor** αSTEP‑class motor driven via
MEXE02 / parallel‑I/O — useful background if you choose that vendor's closed‑loop
steppers.)

**Recommended replacement — an integrated closed‑loop stepper:**

- **MKS SERVO42C / SERVO42D** — NEMA17 closed‑loop stepper *driver with onboard
  MCU + magnetic encoder*. Supports **STEP/DIR pulse mode** *and* **serial /
  CAN with absolute/relative position** modes, holds position under load, and is
  **open source** (CC‑BY‑SA hardware, GPL firmware). NEMA23 size: **SERVO57D**.
- Or a plain **NEMA17/23 stepper + a separate closed‑loop driver** (Leadshine,
  StepperOnline "iHSS" integrated closed‑loop steppers, etc.).
- Convert rotation to the pedal push with a **leadscrew / rack** (the original IQ
  used a `meter_per_rad` transmission; a leadscrew gives the same linear push).

**Why a closed‑loop stepper fits.** The pedal must be **pushed to a position and
held there against the spring/reaction force** — exactly what the IQ servo did
and what a *closed‑loop* (not open‑loop) stepper also does. The anchoring
(airback) + "hold position" design carries over unchanged.

**Firmware adaptation tips (our opinion):**

1. **Easiest: STEP/DIR mode.** The `v052B` `move()` already bit‑bangs STEP and
   DIR. Wire the driver's **STEP / DIR / EN** to the Pico, set the driver's
   microstep, and **resolve the pin contradiction** first (the header says
   STEP=GP14/DIR=GP15 but `move()` uses 13/14 — pick one and make code+wiring
   agree). Calibrate `mm` (steps per 1 mm) to your **leadscrew pitch ×
   microsteps**.
2. **Cleaner: serial/absolute‑position mode.** MKS SERVO accepts an absolute
   position command over UART/CAN. Map the incoming `0–99` to an absolute target
   and send one command per update — this **restores the IQ‑style "go to
   position and hold"** model (closer to the old code's
   `trajectory_angular_displacement`) and lets you read encoder position/load
   back for the auto‑calibration.
3. **Lower‑limit by force still works.** Closed‑loop drivers report **load /
   power**, so the "drive down until reaction force rises → set `down_pos`"
   calibration can read load over serial. **Threshold on _power_, not current**
   (per the device co‑author): current changes with the supply voltage, whereas
   power stays consistent, so a commercial power supply can be used without
   re‑tuning. On the **IQ version the power is read by command from the IQ motor**;
   for a stepper successor the **power‑measurement method is not yet decided**.
   **Threshold value (v039B):** the pressing power is **piano‑dependent**, set by a
   **DIP switch** = **base 20 W + DIP (1 W steps) → 20–35 W** (20 W alone proved
   too weak; too strong makes the rod slip). A **50 mm travel cap** prevents the
   push‑rod from being driven out; the DIP switch also sets the lift above the
   hard stop (**5–20 mm**).
4. **Add an enable/limit safety.** Use the driver's stall/overcurrent and,
   ideally, a hardware limit so a mis‑set threshold can't over‑drive the rod.

Links: <https://github.com/makerbase-mks/MKS-SERVO42A> ·
MKS SERVO42D manual <https://manuals.plus/ae/1005005593922187> ·
IQ/Vertiq docs <https://iqmotion.readthedocs.io/> ·
Fortiq 42 <https://iqmotion.readthedocs.io/en/latest/modules/fortiq_42XX.html>

---

## 2. BLE board — nRF52 (Adafruit Bluefruit)

The original board is the **Adafruit ItsyBitsy nRF52840 Express** (the Switch
firmware drives its **onboard DotStar** RGB LED via `DATAPIN 8 / CLOCKPIN 6`). The
BLE sketch uses the **Adafruit Bluefruit** stack (`#include <bluefruit.h>`), so it
runs on any **Adafruit nRF52840** board with only board‑selection changes — keep
the ItsyBitsy if you want the onboard DotStar status colour.

- **Adafruit Feather nRF52840 Express** — current, well‑documented, easy to wire.
  <https://www.adafruit.com/product/4062>
- **Seeed Studio XIAO nRF52840** — very small (21 × 17.5 mm), low power; great if
  space is tight. Runs the Adafruit nRF52 core / Bluefruit.
- Also: **Adafruit ItsyBitsy nRF52840 Express** <https://www.adafruit.com/product/4481>.

**Firmware adaptation tips:** install the **Adafruit nRF52 BSP** in the Arduino
IDE, pick the board, and rebuild — the Bluefruit API (`BLEUart`, `setName`,
advertising, callbacks) is unchanged. **Re‑check pin numbers**: the sketch toggles
`GP13` for the direct on/off output and writes the UART on `Serial1` — map those
to your board's actual pin labels (the XIAO's pin map differs from the Feather's).

---

## 3. Main board — Raspberry Pi Pico / Pico 2

The Pico (RP2040) is current, and **Pico 2 (RP2350)** is the newer generation;
both are supported by the `arduino-pico` core. Little to change.

**Tip — watch the ADC pins (resolved by the schematic).** Some firmware reads
`A3`; on a stock Pico **`A3` (GP29) is the on‑board VSYS voltage divider**, not a
free analog input. The **circuit schematic** (see
[`hardware/schematic/`](hardware/schematic/)) puts the slider potentiometer on
**`ADC0` / GP26**, which is correct — so **align the firmware to the schematic
(slider on ADC0/GP26)** rather than `A3`. When consolidating the analog inputs
(motor power/load, air pressure, slider), also clean up the sketch's reuse of `A0`
for two purposes.

---

## 4. Sensors, MOSFET, air pump

- **HX711 + load cell** is current and cheap. Note the firmware currently mixes
  "HX711" with an analog current read — decide which is the real force/pressure
  sensor and wire accordingly (HX711 is a 2‑wire DOUT/SCK device, **not** I²C).
- **MOSFET + air pump** for the airback are generic; pick a logic‑level MOSFET
  rated for the pump current and a 12 V (typ.) diaphragm pump. Add a flyback
  diode across the pump.

---

## Sources

- IQ Motion Control / Vertiq docs — <https://iqmotion.readthedocs.io/>
- IQ Fortiq 42 module — <https://iqmotion.readthedocs.io/en/latest/modules/fortiq_42XX.html>
- IQ Motor Module (Crowd Supply, original) — <https://www.crowdsupply.com/iq-motion-control/iq-motor-module>
- MKS SERVO42 (open source) — <https://github.com/makerbase-mks/MKS-SERVO42A>
- MKS SERVO42D manual — <https://manuals.plus/ae/1005005593922187>
- Adafruit Feather nRF52840 Express — <https://www.adafruit.com/product/4062>
- Adafruit ItsyBitsy nRF52840 Express — <https://www.adafruit.com/product/4481>
- Raspberry Pi Pico series — <https://www.raspberrypi.com/products/raspberry-pi-pico/>
