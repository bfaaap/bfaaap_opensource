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

**Identified parts (from the project BOM + firmware; BLE board & pin map confirmed
by Taguchi from the KiCad schematic, 2026‑06‑24):** BLE board = **Akizuki
`AE-NRF52840`** (the **Adafruit Feather nRF52840** is a compatible alternative; the
Pro firmware has **no LED routine** — the **ItsyBitsy** with its onboard DotStar on
`DATAPIN 8 / CLOCKPIN 6` is the **Switch** line's board, see
[`../../device-switch-electronic/firmware/`](../../device-switch-electronic/firmware/));
main board = **Raspberry Pi Pico**; motor = **M42BLS** (`IQ‑FORTIQ‑M42BLS`, 100 W)
on **+24 V** over a serial pair (`H1_RX` / `H2_TX`); pump driver = **n‑MOSFET
2SK4017** on GP12; air‑pressure sensor = **HX711**; pedal reaction force = from
**motor _power_** (not current — power is supply‑voltage‑robust; on the IQ version
the power is read **by command from the IQ motor**); upper‑limit input = a
hand‑controller **slide potentiometer ("slide volume")** on **ADC0/GP26**
(confirmed; the body's RJ45/LAN socket is currently unused). The **next**
generation will use a closed‑loop stepper with a **DRV8825‑compatible** STEP/DIR
interface (**specific motor model not yet decided**; DRV8825 itself is the old
standard module used only in early plain‑stepper tests); the v052B stepper sketch
is early development and a buildable version is **not currently available**. See
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
   keyboard ("Switch" use), a relay/opto on GP13 is all you need. The
   **standalone Switch firmware** (this BLE-board code without the bridge) lives in
   [`../../device-switch-electronic/firmware/`](../../device-switch-electronic/firmware/).
2. **Bridge for proportional control** — on `iNN` it converts the two ASCII
   digits to **one binary byte (0–99)** and sends it over `Serial1` to the main
   board, which positions the motor proportionally ("Pro" use).

## Main board responsibilities (Pico)

- Receive the 0–99 byte over UART and map it to a pedal position.
- Drive the motor (IQ trajectory control in v039B; STEP/DIR stepper in v052B).
- At boot: **anchor** the unit with the air jack, then **auto‑calibrate** the
  mechanical top/bottom limits using motor‑current sensing.

## Pin map — IQ / v039B reference ✅ confirmed (Taguchi, KiCad schematic, 2026‑06‑24)

This is the **authoritative** Pico pin map for the IQ reference generation, read
directly from the schematic and confirmed by Taguchi. Full sheet:
[`../hardware/schematic/`](../hardware/schematic/).

| Signal | Pico pin | Connects to |
|--------|----------|-------------|
| BLE ↔ Pico UART (`Serial1`) | **GP0 / GP1** | the BLE board |
| HX711 clock / data (air pressure) | **GP2 / GP3** | air‑jack pressure sensor |
| IQ motor serial (`H1_RX` / `H2_TX`, `Serial2`) | **GP4 / GP5** | M42BLS motor |
| Air‑pump MOSFET (Q1, 2SK4017) gate | **GP12** | air pump (+5 V) |
| Upper‑limit slider (RV1 wiper) | **GP26 / ADC0** | slide potentiometer |
| Power | **+5 V (logic) & +24 V (motor)**; **SW1 → `VSYS`** | dual‑rail SMPS |

## Pin map — v052B stepper (as found — ⚠ WIP, verify before building)

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
