# Media credits & licensing

Figures and illustrations in this repository, with their source and credit. Unless noted,
documentation media is released under **CC‑BY‑4.0** (see [`../../LICENSE`](../../LICENSE)).

## Illustrations (`illustrations/`)

Warm hand‑drawn **Saki Shiokawa (塩川紗季) style**, AI‑assisted (Gemini), created for the
bFaaaP project. **© Shishido & Associates.**

| File | Use |
|------|-----|
| `hero-opensource.png` | Open‑source hero |
| `hero-hardware-software.png` | Hardware/software hero |
| `intl-what-bfaaap.png` | "What is bFaaaP" / story opener |
| `intl-how-it-works.png` | Concept flow (intent → face → BLE → controller) |
| `intl-pro-switch.png` | Pro (acoustic) vs Switch (digital) |
| `pro-play-hero.png` | Pro build hero — playing a grand piano foot‑free (build/pro) |
| `switch-play-hero.png` | Switch build hero — playing a digital keyboard foot‑free (build/switch) |
| `ai-team-hero.png` · `ai-team-redraw.png` · `ai-team-motor.png` · `ai-team-firmware.png` | Scenes for [AI & Team Live](../ai-team-live.md) (team + AI; sketch→redraw; choosing the motor; firmware compiles) |
| `intl-support.png` | Support / community |
| `intl-build-community.png` | Build / community |
| `control-law-key.png` | The control law as the "key": a head tilt unlocking the player's own intended, natural pedalling (how-it-works) |
| `apee-children.png` | An APEE session: children & a wheelchair user taking the friendly piano test (apee-study) |
| `../history/bfaaap-1-original/bfaaap1-pianist-2018.png` | bFaaaP 1 (2018): a pianist wearing the glasses‑mounted sensor (history) |

### Member avatars (`avatars/`)

Round avatar icons of the team — cropped from the member illustrations (Saki Shiokawa style) —
plus a friendly **AI‑assistant** avatar (`ai.png`, AI‑generated with Gemini in the same style).
Used in [AI‑assisted Support](../ai-support.md) Discussions‑style threads. Full list, usage and
the **display‑name‑only** rule for *kana* / *Midori*: [`avatars/README.md`](avatars/README.md).
**© Saki Shiokawa / bFaaaP** (member art) · **© Shishido & Associates** (AI avatar).

## Diagrams (`diagrams/`)

Generated with matplotlib (data/process figures). **CC‑BY‑4.0.**

| File | Use |
|------|-----|
| `ai-support-timeline.png` | How AI‑assisted Support works (timeline) |
| `ai-team-flow.png` | The AI × team collaboration loop + the story timeline ([AI & Team Live](../ai-team-live.md)) |
| `bom-evolution.png` | How each unknown BOM/circuit item was pinned down via Q&A (unknown → confirmed) |
| `illustrations/airback-anchoring.png` | The Pro **"airback"** reaction‑force anchoring — mechanism schematic (matplotlib, hand‑drawn by the maintainer, **not** Gemini) |
| `diagrams/fig-control-law.png` | Paper **Figure 3** — head‑angle control law (matplotlib; rendered from `bfaaap_arxiv_latex/figures/fig_control.pdf`) |
| `diagrams/fig-control-vs-priorart.png` | Paper **Figure 4** — quantitative, user‑tunable mapping vs. binary prior art (matplotlib; from `fig_control_vs_priorart.pdf`) |
| `diagrams/fig-apee-pipeline.png` | APEE method end‑to‑end — score/patterns → record → TVA → normalize → result (paper figure) |
| `diagrams/fig-apee-test-score.png` | The actual APEE test score, pedal patterns 1 & 2 (reproduced from the patent figures) |
| `diagrams/fig-apee-tva.png` | Computing the sustain score from the tone‑vibration area (paper figure) |
| `diagrams/fig-apee-results.png` | APEE clinical results (paper figure) |
| `diagrams/table-apee-data.png` | **Appendix A** — full anonymized APEE per‑recording data (matplotlib table, parsed from `appendix_apee_data.tex`) |
| `../history/bfaaap-1-original/the-invention-from-the-start.png` | bFaaaP 1 — “the invention was already here”: control law constant, sensor/mount evolved (matplotlib; history) |
| `../history/bfaaap-1-original/then-vs-now-sensor-and-motor.png` | bFaaaP 1 vs today: glasses sensor + large Oriental Motor stepper motor → smartphone + compact/no motor (matplotlib; history) |
| `../history/bfaaap-1-original/anchoring-weight-vs-airback.png` | bFaaaP 1 vs today: reaction force resisted by metal weight in a bottom compartment → anchored by the airback (matplotlib; history) |
| `../../device-pro-acoustic/hardware/reference/pico_pinout_bfaaap.png` | Raspberry Pi Pico — bFaaaP Pro pin map (matplotlib; **redrawn to replace an unknown‑license image**; official pinout: raspberrypi.com) |
| `../../device-pro-acoustic/hardware/reference/fortiq42_interface_bfaaap.png` | IQ Fortiq BLS42 connector & bFaaaP wiring (matplotlib; **redrawn to replace a vendor image**; authoritative pinout: Vertiq docs) |
| `../../device-switch-electronic/assembly/switch-enclosure-reference.png` | bFaaaP Switch 3D-printable enclosure — reference drawing (matplotlib; **AI draft design**; paired with `.scad` + `.stl`) |
| `../../device-pro-acoustic/hardware/airback/airback-dimensions.png` | bFaaaP Pro airback — WINBAG air jack reference drawing (matplotlib; dims from photos + product match) |
| `../../device-pro-acoustic/hardware/reference-design/pro-architecture.png` | bFaaaP Pro reference **system architecture** (matplotlib; **AI draft**, adaptable) |
| `../../device-pro-acoustic/hardware/reference-design/pro-mechanical-layout.png` | bFaaaP Pro **mechanical layout** — vertical drive (matplotlib; drawn after H. Narusawa's working‑unit sketch) |

## Photos & posters (`./`, member portraits, device photos)

- `poster_concert_*.jpg`, `bfaaap_promotion.png` — bFaaaP event posters/promotion. **© bFaaaP team / Platanus.**
- `../members/*.jpg|png` — member caricatures by **Saki Shiokawa (塩川紗季)**.
- `../../device-pro-acoustic/hardware/photos/*.jpg` — build photos. **© bFaaaP team** (Taguchi).

> Generation note: AI figures are produced locally with the private tooling in
> `AI-assistedSupport/` (not part of this repo); only the **output images** are committed
> here. Photos are committed directly (never hot‑linked to bfaaap.com).
