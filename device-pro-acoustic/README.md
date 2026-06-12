# bFaaaP Pro — pedal driver for acoustic pianos

The **Pro** device physically presses an acoustic piano's **sustain (damper)
pedal** on command from the iOS app. A servo motor pushes the pedal; a 3D‑printed
frame holds everything in place over the pedals; an **airback** anchoring
mechanism keeps the whole unit from sliding under the motor's reaction force.

> For electric pianos / keyboards, see the sibling line
> [`../device-switch-electronic/`](../device-switch-electronic/) (planned).

## Contents

| Folder | What |
|--------|------|
| [`firmware/`](firmware/) | RP2040 / Raspberry Pi Pico firmware + the IQ motor library |
| [`hardware/`](hardware/) | Mechanical design: `cad/` (FreeCAD), `3d-print/` (STL/3MF), `airback/`, `enclosure-labels/` |
| [`motor/`](motor/) | Which motor to use + links to vendor docs |
| [`assembly/`](assembly/) | Build guide & bill of materials |
| [`HARDWARE-AVAILABILITY.md`](HARDWARE-AVAILABILITY.md) | ⚠️ EOL parts (IQ motor) + current replacements + firmware‑adaptation tips + links |

## How a press happens

1. The iOS app sends `N` (engage) / `iNN` (amount) / `F` (release) over BLE.
2. The Pico firmware drives the **IQ / Fortiq** servo motor to push the sustain
   pedal proportionally.
3. The **airback** (inflated once at setup) keeps the unit anchored so the motor
   pushes the pedal — not itself — away. See
   [`hardware/airback/`](hardware/airback/).

See [`../docs/architecture/`](../docs/architecture/) for the signal/BLE detail
and [`../docs/operation/`](../docs/operation/) for how to operate it.
