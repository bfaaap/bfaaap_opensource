# Glossary — bFaaaP terms, in plain words

New to electronics, 3D printing, or app building? Here are the words you'll meet, explained
simply. (More terms will be added as the build guides grow.)

## The big picture
- **bFaaaP** — *barrier‑Free assist as a Pedal.* A system that presses a piano's sustain pedal
  for you, controlled by a small tilt of your head.
- **Sustain pedal** — the piano pedal (usually the right one) that lets notes keep ringing
  after you lift your fingers. bFaaaP operates this pedal.
- **Pro / Switch** — the two device versions. **Pro** physically presses an *acoustic* piano's
  pedal with a motor; **Switch** electronically switches the sustain on a *digital* piano.

## The app & sensing
- **iOS app** — the iPhone/iPad app that watches your head and sends commands. Drives both devices.
- **ARKit / TrueDepth** — Apple's face‑tracking technology (the Face‑ID camera). bFaaaP uses it
  to measure your **head angle**.
- **Head angle / threshold** — how far you tilt. When the tilt passes a set point (**threshold**)
  the pedal engages; you tune the threshold and speed to suit you.

## The link
- **BLE (Bluetooth Low Energy)** — short‑range wireless. The phone sends the head angle to the
  device over BLE.
- **Nordic UART Service (NUS)** — a common BLE "serial cable over Bluetooth" profile bFaaaP uses
  to send small text messages (`i00`–`i99` = 0–99 % tilt).
- **UART / `Serial1`** — a simple wired serial connection. Inside the device, the BLE board passes
  bytes to the main board over UART.

## The device (hardware)
- **Raspberry Pi Pico (RP2040)** — the cheap, popular microcontroller that is the device's **main
  board** (runs the motor, sensors, calibration).
- **nRF52840 (BLE board)** — a second small board that handles the Bluetooth side and bridges to
  the Pico.
- **Microcontroller** — a tiny computer on a chip that runs **firmware**.
- **Firmware** — the program that runs on the boards (written as Arduino **`.ino` sketches**).
- **arduino‑pico (Philhower) core** — the board‑support package that lets the Pico run Arduino code.
- **Closed‑loop motor / IQ‑Fortiq** — the Pro's motor; "closed‑loop" means it knows its own
  position/force, so it can press precisely. (The original is end‑of‑life; a stepper successor is
  planned.)
- **Airback** — an air‑cushion that gently holds the Pro device in place by pressing a neighbouring
  pedal, so nothing is screwed to the piano.
- **HX711** — a tiny amplifier chip that reads the air‑pressure sensor.
- **MOSFET (2SK4017)** — an electronic switch the Pico uses to turn the air pump on/off.
- **DIP switch** — a row of tiny physical switches on the board used to set the pedal **pressing
  force** (≈20–35 W) and lift distance.

## Making the parts
- **3D printing / STL / slicer / G‑code** — the mechanical parts are **3D‑printed**. You open an
  **STL** model in a **slicer** (e.g. Bambu Studio, PrusaSlicer), which turns it into **G‑code**
  the printer follows.
- **CAD / FreeCAD (`.FCStd`)** — the editable 3D design files (open them to modify a part).
- **KiCad / schematic** — the electronics wiring diagram (and the tool that draws it).
- **BOM (bill of materials)** — the shopping list of parts.

## Licensing
- **Apache‑2.0 / CERN‑OHL‑W / CC‑BY** — the open licences for the **software / hardware /
  documentation** layers. See [`../LICENSE`](../LICENSE).

→ Back to [How it works](how-it-works.md) · [Build it yourself](build/) · [The story](story.md)
