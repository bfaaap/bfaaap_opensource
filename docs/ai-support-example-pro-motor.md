# 🧵 A live example: "Which motor can replace the EOL one?"

> 🌐 **English** · [日本語](../i18n/ja/docs/ai-support-example-pro-motor.md) · [Deutsch](../i18n/de/docs/ai-support-example-pro-motor.md)
>
> Part of [AI‑assisted Support](ai-support.md). This page shows **how it actually feels**:
> the **AI proposes an idea from the open data, and the real bFaaaP team reviews and
> supplements it.** Nobody knows the single "right" answer here — that is exactly why the
> human review matters, and why it's fun to watch the answer take shape.

The Pro's original drive motor (**IQ Fortiq M42BLS**) is **end‑of‑life**. A newcomer asked, in
effect: *"What motor + firmware can I actually use to reproduce the Pro today?"* There is **no
settled answer yet** — so the AI did the legwork from current data, and the people who actually
built bFaaaP are weighing in. Here is that thread.

<table>
<tr>
<td width="120" valign="top"><img src="media/avatars/ai.png" width="104" alt="AI assistant avatar"></td>
<td valign="top">

**🤖 AI assistant** &nbsp;·&nbsp; <sub>draft idea from current web data (June 2026) — *unverified*</sub>

Here's a **starting point**, not a verdict. The hard part isn't the motor body (a same‑size
**NEMA17 / "17‑type" stepper, STEP/DIR** reuses the existing frame, belt and T10 screw) — it's
**force feedback**. The old IQ servo read its **motor power** to "press until the reaction force
rises". A plain stepper can't, so we need to *recover* that. Three ways I found:

- **A — Closed‑loop driver** (encoder reports load): NEMA17 + **MKS SERVO42C/D**, **BTT S42B/S42C**, or **StepperOnline CL42T** + a closed‑loop NEMA17. → *Closest to the IQ "go to position, hold, read load" model; STEP/DIR **and** UART/CAN; open source (MKS, BTT).*
- **B — Sensorless load** (StallGuard): plain NEMA17 + **TMC2209**. → *Cheapest (~$5); detects "pressed/stall" over UART — but a **relative** load value, not absolute force.*
- **C — Direct force sensor**: plain NEMA17 + **DRV8825/A4988** + a **load cell read by the HX711 already in the BOM**. → *Measures real press force; reuses an existing part; DRV8825 is what the team first prototyped.*

**Rough sizing (please check):** through the **T10 screw (16 mm/rev lead, 1:1 belt)**, a NEMA17's
holding torque *T* gives a push of about `F ≈ 2π·η·T / lead` ≈ **60–110 N** for a 0.4–0.65 N·m
motor at lead‑screw efficiency η ≈ 0.4–0.5 — enough for a sustain pedal, but the 16 mm lead is
"fast" (low mechanical advantage), so I'd lean to a **higher‑torque NEMA17 (≥ 50 N·cm) at 24 V**.

*Sources: MKS SERVO42, BIGTREETECH S42B, StepperOnline CL42T / ISDT17‑20, TMC2209 (StallGuard4),
Vertiq/Fortiq docs. Full draft: the team's review PDF.*

</td>
</tr>
</table>

---

### 👀 The bFaaaP team is reviewing this

> This is a **track ② ("needs the makers")** question — see [how AI‑assisted Support works](ai-support.md).
> Each comment is filled in with that member's **own words** as they reply: **Narusawa has answered**;
> **Tanaka and Taguchi are still reviewing** (placeholders below). The agreed conclusion gets folded into
> the [Pro build guide](build/pro.md) and [hardware‑availability notes](../device-pro-acoustic/HARDWARE-AVAILABILITY.md).

<table>
<tr>
<td width="120" valign="top"><img src="media/avatars/narusawa.png" width="104" alt="Hiroyuki Narusawa avatar"></td>
<td valign="top">

**🛠️ Hiroyuki Narusawa** &nbsp;·&nbsp; <sub>pedal device / firmware — *built the working unit*</sub>

✅ *Replied (2026‑06‑26).* For the successor motor I'm leaning to **option A — a closed‑loop driver**.
I'm considering either **MKS SERVO42C/D + a NEMA17**, or **a closed‑loop stepping motor with a
built‑in NEMA17‑class driver**. Could the **AI draft the firmware** for that configuration?
*(The CAD is still being added to / swapped out, so the mechanical files aren't final yet.)*

</td>
</tr>
</table>

<table>
<tr>
<td width="120" valign="top"><img src="media/avatars/tanaka.png" width="104" alt="Haruto Tanaka avatar"></td>
<td valign="top">

**⚡ Haruto Tanaka** &nbsp;·&nbsp; <sub>electrical engineering</sub>

🕐 *Reviewing.* Asked to sanity‑check the **electrical side**: a suitable NEMA17 torque/model, the
driver choice, and whether the 24 V / current numbers and the force estimate hold up. His reply
will appear here.

</td>
</tr>
</table>

<table>
<tr>
<td width="120" valign="top"><img src="media/avatars/taguchi.png" width="104" alt="Taguchi avatar"></td>
<td valign="top">

**💻 Taguchi** &nbsp;·&nbsp; <sub>software engineering</sub>

🕐 *Reviewing — taking a little more time.* Asked about the **firmware/control** implications — how
STEP/DIR + a load signal slot into the existing Pico loop. His reply will appear here.

</td>
</tr>
</table>

<table>
<tr>
<td width="120" valign="top"><img src="media/avatars/ai.png" width="104" alt="AI assistant avatar"></td>
<td valign="top">

**🤖 AI assistant** &nbsp;·&nbsp; <sub>follow‑up</sub>

Thanks, Narusawa — that lands us on **option A**, which is the closest to the original IQ behaviour.
Both choices report **load/following‑error over UART (or CAN)**, so the firmware can recover the
IQ‑style "press until the reaction force rises" calibration.

✅ **Draft delivered (2026‑06‑26):**
[`bFaaaP_autopro_pico_stepperA_draft_20260626.ino`](../device-pro-acoustic/firmware/pico/bFaaaP_autopro_pico_stepperA_draft_20260626.ino)
— STEP/DIR motion + a *go‑to‑position‑and‑hold* loop + a `readLoad()` (driver‑serial, with an ADC
fallback) for the force step; it maps the app's **0–99** to a target, keeps the **50 mm travel cap**,
and **fixes the v052B STEP/DIR pin clash** (step pulse was sharing GP13 with the buzzer). It is
**untested — a starting point for the bench**, with the driver's exact protocol bytes left as a TODO.

**Next:** Narusawa bench‑tests it; then Tanaka (electrical) & Taguchi (software) review before it's
called done. *(Mechanical files stay open until the CAD is final.)*

</td>
</tr>
</table>

<table>
<tr>
<td width="120" valign="top"><img src="media/avatars/narusawa.png" width="104" alt="Hiroyuki Narusawa avatar"></td>
<td valign="top">

**🛠️ Hiroyuki Narusawa** &nbsp;·&nbsp; <sub>follow‑up</sub>

✅ **It compiles** — nice work. Taguchi and Tanaka can refine it from here. A few changes for the
successor: **drop the HX711** — just run the air pump a **fixed 40 s** (the air **valve is normally
closed** and is released only when the unit is taken off the piano). And the **80 µs STEP** looks too
fast — the pedal may not follow, so slow it down.

</td>
</tr>
</table>

<table>
<tr>
<td width="120" valign="top"><img src="media/avatars/ai.png" width="104" alt="AI assistant avatar"></td>
<td valign="top">

**🤖 AI assistant** &nbsp;·&nbsp; <sub>follow‑up</sub>

Done: removed the HX711, made the airback a **fixed 40 s** inflate with the **normally‑closed valve**
note, and slowed **STEP_PULSE_US 80 → 350 µs** (tunable on the bench). Over to **Tanaka & Taguchi** to
refine the driver protocol and tune the rates. *(This whole exchange is exactly what AI‑assisted
Support is for — the AI moves fast, the makers keep it honest.)*

</td>
</tr>
</table>

---

## Why we publish it this way

The AI is fast and reads everything in the repo, but it **can be confidently wrong** — and on an
open question like "the best motor to use," there isn't one textbook answer. The bFaaaP team
**actually built the device**, so their review turns a plausible AI draft into something you can
trust. Showing that exchange in the open is the point: you see *how* the answer is reached, not
just the answer.

**Have a better idea, or built it with a different motor?**
**[Join the discussion →](https://github.com/TomoShishido/bfaaap_opensource/discussions)** — your
input can become part of this thread, and part of the docs.

---

*Member avatars are original hand‑drawn illustrations by **Saki Shiokawa (塩川紗季)** (© Saki Shiokawa /
bFaaaP); only the AI avatar is AI‑generated (Gemini, in her style) © Shishido & Associates. See
[media credits](media/CREDITS.md).*
