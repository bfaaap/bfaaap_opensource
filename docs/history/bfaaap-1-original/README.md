# bFaaaP 1 — where the invention began (2018)

> 🌐 **English** · [日本語](../../../i18n/ja/docs/history/bfaaap-1-original/README.md) · [Deutsch](../../../i18n/de/docs/history/bfaaap-1-original/README.md)

These are the **very first bFaaaP drawings**, made in **2018** for the first patent family
(PCT **WO 2019/176164**, filed 2018‑11‑12). We call this generation **“bFaaaP 1.”** It looks
charmingly different from today's smartphone‑and‑airback system — but look closely and you'll see
that **almost every important idea was already there.** bFaaaP 1 is where the invention, and the
foundations of a good, non‑destructive device, began.

![A warm storybook illustration of a pianist in 2018 wearing glasses with a small head-angle sensor clipped to the frame, playing a grand piano with a small device by the pedals](bfaaap1-pianist-2018.png)

*The first bFaaaP, 2018: a sensor on a pair of glasses, and a pedal device on the floor. Illustration: AI‑generated (Gemini, Saki Shiokawa style) © Shishido & Associates.*

## The invention was already here
Strip away the 2018 hardware and the **core is identical to today's**: a **quantitative,
user‑tunable control law** — take the head angle, subtract a **dead‑zone (offset)**, multiply by a
**multiplier**, clamp to **0–99**, and send it wirelessly to a pedal actuator; the player **presets**
the offset and multiplier to taste. That is exactly the “key” the patents were granted on (see
[how it works](../../how-it-works.md) and the [paper](../../../bfaaap_arxiv_latex/README.md)). Only the
**sensor** and the **mount** evolved.

![Comparison figure: a green band labelled "THE INVENTION — unchanged since 2018" (the tunable control law), above two cards — bFaaaP 1 (2018: glasses-clip MPU-9250 IMU + sound-proof chamber) and Today/bFaaaP 4 (smartphone ARKit + airback or Switch) — with an arrow showing the engineering evolved](the-invention-from-the-start.png)

**What bFaaaP 1 already got right (the seeds):**
- **The control law as the contribution** — offset + multiplier + clamp, per‑user preset (FIG. 2, FIG. 3).
- **Head‑angle, foot‑free sensing** — measure the head, free the feet (the glasses sensor, FIG. 1).
- **A detector/actuator split over a radio link** — exactly today's smartphone → BLE → device shape.
- **Non‑destructive, free‑standing device** — it stands by the pedals on its own; the piano is not
  modified. Today's pneumatic [**airback**](../../how-it-works.md) is the direct descendant of this
  “don't touch the instrument” principle.
- **Engineering care** — even a *sound‑proof chamber* to manage vibration, and clean orthographic
  **hand sketches** worked out before the CAD.

## What changed — a giant motor and a pair of glasses
The two most striking differences from today are the **drive motor** and the **sensor**. bFaaaP 1
moved the pedal with a **large, industrial‑robot‑grade stepper motor by Oriental Motor Co., Ltd.**,
housed in a heavy sound‑proof chamber — and it read the head from a **sensor worn on a pair of
glasses**. Today the same job is done by a **palm‑sized closed‑loop motor** (anchored by the airback)
— or **no motor at all** on the electronic Switch — and by a **smartphone on a stand, with nothing
worn**. The head‑angle control law in between never changed.

![Then vs now: bFaaaP 1 (2018) used a glasses-worn head sensor and a LARGE industrial-robot-grade stepper motor by Oriental Motor Co. inside a sound-proof chamber; today it is a smartphone (nothing worn) and a compact closed-loop motor — or no motor at all on the Switch](then-vs-now-sensor-and-motor.png)

## Anchoring the reaction force — from dead weight to the airback
There was a second reason bFaaaP 1 was so big and heavy: **how it stayed put.** Pressing a pedal
creates a **reaction force** that tends to push a light device away, so bFaaaP 1 **packed heavy metal
into a compartment at the bottom of its housing** — resisting the force with sheer mass. The project later
**invented the “airback”**: an airbag‑like inflatable cushion that **braces against a neighbouring
pedal**, anchoring the reaction force into the **piano's own structure** instead of fighting it with
mass. Reacting the force at its source is far more efficient — so the device could become **much
smaller and lighter** (the airback is also non‑destructive and quick to set up; see
[how it works](../../how-it-works.md)).

![Then vs now: bFaaaP 1 (2018) resisted the pedal reaction force with metal weight packed into a compartment at the bottom of its sound-proof chamber housing (big & heavy); today the airback inflates and braces against a neighbouring pedal, anchoring the force to the piano itself, so the device is light & small](anchoring-weight-vs-airback.png)

## The original drawings

### FIG. 1 — overview, with the glasses sensor
**1000** is the eyeglasses frame; **1100** is the head‑angle sensor clipped to it; **1200** is the
hand controller (offset & multiplier dials); **100** is the sound‑proof chamber device at the pedals.
The **glasses‑mounted sensor unit was also registered as a design (意匠登録).**

![FIG. 1: glasses (1000) carrying a head-angle sensor (1100), a small hand controller (1200), and a boxy sound-proof chamber device (100) at the piano's pedals](fig1-overview-glasses-sensor.png)

### FIG. 2 — system block diagram (the 2018 control law)
Detector side (angle sensor → data processor → transmitter) already exposes the **offset value** and
**multiplier**; actuator side (receiver → controller → actuator) exposes the **free‑pedal‑play offset**
and **actuation range**.

![FIG. 2: a Detector Side (angle sensor, data processor, transmitter, offset value, multiplier) and an Actuator Side (receiver, actuator controller, actuator, free-pedal-play offset, actuation range)](fig2-system-block-diagram.png)

### FIG. 3 — detector‑side firmware flow
Set up BLE and the **MPU‑9250** IMU, read accel/gyro/geomagnetic, run a **Madgwick filter** for head
pitch, **subtract offset**, **multiply**, **clamp 0–99**, transmit over BLE — with live re‑reading of
the offset and multiplier adjusters.

![FIG. 3: flowchart S100–S128 — BLE/MPU9250 setup, sensor read, Madgwick filter, subtract offset, multiply, clamp 0–99, BLE transmit, read adjusters](fig3-detector-side-flow.png)

### FIG. 5 — actuator move (MOV) function
How the controller toggled the motor bits to advance the pedal one step.

![FIG. 5: flowchart S300–S310 — wait while busy, set motor bits Mo0–Mo5, delay, toggle start bit, wait](fig5-actuator-mov-function.png)

## Hand‑drawn engineering sketches (the fun part)
Before the clean CAD, the sound‑proof chamber was worked out **by hand** (T. Shishido, 2018‑09‑11) —
front cross‑section, side, rear, and top/intermediate/bottom, with the same part numbers as the formal
figures. They're a lovely reminder that good devices often start on paper.

![Hand-drawn front cross-sectional view of the sound-proof chamber](handdrawn-front-cross-section.png)

![Hand-drawn left-side view: front and back plate members, sound absorber, opening](handdrawn-left-side-view.png)

![Hand-drawn rear view of the chamber housing](handdrawn-rear-view.png)

![Hand-drawn top, intermediate, and bottom views of the chamber](handdrawn-top-intermediate-bottom.png)

*Original hand sketches © bFaaaP team (T. Shishido).*

---

## Privacy & data
These are **technical drawings only** — no people, names, or personal data. The human‑subject
**APEE study is documented separately** and not repeated here — see the
[PCT / APEE original figures](../pct-original-figures/README.md) (which include the **bFaaaP 2**
M5Stack sensor and the **anonymised** APEE figures) and the paper's Appendix A.

## Files
- Illustrations: `bfaaap1-pianist-2018.png` (Gemini), `the-invention-from-the-start.png` (matplotlib).
- Original figures (PNG): `fig1-overview-glasses-sensor.png`, `fig2-system-block-diagram.png`,
  `fig3-detector-side-flow.png`, `fig5-actuator-mov-function.png`, and the four `handdrawn-*.png`.
- Archival source PDFs: `source-handdrawn-embodiment-2018.pdf`, `source-configuration-diagram-2018.pdf`.

## See also
[History](../../HISTORY.md) · [Story](../../story.md) · [How it works](../../how-it-works.md) ·
[PCT / APEE figures](../pct-original-figures/README.md) · [the paper](../../../bfaaap_arxiv_latex/README.md)
