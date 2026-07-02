# How bFaaaP works (the friendly version)

> 🌐 **English** · [日本語](../i18n/ja/docs/how-it-works.md) · [Deutsch](../i18n/de/docs/how-it-works.md)

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
   pedal device. You preset your own **offset (threshold)** — how far to tilt — and a **multiplier**,
   so it fits you (together they set how fast the pedal follows; you don't set a separate "speed").
4. **The device presses the pedal.**
   - **Pro** (acoustic piano): a small **motor** pushes a rod onto the sustain pedal; an
     **airback** cushion anchors it without touching the piano's finish.
   - **Switch** (digital piano): the device **electronically** closes the sustain through the
     instrument's pedal jack — no motor at all.

#### Why "airback" (a coined term, not "airbag")
The **"airback"** is bFaaaP's inflatable, **air‑braced anchor** — *not* an "airbag". An air cushion
(a **WINBAG** air jack, inflated by a small **electric pump inside the device** through an air tube)
inflates under a neighbouring pedal and absorbs the actuator's reaction force, so the **Pro** device
stays firmly in place on an *unmodified* acoustic piano: **no bolts, non‑destructive, and quick to
set up and remove**. The name joins *air* + *back* (to back / brace / support), emphasising the
bracing role rather than the safety meaning of "airbag".

![Schematic: a single wide "airback" cushion sits under the two left pedals and anchors the Pro device against the reaction force of pressing the sustain pedal; the drive unit sits on the right (sustain) pedal; no bolts](media/illustrations/airback-anchoring.png)

*The airback reaction‑force anchoring (schematic). © Shishido & Associates (CC BY 4.0).*

### The control law — how a tilt becomes a pedal press
This is the heart of bFaaaP (and what its patents cover). A small **dead-zone (offset)** means
small, involuntary head movements do nothing; past your threshold, the pedal follows your tilt
with a **multiplier** you choose, reaching full pedal within a few degrees. A little **hysteresis**
(engage vs. release) keeps it from chattering.

![Control law: head angle to pedal, with dead-zone, multiplier and hysteresis](media/diagrams/control-law.png)

You preset just two things to yourself in the iOS app — the **threshold (offset)** and the
**multiplier** — and together they fix a secondary, temporal **response speed**: how fast the
pedal follows your head past the dead‑zone (you do not set a separate "speed"). This quantitative,
user‑tunable law is the **key** that turns a small head tilt into the player's *own intended*
pedalling — natural, expressive playing rather than a crude on/off. It is also exactly what made
bFaaaP **patentable**: the bare head→pedal idea was already known, so the patents were granted on
this *specific, tunable law*, not on the architecture. (Background: the patented scheme uses an
offset upper limit of 3–10°, a multiplier of 10–50, and full pedal action within +2–10°. See the
[patent guide](../bfaaap_patent_info/general_description/README.md).)

![A small head tilt is the "key" that unlocks the player's own intended, natural pedalling](media/illustrations/control-law-key.png)

*The control law is the **key**: a small head tilt — shaped by the offset and multiplier you preset
— unlocks your **own intended, natural** pedalling rather than a crude on/off, and this specific,
tunable law (not the bare head→pedal idea) is what the patents were granted on. Illustration:
AI illustration by Harmonia in Saki Shiokawa style © Shishido & Associates.*

#### The control law, precisely (paper Figures 3 & 4)
These two figures from the [paper](../bfaaap_arxiv_latex/README.md) make the control law exact.

**Figure 3 — the control law.** (a) Above your neutral *offset*, the head angle maps **linearly**
to the pedal value (0–99), scaled by your **multiplier** and clamped at full. (b) Engage and
release use a small **hysteresis dead‑band δ**, so the pedal doesn't chatter when your head hovers
near the threshold.

![Figure 3: (a) head angle above the offset maps linearly to the pedal value, clamped at 99; (b) engage/release hysteresis with a dead-band](media/diagrams/fig-control-law.png)

*Figure 3 from the paper — head‑angle control law. © Shishido & Associates (CC BY 4.0).*

**Figure 4 — why it is patentable.** Prior art was a **binary on/off** head switch (dashed step).
bFaaaP instead sends a **continuous, proportional** command whose **dead‑zone** (offset 3–10°) and
**slope** (multiplier 10–50) each player presets — the quantitative, user‑tunable law the patents
were granted on.

![Figure 4: bFaaaP's proportional, user-tunable command (two slopes) versus binary prior-art on/off at a single threshold](media/diagrams/fig-control-vs-priorart.png)

*Figure 4 from the paper — quantitative, user‑tunable mapping vs. binary prior art. © Shishido & Associates (CC BY 4.0).*

**Does it really work?** A 15‑participant human‑subject study says yes — see the
**[APEE study](apee-study.md)** (method, results, and the full anonymized data).

**Who could it help, and what else could the controller do?** See
**[Accessibility impact](accessibility-impact.md)** — the controller as a reusable accessibility
input, with worldwide wheelchair and home‑ventilation population figures and the works they cite.

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
→ Next: [Build it yourself](build/) · [The bFaaaP story](story.md) · [Glossary](GLOSSARY.md) · [Source map (files behind each topic)](SOURCE-MAP.md)
