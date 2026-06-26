# Assembly guide & Bill of Materials

> The BOM below is reconstructed from the project's internal cost estimate
> (`bFaaaP_pro原価概算`). It reflects the **IQ‑motor generation**; see the notes
> for the stepper migration and EOL replacements
> ([`../HARDWARE-AVAILABILITY.md`](../HARDWARE-AVAILABILITY.md)).
> Step‑by‑step assembly photos/figures are still **TODO** (to be provided by the
> hardware author).

## Bill of materials

Approximate prices are JPY at build time (suppliers: 秋月電子 = Akizuki, アマゾン = Amazon,
Crowd Supply). Total ≈ **¥56,700** + power supply (¥2,000–7,600).

### Drive & motion

| Part | Spec | Notes |
|------|------|-------|
| **Motor** | **IQ‑FORTIQ‑M42BLS‑100** (IQ motor, 100 W) | Crowd Supply, ≈¥33,000. **EOL** → planned successor = a **NEMA17 ("17‑type") stepper** of the **same size** (so it fits the existing frame), driven **STEP/DIR** (see availability doc) |
| Lead screw + nut | **T10**, **lead 16 mm/rev**, **length 150 mm** | converts rotation → linear pedal push |
| Timing belt | **GT-2‑262** | motor → lead screw |
| Timing pulleys | **T60**, 5 mm (motor) & 10 mm (screw) bore | 1:1 |
| Bearings | flanged + thrust + collar | lead‑screw support |
| **Push‑rod assembly** | a **2040 extrusion, L = 75 mm**, with a **15 mm‑thick PLA** part on top (holds the lead‑screw **nut**) and a **PLA** part at the bottom (holds a **hard‑rubber** tip that contacts the pedal); **total length 115 mm** | the carriage that the nut drives down onto the sustain pedal |
| **Drive‑motor cooling fan** | small fan on **+5 V** (from the box) | cools the drive motor |

### Frame & enclosure

| Part | Spec |
|------|------|
| Aluminium extrusion | **4040** (60 mm), **2040** (200 mm), **2080** (200 mm) |
| T‑slot / brackets | 20 mm M3 T‑slot, 2020 corner brackets |
| 3D‑printed parts | **PLA+** filament (see [`../hardware/3d-print/`](../hardware/3d-print/)) |

### Anchoring (airback)

| Part | Spec | Notes |
|------|------|-------|
| **Air jack (airback)** | **WINBAG** air jack — 160 × 150 mm, up to 50 mm, **135 kg** | off-the-shelf inflatable anchor under a neighbouring pedal — see [`../hardware/airback/`](../hardware/airback/) for specs + where to buy |
| **Air pump** | a small **electric air pump inside the electronics box** — driven by the **2SK4017** MOSFET on **GP12**, switched by the panel **PUMP SW** | inflates the air jack through an **air tube**. The built device does **not** use the WINBAG's hand squeeze-bulb |
| Pneumatic tube | **air tube** from the box's pump to the WINBAG (+ the WINBAG's own bleed valve) | carries air from the box to the airback |

### Electronics

| Part | Spec | Notes |
|------|------|-------|
| **Main board** | **Raspberry Pi Pico** (RP2040) | motor/pump/sensor control |
| **BLE board** | **Akizuki `AE-NRF52840`** (g117484); **Adafruit Feather nRF52840** = compatible alternative | Bluetooth ↔ UART bridge to the Pico on **GP0/GP1**. *Not* the ItsyBitsy/DotStar — that's the **Switch** line's board (confirmed by Taguchi, 2026‑06‑24) |
| **Pump driver** | **n‑MOSFET 2SK4017** | GP12 → the **electric air pump** (in the box) |
| **Pressure sensor** | **HX711** (used as air‑pressure sensor) | air‑jack pressure feedback |
| **Upper‑limit input** | **slide potentiometer ("slide volume")** ✅ | sets the travel top; read on Pico **ADC0/GP26** (confirmed by the device co‑author) |
| **Hand controller link** | LAN connector + cable (RJ45) — *legacy* | listed in the original BOM but **currently unused** (per the device co‑author); the pot + switch are wired in directly |
| Misc | 8‑pin connector, tact switch, power switch, LED, resistors, capacitors, wire | |

### Power

| Part | Spec |
|------|------|
| PSU | **AC100 → DC24V** switching module (≈¥2,000; +5 V variants ≈¥2,600 / ¥7,600) |

> Migration note: the **planned successor** to the EOL IQ motor is a **NEMA17 ("17‑type")
> stepper of the same size** (so it reuses the existing frame), driven **STEP/DIR** (the team
> prototyped with a **DRV8825** driver; the stepper firmware `v052B` is still in development —
> a buildable version is **not yet finalised**). For currently‑available motor/driver/board
> choices and how they change the firmware, see [`../HARDWARE-AVAILABILITY.md`](../HARDWARE-AVAILABILITY.md).

## Build steps (outline)

1. Cut the aluminium extrusions and **print the parts** (`hardware/3d-print/`); assemble the frame.
2. Build the **vertical** drivetrain: **motor (offset) → GT-2‑262 belt over T60/T60 pulleys (1:1) →
   vertical T10 lead screw → carriage/nut → push‑rod** (presses straight down), with its bearings.
3. Fit the **air jack** under a neighbouring pedal and run the **air tube** from the box's **electric
   pump** (GP12 / 2SK4017, panel PUMP SW) to the WINBAG.
4. Wire the **Pico ↔ nRF52 board ↔ motor driver ↔ HX711 ↔ slider (via RJ45) ↔ 24 V PSU**
   (see [`../firmware/CODE-STRUCTURE.md`](../firmware/CODE-STRUCTURE.md) and the wiring notes).
5. **Flash** both boards ([`../../docs/toolchain/`](../../docs/toolchain/)).
6. Install the iOS app, pair, run the boot calibration (air‑jack → lower limit → slider), and test.

> TODO (from the hardware author): a clean single‑sheet wiring/schematic, fastener
> list, exploded assembly figures, and the stepper‑generation part numbers.
