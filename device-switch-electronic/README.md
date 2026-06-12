# bFaaaP Switch — for electric pianos & keyboards

The **Switch** line targets **electric pianos and keyboards**. Instead of a motor
physically pressing an acoustic pedal (the Pro approach), it actuates the
instrument's sustain **electronically**: it plugs into the digital piano /
keyboard's **sustain‑pedal jack** and acts as the pedal **switch** (closing /
opening the sustain circuit on command).

Because there is **no motor, no lead screw, and no airback**, the Switch is much
simpler than the Pro — essentially the **BLE board on its own** (an **Adafruit
ItsyBitsy nRF52840 Express**), using its direct on/off output (the firmware drives
`GP13` on `N`/`F`; see
[`../device-pro-acoustic/firmware/`](../device-pro-acoustic/firmware/)). The
board's **onboard DotStar RGB LED** shows the engage state as a colour on the
device itself (mirroring the app's white→red indicator).

The **same iOS app** drives this line — identical head‑angle tracking and BLE
protocol as the Pro (`N` engage / `F` release; `iNN` is unused for a simple
on/off switch). When the player tilts past the threshold the app's indicator
turns **red** and the sustain engages; head up → released.

> Demo (electric piano): <https://www.youtube.com/watch?v=Im4jsed1tJQ>
> · Project site: <https://bfaaap.com>

## How it works

```
 iOS app ──BLE (N / F)──▶ BLE board (nRF52) ──GP13 on/off──▶ relay / opto
                                                              │
                                                              ▼
                                              digital piano sustain‑pedal jack
```

A relay or opto‑isolator on the BLE board's `GP13` output bridges the sustain
jack's contacts — the same wiring most digital pianos expect from a normal
momentary sustain pedal (tip/sleeve). Polarity / normally‑open vs normally‑closed
is handled by the on‑type / off‑type setting (`n` / `f`).

## Connection & certification

- The device cable ends in a **6.3 mm 2‑pole (TS) phone plug**; it plugs into the
  electric piano's **SUSTAIN** pedal jack (3‑pedal "PEDAL UNIT" jacks differ).
- The shipped Switch device carries Japan radio certification **技適 R018‑180280**.
- **On‑type / Off‑type**: some pianos invert the sustain logic — flip it with the
  app's On/Off button.
- Full end‑user steps: [`../docs/user-manual/`](../docs/user-manual/) ·
  manual video <https://youtu.be/XOVENtBsOp4>.

## Status

Hardware specifics for the Switch (exact relay/opto, jack wiring, enclosure) are
**TODO** — to be confirmed with the hardware author (Narusawa). The core is the
shared BLE board; planned additions:

```
device-switch-electronic/
├── firmware/    (shared BLE-board firmware; on/off via GP13)
├── hardware/    (relay/opto + sustain-jack adapter + enclosure)
└── assembly/
```

See the shared [`../docs/architecture/`](../docs/architecture/) for the BLE
protocol and [`../ios-app/`](../ios-app/) for the controller.
