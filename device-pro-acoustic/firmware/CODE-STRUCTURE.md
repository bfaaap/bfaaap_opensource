# Firmware — code structure

> English first; 日本語・ドイツ語版は後日 `i18n/` 配下に追加予定。
> Firmware by **Hiroyuki Narusawa**.

The device uses **two microcontrollers**, not one:

```
 iOS app ──BLE (Nordic UART)──▶  BLE board (nRF52 / Adafruit Bluefruit)
                                      │  GP13 ── direct on/off output (simple switch use)
                                      │
                                      └──UART (Serial1, 1 byte 0–99)──▶ Main board (RP2040 / Pico)
                                                                            ├─ stepper / IQ motor → pedal push-rod
                                                                            ├─ MOSFET (GP12) → air pump (anchoring)
                                                                            └─ current / pressure sensing (ADC)
```

So the iOS app never talks to the motor board directly — the **BLE board is a
bridge**: it terminates Bluetooth, and forwards a compact 1‑byte value to the
main board over a wired UART.

**Identified parts (from the project BOM + firmware):** BLE board = **Adafruit
ItsyBitsy nRF52840 Express** (the Switch firmware drives its **onboard DotStar**
on `DATAPIN 8 / CLOCKPIN 6`; pin labels `13/USB/G/B/3V/RST` match the internal
wiring sketch); main board = **Raspberry Pi Pico**; pump driver = **n‑MOSFET
2SK4017** on GP12; air‑pressure sensor = **HX711**; pedal reaction force =
analog motor‑current sense; upper‑limit input = a **slide potentiometer** wired
in (via an RJ45/LAN cable from the hand controller). Stepper generation (v052B)
prototyped with a **DRV8825** STEP/DIR driver. See
[`../assembly/`](../assembly/) for the full BOM and
[`../HARDWARE-AVAILABILITY.md`](../HARDWARE-AVAILABILITY.md) for replacements.

## Sketches

| Sketch | Board | Role |
|--------|-------|------|
| `bFaaaPpro_BLE_2024010309_bord_A.ino` | **nRF52** (Adafruit Bluefruit) | BLE ↔ UART bridge. Advertises `bFaaaPSwitch_1…4`, NUS, OTA DFU, battery. Also drives **GP13 directly** for on/off. |
| `bFaaaP_autopro_pico_v039B_20250725.ino` | **RP2040 / Pico** | Main board, **IQ / Fortiq motor** version. |
| `bFaaaP_autopro_pico_v052B_step_20251111.ino` | **RP2040 / Pico** | Main board, **closed‑loop stepper** version (latest; IQ motor was discontinued). ⚠ development snapshot — see notes. |
| `…_v039B_…_shishido_v.ino` | RP2040 / Pico | A variant of v039B. |

## Two roles of the BLE board

The BLE board is interesting because it can act as the whole device for the
simple case:

1. **Direct on/off** — on `N`/`F` it toggles `GP13`. For an electric piano /
   keyboard ("Switch" use), a relay/opto on GP13 is all you need.
2. **Bridge for proportional control** — on `iNN` it converts the two ASCII
   digits to **one binary byte (0–99)** and sends it over `Serial1` to the main
   board, which positions the motor proportionally ("Pro" use).

## Main board responsibilities (Pico)

- Receive the 0–99 byte over UART and map it to a pedal position.
- Drive the motor (IQ trajectory control in v039B; STEP/DIR stepper in v052B).
- At boot: **anchor** the unit with the air jack, then **auto‑calibrate** the
  mechanical top/bottom limits using motor‑current sensing.

## Pin map (as found — verify before building)

| Signal | BLE board | Main board (v052B) |
|--------|-----------|--------------------|
| BLE data UART | — | `Serial1` GP00/GP01 *(see note)* |
| On/off output | GP13 | — |
| Motor STEP / DIR | — | GP13 / GP14 in code, GP14 / GP15 in header — **contradiction** |
| Air pump (MOSFET) | — | GP12 |
| Current / pressure | — | ADC A0 / A1 |

> ⚠ The latest stepper sketch (v052B) has pin/serial contradictions, missing
> `#include`s and undefined constants — it is a work in progress. See the
> reproducibility gap analysis (project notes) and
> [`DESIGN-HIGHLIGHTS.md`](DESIGN-HIGHLIGHTS.md) for the intended behaviour and
> the open questions.

For the on‑the‑wire BLE protocol see [`../../docs/architecture/`](../../docs/architecture/).
