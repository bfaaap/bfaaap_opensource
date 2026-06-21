# Toolchain — flashing, testing & running (VSCode‑centric)

> 🌐 **English** · [日本語](../../i18n/ja/docs/toolchain/README.md) · [Deutsch](../../i18n/de/docs/toolchain/README.md)

This project has **three different build targets**, each with its own tooling:

| Target | What you "write/flash" | Tool |
|--------|------------------------|------|
| **iOS app** | a signed app to an iPhone/iPad | **Xcode on a Mac** → see [`../../ios-app/BUILD.md`](../../ios-app/BUILD.md) (not covered here) |
| **BLE board** (nRF52 / Bluefruit) | firmware (`.uf2`/DFU) | VSCode + PlatformIO **or** Arduino extension |
| **Main board** (RP2040 / Pico) | firmware (`.uf2`) | VSCode + PlatformIO **or** Arduino extension |
| **Mechanical parts** | **G‑code** to a 3D printer | a **slicer** (PrusaSlicer / Cura / OrcaSlicer / Bambu Studio) — *not* a code editor |

The boards run **Arduino `.ino`** sketches, so any Arduino‑compatible toolchain
works. Below is a VSCode‑based setup.

---

## 0. Install VSCode + one embedded extension

Pick **one** of:

- **PlatformIO IDE** (VSCode extension) — self‑contained toolchains, board
  manager, serial monitor, and debugger in one place. Most reproducible. It
  prefers a `platformio.ini` project (examples below).
- **Arduino extension for VSCode** (wraps the Arduino CLI) — closest to the
  original `.ino` workflow; reuses the same board packages as the Arduino IDE.
  Good if you want to open the `.ino` files as‑is.

(If you just want the simplest possible path, the **Arduino IDE** itself also
works and uses the identical board packages — VSCode is optional.)

---

## 1. Board support packages (install once)

| Board | Arduino board package | PlatformIO |
|-------|-----------------------|------------|
| Adafruit Feather/ItsyBitsy **nRF52840** | "**Adafruit nRF52**" BSP (Boards Manager) | `platform = nordicnrf52`, `board = adafruit_feather_nrf52840` |
| Raspberry Pi **Pico / Pico 2** | "**Raspberry Pi Pico/RP2040** (arduino‑pico, by Earle Philhower)" | `board_build.core = earlephilhower` (see note) |

> The sketches assume the **arduino‑pico (Philhower)** core (they use `Serial1`,
> `Serial2`, `analogReadResolution`, etc.) — *not* the Arduino "Mbed" core.

---

## 2. nRF52 BLE board — flash & test

**Flashing (USB).** The Adafruit nRF52 boards ship with a UF2 bootloader:

1. Connect the board by USB.
2. **Double‑tap the RESET button** → a USB drive named like `FTHR840BOOT`
   appears.
3. **PlatformIO:** `PlatformIO: Upload` (it builds and flashes via
   `adafruit-nrfutil` over the bootloader serial port).
   **Arduino extension / IDE:** select the board + port, click **Upload**.
   (Manual fallback: drag the built `.uf2` onto the boot drive.)

Example `platformio.ini`:

```ini
[env:feather_nrf52840]
platform = nordicnrf52
board = adafruit_feather_nrf52840
framework = arduino
monitor_speed = 115200
upload_protocol = nrfutil
; Bluefruit (BLEUart, BLEDfu, …) ships with the Adafruit nRF52 framework — no lib_deps needed
```

**Testing / running:**

- **Serial Monitor @ 115200** (PlatformIO: `PlatformIO: Monitor`; Arduino ext:
  Serial Monitor) to see debug output.
- **Verify BLE** with a phone BLE scanner (**nRF Connect** or **LightBlue**): you
  should see it advertise as `bFaaaPSwitch_1` and expose the Nordic UART service
  `6E400001‑…`. Or just connect with the **bFaaaP iOS app**.
- **OTA updates:** the firmware includes `BLEDfu`, so after the first USB flash
  you can also update over the air with nRF Connect (DFU) if convenient.

---

## 3. RP2040 / Pico main board — flash & test

**Flashing (USB / BOOTSEL).**

1. Hold the **BOOTSEL** button while plugging in USB → a drive `RPI‑RP2` appears.
2. **PlatformIO:** `PlatformIO: Upload`. **Arduino ext/IDE:** select the Pico
   board + port → **Upload**. (Manual fallback: drag the `.uf2` onto `RPI‑RP2`.)
3. After the first flash, the arduino‑pico core can re‑flash over USB without the
   button.

Example `platformio.ini` (arduino‑pico / Philhower core):

```ini
[env:pico]
; community platform that bundles the Philhower core:
platform = https://github.com/maxgerhardt/platform-raspberrypi.git
board = pico            ; use 'pico2' for Pico 2 / RP2350
framework = arduino
board_build.core = earlephilhower
monitor_speed = 115200
lib_deps =
    bogde/HX711         ; for the load-cell version
    ; (IQ-motor version also needs the iq-module-communication library, see firmware/libraries)
```

**Testing / running:**

- **Serial Monitor @ 115200** shows the firmware's prints (sensor currents,
  positions, calibration messages).
- **Drive it without the app:** the main board normally receives bytes from the
  BLE board over the wired **UART (`Serial1`)**. To bench‑test, either (a) wire
  the BLE board and send `iNN` from the iOS app/BLE scanner, or (b) temporarily
  feed test bytes into `Serial1` from a USB‑UART adapter.
- ⚠ The latest stepper sketch (`v052B`) is a development snapshot and won't
  compile unmodified — see the caveats in
  [`../../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md`](../../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md).

### Using the `.ino` files with PlatformIO

PlatformIO normally expects `src/main.cpp`. To use the Arduino sketches, either
keep the sketch as `src/<name>.ino` (PlatformIO accepts `.ino` with the
`arduino` framework) **or** rename it to `.cpp` and add `#include <Arduino.h>`.
The Arduino VSCode extension uses the `.ino` files directly with no changes.

---

## 4. Libraries summary

| Firmware | Needs |
|----------|-------|
| BLE board | **Bluefruit** (comes with the Adafruit nRF52 framework) |
| Main board, IQ version (v039B) | **HX711** + **iq‑module‑communication** (see `device-pro-acoustic/firmware/libraries/`) |
| Main board, stepper version (v052B) | **HX711**; STEP/DIR needs no motor library (raw GPIO), or a closed‑loop driver's own lib |

---

## 5. 3D printer — slicing, not "flashing code"

A 3D printer is not programmed like a microcontroller. You **slice** a model into
**G‑code** and send that to the printer:

1. Open an `.stl` from
   [`../../device-pro-acoustic/hardware/3d-print/`](../../device-pro-acoustic/hardware/3d-print/)
   in a **slicer** (PrusaSlicer, Cura, OrcaSlicer, or Bambu Studio). The `.3mf`
   files also carry reference print settings.
2. Choose material, layer height, infill, supports, orientation; **slice**.
3. **Send the G‑code** to the printer by SD card / USB stick, USB‑serial, or over
   the network (OctoPrint / Klipper / Bambu / the printer's own UI).

VSCode's role here is optional (some G‑code *preview* extensions exist), but the
slicing itself is done in the slicer GUI. See
[`../../device-pro-acoustic/hardware/3d-print/`](../../device-pro-acoustic/hardware/3d-print/).

---

## 6. End‑to‑end bring‑up (quick checklist)

1. Flash the **BLE board** (nRF52); confirm it advertises `bFaaaPSwitch_1` in a BLE scanner.
2. Flash the **main board** (Pico); watch its Serial Monitor.
3. Wire **BLE board ↔ Pico** (UART) and common ground; power the motor/driver.
4. Build & run the **iOS app** (Xcode, your own team); connect to the device.
5. Tilt your head → watch `iNN`/`N`/`F` in the BLE board's monitor and the motor move.

## Reference links

- PlatformIO — <https://platformio.org/>
- Arduino extension for VSCode — <https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.vscode-arduino>
- Adafruit nRF52 Arduino BSP — <https://github.com/adafruit/Adafruit_nRF52_Arduino>
- arduino‑pico (Philhower) core — <https://github.com/earlephilhower/arduino-pico>
- PlatformIO RP2040 (Philhower) platform — <https://github.com/maxgerhardt/platform-raspberrypi>
- PrusaSlicer — <https://www.prusa3d.com/prusaslicer/> · OrcaSlicer — <https://github.com/SoftFever/OrcaSlicer> · Cura — <https://ultimaker.com/software/ultimaker-cura/>
