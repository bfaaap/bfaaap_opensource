# bFaaaP Switch — for electric pianos & keyboards

The **Switch** line targets **electric pianos and keyboards**. Instead of a motor
physically pressing an acoustic pedal (the Pro approach), it actuates the
instrument's sustain **electronically**: it plugs into the digital piano /
keyboard's **sustain‑pedal jack** and acts as the pedal **switch** (closing /
opening the sustain circuit on command).

Because there is **no motor, no lead screw, and no airback**, the Switch is much
simpler than the Pro — essentially the **BLE board on its own** (an **Adafruit
ItsyBitsy nRF52840 Express**), using its direct on/off output (the firmware drives
`GP13` on `N`/`F`). The standalone Switch firmware now lives here in
[`firmware/`](firmware/) (the same nRF52 BLE-board code as the Pro, minus the
motor-board bridge). The board's **onboard DotStar RGB LED** shows the engage
state as a colour on the device itself (mirroring the app's white→red indicator).

The **same iOS app** drives this line — identical head‑angle tracking and BLE
protocol as the Pro (`N` engage / `F` release; `iNN` is unused for a simple
on/off switch). When the player tilts past the threshold the app's indicator
turns **red** and the sustain engages; head up → released.

> Demo (electric piano): <https://www.youtube.com/watch?v=Im4jsed1tJQ>
> · Project site: <https://bfaaap.com>

## How it works

```
 iOS app ──BLE (N / F)──▶ BLE board (nRF52) ──GP13 on/off──▶ MOSFET
                                                              │
                                                              ▼
                                              digital piano sustain‑pedal jack
```

A **MOSFET** on the BLE board's `GP13` output bridges the sustain jack's contacts
(confirmed by Narusawa, 2026‑06‑24 — **no series resistor**) — the same wiring most
digital pianos expect from a normal momentary sustain pedal (tip/sleeve). Polarity
/ normally‑open vs normally‑closed is handled by the on‑type / off‑type setting
(`n` / `f`).

## Connection & certification

- The device cable ends in a **6.3 mm 2‑pole (TS) phone plug**; it plugs into the
  electric piano's **SUSTAIN** pedal jack (3‑pedal "PEDAL UNIT" jacks differ).
- The shipped Switch device carries Japan radio certification **技適 R018‑180280**.
- **On‑type / Off‑type**: some pianos invert the sustain logic — flip it with the
  app's On/Off button.
- Full end‑user steps: [`../docs/user-manual/`](../docs/user-manual/) ·
  manual video <https://youtu.be/XOVENtBsOp4>.

## Status

The **firmware is now in the repo** — see [`firmware/`](firmware/) for the
standalone nRF52 sketch (`bFaaaPSW_20211007_for_ex_fs_J_13_ymc`), its full BLE
command protocol, the GP13 on/off behaviour, channel selection, and power
management. What is **still TODO** is the **hardware** around it:

```
device-switch-electronic/
├── firmware/    ✅ standalone BLE-board firmware (on/off via GP13)  ← added 2026-06-24
├── hardware/    ◑ MOSFET on GP13 + sustain-jack adapter + enclosure (key facts known)
└── assembly/    ⏳
```

**Confirmed by Narusawa (2026‑06‑24):** board = **ItsyBitsy nRF52840 Express**; the
GP13 switching element is a **MOSFET** (no series resistor); **no A1 button** — power
on / wake with **RESET**; powered by **2× AA cells** (battery level shown by the
**DotStar dimming**); the 2021‑10‑07 firmware is **final**. Still to confirm: the
**exact MOSFET part + its wiring to the TS jack** (Narusawa is checking) — see "Open
questions" in [`firmware/README.md`](firmware/README.md).

See the shared [`../docs/architecture/`](../docs/architecture/) for the BLE
protocol and [`../ios-app/`](../ios-app/) for the controller.
