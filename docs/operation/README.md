# Operating bFaaaP

> 🌐 **English** · [日本語](../../i18n/ja/docs/operation/README.md) · [Deutsch](../../i18n/de/docs/operation/README.md)

A short guide to using the system day to day. (Pro / acoustic line; the Switch
line operates the same from the app's side.)

> **Watch the real setup**: the developer demonstrates installation at
> **25:01–28:32** in <https://www.youtube.com/watch?v=V3cXeNW9jXY>. The steps below
> follow that demonstration.

## Setup, as demonstrated (Pro)

1. Place the (lightweight) device so its **drive axis lines up with the sustain
   (damper) pedal**.
2. Put the **airback** under a **neighbouring pedal** and **inflate it with the
   pump** — it presses that pedal down from below and **absorbs the reaction
   force**, so driving the sustain pedal can't push the device back. **Check the
   unit no longer moves.**
3. The drive travel is then set: the **lower end is found automatically**, and
   the **upper end is set with the slider** on the hand controller.
4. Mount the iPhone facing the player and start the app (below). Tilting the head
   down sustains; returning releases.

## One‑time / each session

1. **Place & anchor the device** at the pedals. In the reference setup the Pro
   unit sits on a **wooden board** in front of the grand‑piano **pedal lyre**, with
   its actuator over the **sustain (right) pedal**; the **airback** (blue air bag)
   sits beside it. Inflate the airback with the hand pump until the unit is firmly
   clamped and cannot move. See
   [`../../device-pro-acoustic/hardware/airback/`](../../device-pro-acoustic/hardware/airback/).
2. **Mount the iPhone/iPad** on the music desk (or a stand) **facing the player's
   face**, so the front TrueDepth camera can track the head. (In the reference
   videos a phone is propped on the piano's music desk at the player's eye level.)
2. Use the hand controller **slider** to set the **top position / travel limit**
   of the driving part so the pedal is pressed the right amount.
3. **Power on** the device. It advertises over BLE as `bFaaaPSwitch_1`
   (or `_2`…`_4` if you set another channel).

## In the app

1. Open the app and grant **Camera** and **Bluetooth** permissions.
2. **Select the channel** matching your device (1–4). The app connects only to a
   `bFaaaPSwitch_n` device.
3. Hold the iPhone/iPad so the **front (TrueDepth) camera sees your face**.
4. **Individualized pre‑setting (one‑time per player — important).** In the app,
   set the **threshold start‑point (offset)** so a normal head pose means
   "pedal up", and set the **multiplier** for how much head tilt reaches a full
   pedal. **Each player presets these to their own comfortable range and speed of
   head motion**, and the app stores the preset. This is what makes the control
   **individualized**: the same device serves an able‑footed adult, a child, and a
   player with restricted head motion — e.g. someone whose neck movement is limited
   picks a **small offset and a large multiplier**. Redo this preset for each new
   player or sitting position.
5. **Tilt your head** to engage the sustain; return to neutral to release. The
   screen is **white at rest and turns red when engaged**, so you can see the
   state at a glance. (Same app and behaviour for both Pro and Switch.)

## Tips

- Keep the screen on — the app disables auto‑lock while playing.
- If the device disconnects, the app re‑scans and reconnects automatically.
- The on‑type / off‑type setting flips whether a tilt means "sustain on" or
  "sustain off"; pick whichever feels natural.

## Signal reference

| App sends | Result |
|-----------|--------|
| `iNN` (every 100 ms) | target pedal amount `00`–`99` |
| `N` / `F` | engage / release |
| channel / type commands | configure the device |

Full protocol: [`../architecture/`](../architecture/).
