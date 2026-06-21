# How bFaaaP works (the friendly version)

New here? This page explains the whole idea in plain words. For any unfamiliar term, see the
[glossary](GLOSSARY.md).

![Your intent → face recognition → Bluetooth → controller module](media/illustrations/intl-how-it-works.png)

## The idea in one sentence
You **tilt your head** a little; an iPhone/iPad **sees the tilt**; it sends that over
**Bluetooth** to a small device at the piano; the device **presses the sustain pedal**. No feet
needed.

## The four steps
1. **Your intent (head angle).** You lean your head slightly. That motion is your "pedal up /
   pedal down" intention.
2. **The phone reads it.** Apple's face‑tracking (**ARKit / TrueDepth**) measures your head
   angle and turns it into a number, 0–99 %.
3. **Bluetooth carries it.** The app sends small messages (`i00`–`i99`) over **BLE** to the
   pedal device. You set your own **threshold** (how far to tilt) and **speed**, so it fits you.
4. **The device presses the pedal.**
   - **Pro** (acoustic piano): a small **motor** pushes a rod onto the sustain pedal; an
     **airback** cushion anchors it without touching the piano's finish.
   - **Switch** (digital piano): the device **electronically** closes the sustain through the
     instrument's pedal jack — no motor at all.

## A neat design detail
The phone produces head angles *much faster* than Bluetooth should send them. So the app
**paces** the radio (a ~100 ms timer + throttling) to keep the link rock‑solid. It's a small
trick with a big payoff — see [`../ios-app/DESIGN-HIGHLIGHTS.md`](../ios-app/DESIGN-HIGHLIGHTS.md).

## What's inside the device
```
iPhone/iPad app ──BLE (i00–i99)──▶ BLE board (nRF52840) ──UART (1 byte)──▶ Pico (RP2040) ──▶ pedal
```
The **Pico** is the brain that drives the motor (Pro) or the switch (Switch); the **nRF52840**
handles Bluetooth. For the wiring, parts, and step‑by‑step build, see
[Build it yourself](build/).

---
→ Next: [Build it yourself](build/) · [The bFaaaP story](story.md) · [Glossary](GLOSSARY.md)
