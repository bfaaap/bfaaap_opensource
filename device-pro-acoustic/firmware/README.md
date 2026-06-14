# Device firmware (pedal driver)

The device runs **two firmwares on two boards**:

1. a **BLE board** (nRF52 / Adafruit Bluefruit) that terminates Bluetooth and
   bridges to a wired UART, and
2. a **main board** (RP2040 / Pico) that drives the motor, the air‑jack pump,
   and the sensors.

> Read first: [`CODE-STRUCTURE.md`](CODE-STRUCTURE.md) (architecture, data path,
> pin map) and [`DESIGN-HIGHLIGHTS.md`](DESIGN-HIGHLIGHTS.md) (flowcharts,
> sync vs async, key design points). Firmware by **Hiroyuki Narusawa**.

## Contents

```
firmware/
├── pico/        Arduino sketches (.ino) — BLE board + main board
└── libraries/
    └── iq-module-communication-arduino/   IQ Motion Control library (third-party, IQ-motor version only)
```

## Sketches

| Sketch | Board | Notes |
|--------|-------|-------|
| `bFaaaPpro_BLE_2024010309_bord_A.ino` | nRF52 (Bluefruit) | BLE↔UART bridge + direct on/off (GP13) |
| `bFaaaP_autopro_pico_v039B_20250725.ino` | RP2040 / Pico | **IQ / Fortiq motor** version — **the current reference design** ✅ |
| `…_v039B_…_shishido_v.ino` | RP2040 / Pico | v039B variant |
| `bFaaaP_autopro_pico_v052B_step_20251111.ino` | RP2040 / Pico | **stepper** version — ⚠ **early development snapshot, do not build/use** |

> ⚠ **Which version to use (per the device co‑author):** the **reference is the IQ
> version (v039B)**. The IQ / Fortiq motor is now **discontinued**, so the
> **next** version will use a **closed‑loop stepping motor** (which exposes a
> **DRV8825‑compatible** STEP/DIR interface; **the specific motor model is not yet
> decided**; DRV8825 itself is an old, standard module used only in early
> plain‑stepper tests). That stepper sketch (**v052B**) is **still early
> development and intentionally buggy, and a buildable stepper version is not
> currently available — it should not be analysed or built as a reference**; see
> the caveats in `DESIGN-HIGHLIGHTS.md`. The IQ library below applies only to the
> v039B (IQ) version.

## Dependency: IQ module library (v039B only)

`libraries/iq-module-communication-arduino/` is the
[IQ Motion Control](https://www.iq-control.com/) Arduino library (v1.2.1). It
keeps its **own LICENSE** — do not relicense it.

## Build / flash

Full VSCode‑centric flashing/testing steps (PlatformIO or the Arduino extension),
including `platformio.ini` examples and how to run/monitor each board, are in
**[`../../docs/toolchain/`](../../docs/toolchain/)**. In short:

**BLE board (nRF52):** install the **Adafruit nRF52** support, double‑tap RESET
to enter the UF2 bootloader, and upload the BLE sketch.

**Main board (Pico):** install the **arduino‑pico (Philhower)** core; for the IQ
version also add the IQ library. Hold **BOOTSEL**, upload, verify pins/parameters.

> TODO before publishing: exact wiring (motor driver ↔ Pico, BLE board ↔ Pico),
> pinned board‑core/library versions, motor & driver part numbers, and the
> calibration constants. Tracked in the project's reproducibility gap analysis.
