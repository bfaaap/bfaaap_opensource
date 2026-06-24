# Switch firmware (standalone BLE on/off)

The **Switch** device needs **only one board** — the **nRF52 BLE board** — because
it actuates a digital piano's sustain **electronically** (no motor, no Pico, no
airback). This is the firmware that runs on it.

> Firmware by **Hiroyuki Narusawa**. Contributed for the open-source release on
> 2026-06-24; sketch dated **2021-10-07**.

## Sketch

| Sketch | Board | Role |
|--------|-------|------|
| [`bFaaaPSW_20211007_for_ex_fs_J_13_ymc/`](bFaaaPSW_20211007_for_ex_fs_J_13_ymc/) | **nRF52** (Adafruit Bluefruit) | **Standalone Switch** — BLE in → on/off the sustain line on **GP13**. |

> The folder name matches the `.ino` name so it opens directly in the Arduino IDE.
> `for_ex_fs` = "for **ex**ternal **f**oot **s**witch"; `J_13` = the on/off output
> is **pin 13 (GP13)**; the trailing tag is the maker's initials.

### Relationship to the Pro BLE board

This is the **same nRF52 BLE-board code family** as the Pro's
[`bFaaaPpro_BLE_2024010309_bord_A.ino`](../../device-pro-acoustic/firmware/pico/bFaaaPpro_BLE_2024010309_bord_A.ino),
but **standalone**: it keeps the `N`/`F` direct on/off on **GP13** and **omits**
the `iNN`→`Serial1` proportional bridge to a Pico (the Switch has no motor board).
Same Nordic UART Service, same `bFaaaPSwitch_1…4` advertising names, same channel
storage — so the **same iOS app** drives either line unchanged.

## Board

**Adafruit ItsyBitsy nRF52840 Express** (Bluefruit / Nordic nRF52840). Evidence in
the sketch: the **onboard DotStar** RGB LED is driven on `DATAPIN 8 / CLOCKPIN 6`,
the wake pin is `PIN_A1`, and the switched output is `13`. This DotStar/ItsyBitsy
board is specifically the **Switch** line's board — the **Pro** uses the Akizuki
**AE‑NRF52840** (Feather alternative) and has no LED routine (confirmed by Taguchi,
2026‑06‑24).

Libraries: `bluefruit.h` (Adafruit nRF52 / Bluefruit), `Adafruit_LittleFS` +
`InternalFileSystem` (stores the channel), `Adafruit_DotStar` (status LED).

## BLE

- **Service:** Nordic UART Service (NUS)
  - Service UUID `6e400001-b5a3-f393-e0a9-e50e24dcca9e`
  - Characteristic `6e400002-b5a3-f393-e0a9-e50e24dcca9e`
- Also exposes **OTA DFU** (`BLEDfu`), **Device Information** (`BLEDis`:
  manufacturer "bFaaaP factory", model "pFaaaPSwitch") and **Battery** (`BLEBas`,
  currently written as a fixed `100`).
- TX power `-4 dBm`; advertising interval `32–244 × 0.625 ms` (≈ 20–152 ms);
  fast-advertise timeout 30 s; advertising restarts on disconnect.

## Command protocol (single ASCII bytes over NUS)

The iOS app writes one byte at a time:

| Byte | Char | Action |
|------|------|--------|
| `0x4E` | `N` | **Engage** sustain — `GP13` HIGH in *on-mode* / LOW in *off-mode* |
| `0x46` | `F` | **Release** sustain — `GP13` LOW in *on-mode* / HIGH in *off-mode* |
| `0x6E` | `n` | Set **on-mode** (normal polarity) |
| `0x66` | `f` | Set **off-mode** (inverted polarity — for pianos with reversed sustain logic) |
| `0x57` | `W` | Select **channel 1** (advertise as `bFaaaPSwitch_1`), then deep-sleep to reboot |
| `0x58` | `X` | Select **channel 2** (`bFaaaPSwitch_2`), then deep-sleep |
| `0x59` | `Y` | Select **channel 3** (`bFaaaPSwitch_3`), then deep-sleep |
| `0x5A` | `Z` | Select **channel 4** (`bFaaaPSwitch_4`), then deep-sleep |
| `0x50` | `P` | **Power off** (deep sleep) |

> A commented-out `C…/` command (set the status-LED colours from an RGB string) is
> present but disabled. There is **no `iNN` / motor path** in this sketch.

## Output → sustain jack

`GP13` is the on/off output. For a digital piano you bridge the instrument's
**sustain-pedal jack** (commonly a 6.3 mm / TS jack) with a **ROHM `RU1J002YN`**
N-channel MOSFET driven from `GP13` (confirmed by Narusawa, 2026‑06‑24 — *not* a
relay or optocoupler), with **no series resistor** on the sustain line. The
`RU1J002YN` is a **0.9 V-drive logic-level** part (Vgs(th) = 0.3–0.8 V; 50 V /
±200 mA; R_DS(on) ≤ 2.2 Ω; **UMT3F / SOT-323FL** package with a built-in ESD
protection diode — [ROHM datasheet](https://www.rohm.com/products/transistors/mosfets/standard/ru1j002yn-product)),
so the **3.3 V `GP13`** output drives it fully on. The **on-mode / off-mode**
(`n`/`f`) selects normally-open vs normally-closed so it matches the host
instrument's polarity.

> Wiring: a standard **low-side switch** — gate ← `GP13`, drain/source across the
> TS jack's tip/sleeve, **no series resistor**. (Narusawa is preparing the exact
> reference-circuit drawing.)

## Channels (run several at once)

Up to **four** identities `bFaaaPSwitch_1…4` let you pair multiple Switch devices
(or distinguish pedals) without collision. The selected channel is stored in the
nRF52's internal LittleFS file `/W.txt` and applied on the next boot.

## Status LED (onboard DotStar)

The single onboard DotStar mirrors the app's indicator: a slow **blink while
advertising / waiting**, a steady colour **when connected / released**, and a
different colour **while the sustain is engaged**. Brightness drops once connected.

## Power management

- **Deep sleep** (`sd_power_system_off`) when: no central connects within ~30 s of
  power-on; on the `P` command; on a channel change; or when the **A1 button is
  held LOW for ≥ 5 s**.
- **Wake:** the firmware wakes on **`A1` → GND** (`INPUT_PULLUP_SENSE`), **but the
  shipped Switch has no A1 button** (confirmed by Narusawa, 2026‑06‑24) — you
  **power on / wake it with the board's RESET button**. The A1 code path is
  optional/unused in the built device.
- **Battery:** **2× AA cells** (replaceable primary cells — *not* a USB-charged
  LiPo; confirmed by Narusawa, 2026‑06‑24). Remaining charge is **shown by the
  onboard DotStar dimming** as the cells deplete (no numeric fuel gauge —
  consistent with the firmware writing a fixed `100%` over BLE).

## Build / flash

Install the **Adafruit nRF52** board support, double-tap **RESET** to enter the
UF2 bootloader, and upload the sketch. Full VSCode/Arduino steps:
[`../../docs/toolchain/`](../../docs/toolchain/). The on-the-wire BLE protocol is
shared with the controller — see [`../../docs/architecture/`](../../docs/architecture/)
and the [iOS app](../../ios-app/).

## Hardware — confirmed by Narusawa (2026-06-24)

- **Board:** Adafruit **ItsyBitsy nRF52840 Express** (confirmed).
- **Switching element on GP13:** a **ROHM `RU1J002YN`** N-channel logic-level MOSFET (not a relay/opto).
- **Sustain line:** **no series resistor**; polarity handled by on/off-mode (`n`/`f`).
- **Controls:** **no A1 button** — power on / wake with the **RESET** button.
- **Power:** **2× AA cells** (replaceable, not USB-rechargeable); battery level
  shown by the **DotStar dimming** (no numeric gauge).
- **Firmware:** the **2021-10-07** sketch is the **final/current** version.

## Open questions (residual, for a full rebuild)

- **Nothing blocking.** The switching MOSFET is the **ROHM `RU1J002YN`** (no series
  resistor). The only nicety still to add is Narusawa's exact reference-circuit
  drawing of the low-side switch, which he is preparing.

---
**License (adopted):** firmware is released under the **Apache License 2.0**
(explicit patent grant). See [`../../LICENSE`](../../LICENSE).
