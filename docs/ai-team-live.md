# 🎭 bFaaaP — AI & Team, Live  ·  AIとチームの実況解説

> 🌐 **English** · 日本語・Deutsch — *coming soon*
>
> A **live, behind‑the‑scenes commentary** of how bFaaaP is actually being built — the **AI and the
> real bFaaaP team**, working together in the open.

![The bFaaaP team and a friendly AI building together around a piano and a workbench](media/illustrations/ai-team-hero.png)
<sub>AI‑assisted Support, team‑collaboration mode. Illustration: AI‑generated (Gemini, Saki Shiokawa style) © Shishido &amp; Associates.</sub>

This is the heart of [**AI‑assisted Support**](ai-support.md): the **AI moves fast** and drafts —
figures, docs, even **firmware** — and the **makers, who actually built the device, keep it honest.**
Nobody pretends the AI is always right; you get to watch a real engineering conversation reach a
real answer. Pull up a seat. 🎙️

---

## 🎙️ The cast

<table>
<tr>
<td width="130" align="center"><img src="media/avatars/ai.png" width="120" alt="AI assistant avatar"></td>
<td valign="middle">

### 🤖 AI assistant
Reads the whole repository, drafts fast (diagrams, docs, code), researches the live web — and
**defers to the makers**. Confident, tireless, occasionally confidently wrong.

</td>
</tr>
<tr>
<td width="130" align="center"><img src="media/avatars/narusawa.png" width="120" alt="Hiroyuki Narusawa avatar"></td>
<td valign="middle">

### 🛠️ Hiroyuki Narusawa — *pedal device / firmware*
**Built the working unit.** The ground truth for the mechanics and the firmware — every "actually,
on the real device…" comes from here.

</td>
</tr>
<tr>
<td width="130" align="center"><img src="media/avatars/tanaka.png" width="120" alt="Haruto Tanaka avatar"></td>
<td valign="middle">

### ⚡ Haruto Tanaka — *electrical / semiconductor circuits*
A graduate researcher at a **leading semiconductor circuit‑design lab at Science Tokyo (東京科学大)** —
he'll bring **analysis from his lab's AI environment and equipment**. *(His take is coming up.)*

</td>
</tr>
<tr>
<td width="130" align="center"><img src="media/avatars/taguchi.png" width="120" alt="Taguchi avatar"></td>
<td valign="middle">

### 💻 Taguchi — *software engineering*
Confirmed the schematic, owns the firmware/control view. *(His review of the new firmware is coming up.)*

</td>
</tr>
</table>

---

## The play — the loop it runs on

![The AI x team loop and the story timeline](media/diagrams/ai-team-flow.png)

> ① a maker shares a sketch / spec / question → ② the AI drafts it fast → ③ the team reviews it
> (they built the thing) → ④ it's reflected into the docs and the three sites in three languages →
> and round again. **Fast ⟳ honest.** Here's how it actually played out.

---

## 🎬 Act 0 — Detective work: pinning down the unknowns

🎙️ *"Before any of the drama, a quieter challenge — at the start, even the AI couldn't just read the
real BOM and circuit off the data. Parts had to be **identified**, one maker answer at a time."*

![From unknown to confirmed — the BOM filled in via Q&A](media/diagrams/bom-evolution.png)

<table>
<tr>
<td width="100" align="center"><img src="media/avatars/taguchi.png" width="92" alt="Taguchi"></td>
<td valign="top">

**💻 Taguchi:** The Pro's BLE board is the **AE‑NRF52840** — *not* the ItsyBitsy (that's the **Switch**'s
board). Here's the full **pin map** and the KiCad schematic.

</td>
</tr>
<tr>
<td width="100" align="center"><img src="media/avatars/ai.png" width="92" alt="AI"></td>
<td valign="top">

**🤖 AI:** That closes the circuit — imported the KiCad source and fixed every stray doc that wrongly
said "Pro = ItsyBitsy." (See the whole table above: each red "unknown" became a green "confirmed.")

</td>
</tr>
</table>

### …and a license scare, avoided 🕵️

🎙️ *"Here's the practical bit engineers love. Preparing for a public release, the AI audited **every**
asset's license — and caught a problem before it shipped."*

<table>
<tr>
<td width="100" align="center"><img src="media/avatars/ai.png" width="92" alt="AI"></td>
<td valign="top">

**🤖 AI:** Two diagrams carried over from the old `hardware.md` had an **unknown license** — a real
**infringement risk** for an open‑source repo. So I **removed them and redrew our own** clean figures
(matplotlib), linking only to the official sources.

</td>
</tr>
<tr>
<td width="100" align="center"><img src="media/avatars/taguchi.png" width="92" alt="Taguchi"></td>
<td valign="top">

**💻 Taguchi:** Good catch — those were most likely from the **Raspberry Pi Pico docs** and the
**Fortiq datasheet** (vendor copyright). Removing and redrawing was the right call.

</td>
</tr>
</table>

> The repo now ships **zero** third‑party images of uncertain license (see
> [`PUBLISHING-CHECKLIST.md`](../PUBLISHING-CHECKLIST.md) §3) — the AI's license audit became part of
> the public‑release gate. *Fast, yes — but also careful.*

---

## 🎬 Act 1 — A pencil sketch becomes a vertical drive

🎙️ *"We open on a problem: the repo's drawing of the Pro showed a horizontal screw — but that's not
the real machine. Narusawa settles it with a photo of a hand‑drawn BOM…"*

<table>
<tr>
<td width="100" align="center"><img src="media/avatars/narusawa.png" width="92" alt="Narusawa"></td>
<td valign="top">

**🛠️ Narusawa:** The Pro mechanical layout should look like my sketch — it's closer to the real unit.
*(motor beside the screw · belt 1:1 · a **vertical** lead screw · push‑rod presses straight down · WINBAG airback.)*

</td>
</tr>
<tr>
<td width="100" align="center"><img src="media/avatars/ai.png" width="92" alt="AI"></td>
<td valign="top">

**🤖 AI:** Read it, and redrew the layout as a **vertical column** — and it matches the assembly BOM
exactly (GT‑2‑262 belt, T60/T60, T10 screw, 2040 + 2080 frame).

</td>
</tr>
</table>

![A hand‑drawn sketch becomes a clean diagram](media/illustrations/ai-team-redraw.png)

![The redrawn Pro mechanical layout](../device-pro-acoustic/hardware/reference-design/pro-mechanical-layout.png)

---

## 🎬 Act 2 — The maker marks up the AI's own drawing

🎙️ *"Plot twist — Narusawa annotates the AI's figure and hands it back. The wiring gets real."*

<table>
<tr>
<td width="100" align="center"><img src="media/avatars/narusawa.png" width="92" alt="Narusawa"></td>
<td valign="top">

**🛠️ Narusawa:** The air‑jack pump is **inside the box**; the airback is inflated by that **electric
pump** through an **air tube** — not by hand. Add the **SLIDE VOLUME & PUMP SW** panel and the real
wiring (+24 V motor power, **IQ UART**, a **+5 V cooling fan**).

</td>
</tr>
<tr>
<td width="100" align="center"><img src="media/avatars/ai.png" width="92" alt="AI"></td>
<td valign="top">

**🤖 AI:** Reflected all of it into the figures **and** the docs **and** the three sites — in
**three languages**. The architecture diagram now shows the pump‑in‑the‑box and the air tube.

</td>
</tr>
</table>

![The Pro reference system architecture](../device-pro-acoustic/hardware/reference-design/pro-architecture.png)

---

## 🎬 Act 3 — A dead part, and a research sprint

🎙️ *"Then a real obstacle: the original motor is **end‑of‑life.** Can a newcomer even build this? The
AI goes to the live web…"*

![An engineer and the AI choosing the motor together](media/illustrations/ai-team-motor.png)

<table>
<tr>
<td width="100" align="center"><img src="media/avatars/ai.png" width="92" alt="AI"></td>
<td valign="top">

**🤖 AI:** The IQ motor is EOL. I researched (June 2026) and the real question is **force feedback**.
Three ways: **A** a closed‑loop driver (reads load over serial), **B** TMC2209 StallGuard, **C** a
load cell on the existing HX711. A NEMA17 keeps the same frame.

</td>
</tr>
<tr>
<td width="100" align="center"><img src="media/avatars/narusawa.png" width="92" alt="Narusawa"></td>
<td valign="top">

**🛠️ Narusawa:** Let's go with **option A** — either **MKS SERVO42C/D + a NEMA17**, or an integrated
closed‑loop NEMA17. **Could the AI draft the firmware** for that?

</td>
</tr>
</table>

---

## 🎬 Act 4 — The AI writes firmware… and it compiles 🎉

🎙️ *"Here's the moment. The AI writes a whole Pico sketch for the new motor — and Narusawa flashes
his toolchain…"*

![It compiles — a happy moment at the bench](media/illustrations/ai-team-firmware.png)

<table>
<tr>
<td width="100" align="center"><img src="media/avatars/ai.png" width="92" alt="AI"></td>
<td valign="top">

**🤖 AI:** Drafted [`bFaaaP_autopro_pico_stepperA_draft_20260626.ino`](../device-pro-acoustic/firmware/pico/bFaaaP_autopro_pico_stepperA_draft_20260626.ino)
— STEP/DIR motion + a *go‑to‑position‑and‑hold* loop + a `readLoad()` for the press‑force step;
maps the app's **0–99** to a target and keeps the **50 mm travel cap**. It even fixes the `v052B`
STEP/DIR pin clash. *Untested — a starting point for the bench.*

</td>
</tr>
<tr>
<td width="100" align="center"><img src="media/avatars/narusawa.png" width="92" alt="Narusawa"></td>
<td valign="top">

**🛠️ Narusawa:** **It compiles — nice work!** A few real‑world fixes for the successor: it's **GT‑2**,
not 2GT; **drop the HX711** — just run the pump a **fixed 40 s** (the valve is normally closed, released
on removal); and **80 µs STEP is too fast**, the pedal won't follow.

</td>
</tr>
<tr>
<td width="100" align="center"><img src="media/avatars/ai.png" width="92" alt="AI"></td>
<td valign="top">

**🤖 AI:** Done — GT‑2 everywhere, the airback is a fixed 40 s inflate (valve normally closed), and
the STEP rate is slowed (80 → 350 µs, tunable). The control loop now reads:

```cpp
void loop() {
  if (Serial1.available() > 0) {
    int b = Serial1.read();                 // 0..99 from the BLE bridge
    if (b < 0 || b > 99) return;
    if (abs(b - last_byte) > MOVE_HYST) {   // ignore small head jitter
      long target = (long)mapf(b, 0, 99, up_pos, down_pos);
      moveSteps(target - cu_steps);         // go to the target and hold
      last_byte = b;
    }
  }
}
```

</td>
</tr>
</table>

---

## 💻 Code spotlight — the force calibration

🎙️ *"For the engineers in the audience: this is the heart of recovering the IQ‑style 'press until the
reaction force rises' — drive to the top, then down until the driver's load says 'pressed', with a
hard 50 mm travel cap. GitHub — and bFaaaP.com / saaipf.com — render this with **mode‑aware,
Prettier‑style syntax highlighting**: flip your dark/light toggle and the colours follow."*

```cpp
// Find the mechanical top, then drive down until the pedal-press load is reached.
void autoCalibrate() {
  const long CAP = (long)TRAVEL_CAP_MM * STEPS_PER_MM;   // 50 mm safety cap
  long guard = 0;

  // 1) drive UP until the load rises (hit the top), then back off 5 mm = up_pos
  while (readLoad() < LOAD_THRESH_UP && guard++ < CAP * 2) moveSteps(-STEPS_PER_MM);
  moveSteps(5 * STEPS_PER_MM);
  up_pos = cu_steps;

  // 2) drive DOWN until the press load is reached OR the travel cap, then up 10 mm = down_pos
  guard = 0;
  while (readLoad() < LOAD_THRESH_DOWN && (cu_steps - up_pos) < CAP && guard++ < CAP * 2)
    moveSteps(STEPS_PER_MM);
  moveSteps(-10 * STEPS_PER_MM);
  down_pos = cu_steps;
}
```

Full sketch (AI draft, untested): [`bFaaaP_autopro_pico_stepperA_draft_20260626.ino`](../device-pro-acoustic/firmware/pico/bFaaaP_autopro_pico_stepperA_draft_20260626.ino).

---

## 🎬 Act 5 — Coming up: the specialists

🎙️ *"And we're live for the next round — two specialists are warming up…"*

<table>
<tr>
<td width="100" align="center"><img src="media/avatars/tanaka.png" width="92" alt="Tanaka"></td>
<td valign="top">

**⚡ Haruto Tanaka** — *electrical / semiconductor circuits* &nbsp; 🕐 *up next:* analysis from his
**Science Tokyo lab's AI environment + equipment** — the driver/motor electrical side and the force read.

</td>
</tr>
<tr>
<td width="100" align="center"><img src="media/avatars/taguchi.png" width="92" alt="Taguchi"></td>
<td valign="top">

**💻 Taguchi** — *software* &nbsp; 🕐 *up next:* refining the firmware — the driver protocol and how
the load signal slots into the Pico loop.

</td>
</tr>
</table>

*Their words go straight here when they reply — that's the show.*

---

## 📎 The real paper trail

Not a re‑enactment — these are the **actual PDFs** sent to the makers (the figures + the questions),
so you can read the exchange yourself:

- [**Thread artifacts (index)**](ai-support/threads/) — Questions #1–#4 to Narusawa, the motor‑alternatives
  draft, and the style sample. The comprehensive **#4** is also in
  [**English**](ai-support/threads/narusawa-questions-4_en_20260626.pdf) and
  [**Deutsch**](ai-support/threads/narusawa-questions-4_de_20260626.pdf) *(EN/DE for the others to follow)*.

---

## Why this is the point

The AI is fast and reads everything, but on open engineering questions there isn't one textbook
answer — and it can be **confidently wrong**. The people who **actually built bFaaaP** turn a plausible
draft into something you can trust, and doing it **in the open** means you see *how* the answer is
reached, not just the answer. That's **AI‑assisted Support, team‑collaboration mode** — and honestly,
it's a lot of fun to watch.

**Want in?** **[Join the discussion →](https://github.com/TomoShishido/bfaaap_opensource/discussions)** —
your question or idea can become the next act.

---

*Member avatars = original hand‑drawn illustrations by **Saki Shiokawa (塩川紗季)** (© Saki Shiokawa /
bFaaaP); only the AI avatar + scene art are AI‑generated (Gemini, in her style) © Shishido &
Associates. See [media credits](media/CREDITS.md).
A condensed version of this thread also lives in [the motor‑choice example](ai-support-example-pro-motor.md).*
