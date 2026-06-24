# Historical archive — original PCT / APEE figures (2018)

> 🌐 **English** · [日本語](../../../i18n/ja/docs/history/pct-original-figures/README.md) · [Deutsch](../../../i18n/de/docs/history/pct-original-figures/README.md)

These are **original figures from 2018**, prepared for the first bFaaaP patent
family (PCT **WO 2019/176164**, filed 2018‑11‑12) and the human‑subject
**Auxiliary Pedal Effect Evaluation (APEE) study** (tests run 2018‑08 to
2018‑10). They are kept here as **historical / archival material**.

Several of them show **early concepts that are *not* used in today's devices** —
an M5Stack‑based head sensor, and a heavy "sound‑proof chamber" housing — which
makes the contrast with the current, lightweight [Pro (airback)](../../build/pro.md)
and [Switch](../../build/switch.md) designs part of the story. The APEE figures,
by contrast, are still the empirical backbone of the project: they are where the
control‑law numbers (offset dead‑zone, multiplier) and the "as good as your own
foot" result actually come from. The same data underlies the
[arXiv paper](../../../bfaaap_arxiv_latex/) and is summarised in
[`docs/HISTORY.md`](../../HISTORY.md) and the project [story](../../story.md).

### Privacy / anonymisation

All human‑subject data here is **anonymised**. Participants appear only as
**No. 1 – No. 15** (Class III adds a non‑identifying disability descriptor such
as "with leg disabilities"). **There is no name column and no personal name,
address, photograph, or contact detail anywhere in these files.** The raw
spreadsheet that does contain names is deliberately **not** published; only these
already‑anonymised figures are. Disclosure is consistent with the study consent,
which permitted disclosure after the patent filing.

---

## A. The APEE human‑subject study

The motif (do‑do‑do, re‑re‑re, mi‑mi‑mi, 3/4, repeated 4×) was recorded three
ways — **no pedal (pattern 0)** and two bFaaaP **pedalling patterns** — and the
sustain measured as a **tone‑vibration area (TVA)**, normalised so that no‑pedal
= 1.00. 15 participants in three classes; the parameter ranges they chose are
what the patent claims and the paper report.

**At a glance — the whole APEE pipeline** (a modern summary diagram of the steps
that the original figures below document one by one):

![APEE pipeline overview](../../../bfaaap_arxiv_latex/figures/fig_apee_pipeline.png)

### A1 · Test score and the two pedalling patterns
`apee-01-test-score-and-pedal-patterns.pdf` — PCT Fig. 23/24.
Pattern 1 changes the pedal at each three‑note group; pattern 2 holds it across
the groups (a longer, more connected sustain), which is why pattern 2 sustains
more than pattern 1.

![Test score and pedal patterns](previews/apee-01-test-score-and-pedal-patterns.png)

### A2 · How the sustain score is computed (TVA ratio)
`apee-02-tva-ratio-method.pdf` — PCT Fig. 25.
Each recording's waveform area is measured (Sonic Visualiser → ImageJ). With
TVA₀ ≡ 1.00, the score of each pattern is TVAₙ / TVA₀. More sustain → larger area.

![TVA ratio method](previews/apee-02-tva-ratio-method.png)

### A3 · Results tables (sustain effect; bFaaaP vs. own foot)
`apee-03-results-tables.pdf` — relative TVA means (pattern 0/1/2 = 1.00 / 1.59 /
1.80, all *p* < 0.01) and bFaaaP vs. the player's own foot (no significant
difference, *p* > 0.05).

![APEE results tables](previews/apee-03-results-tables.png)

### A4 · Per‑recording data — Class I (adults), anonymised
`apee-04-classI-subjects-data-anonymized.pdf` — subjects **No. 1–7**, the full
per‑recording table (date, age, piano, device, offset, multiplier, pattern 0/1/2
TVA, test no.).

![Class I subjects data](previews/apee-04-classI-subjects-data-anonymized.png)

### A5 · Per‑recording data — Class II (children) & Class III, anonymised
`apee-05-classII-III-subjects-data-anonymized.pdf` — subjects **No. 8–15**.
No. 14 (partial leg disability **and** a tracheotomy) chose a small offset (3–5°)
and a large multiplier (40–50) so a limited head tilt still spanned the full
pedal — the inclusive‑reach case highlighted in the paper.

![Class II/III subjects data](previews/apee-05-classII-III-subjects-data-anonymized.png)

### A6 · Test protocol
`apee-06-test-protocol.pdf` — the step‑by‑step participant protocol used in the study.

![Test protocol](previews/apee-06-test-protocol.png)

### A7 · Head‑tilt angle during real performance
`apee-07-head-tilt-angle-histogram.pdf` — PCT Fig. 26. The distribution of head
tilt while actually playing the piano (most motion within ≈ ±5°). This is the
empirical reason for a small **offset/dead‑zone**: ordinary playing motion should
*not* trigger the pedal.

![Head-tilt angle histogram](previews/apee-07-head-tilt-angle-histogram.png)

---

## B. System architecture (2018 PCT form)

### B1 · System configuration block diagram
`system-01-configuration-block-diagram.pdf` — detector side (angle sensor → data
processor with **offset** + **multiplier** → transmitter) and actuator side
(receiver → actuator controller with **free pedal play** + **actuation width** →
actuator). Note the control‑law terms are present already in 2018.

![System configuration](previews/system-01-configuration-block-diagram.png)

### B2 · Sensor‑side processing flowchart
`system-02-flowchart-sensor-side.pdf`

![Sensor-side flow](previews/system-02-flowchart-sensor-side.png)

### B3 · Program flow (detector side + actuator side)
`system-03-program-flow-detector-actuator.pdf`

![Program flow](previews/system-03-program-flow-detector-actuator.png)

---

## C. Early concepts (superseded — historical interest)

### C1 · Early M5Stack binary‑change head sensor (2018‑06)
`history-01-early-m5stack-binary-motion-detector.pdf` — the early detector built
on an M5Stack (gyroscope), before the move to smartphone ARKit face tracking.
(Several early APEE recordings are labelled "bFaaaP2 (M5Stack)".)

![Early M5Stack detector](previews/history-01-early-m5stack-binary-motion-detector.png)

### C2 · Early "sound‑proof chamber" housing concept
`history-02-early-embodiment-soundproof-chamber.pdf` — a hand‑drawn embodiment
with a sound‑proof chamber and weight chambers. This is **very different** from
today's lightweight Pro, which instead absorbs the reaction force with a pneumatic
**airback** on a neighbouring pedal — a good illustration of how the design
evolved.

![Early soundproof-chamber concept](previews/history-02-early-embodiment-soundproof-chamber.png)

---

*Provenance:* figures originate from the bFaaaP PCT application
(WO 2019/176164) and its APEE study, by the bFaaaP team. See also
[`bfaaap_patent_info/`](../../../bfaaap_patent_info/) for the granted patents and
examination history. Multi‑page PDFs (the subject‑data tables and the embodiment
drawings) are included in full; the inline images above show the first page only.
