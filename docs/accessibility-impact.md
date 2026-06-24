# The controller as a reusable accessibility input — and who it could help

> 🌐 **English** · [日本語](../i18n/ja/docs/accessibility-impact.md) · [Deutsch](../i18n/de/docs/accessibility-impact.md)

*(This page summarizes §4.6 “Generality and the practical value of the controller” and the
population discussion of the [paper](../bfaaap_arxiv_latex/README.md), with the two population tables
and the works they cite.)*

## The controller is the reusable part
bFaaaP's smartphone **controller** — a quantitative, **user‑tunable head‑angle channel** on commodity
hardware — is the component of highest practical value, and nothing about it is specific to a pedal.
The same controller already drives **two different actuators** (a motor on the *Pro*, an electronic
switch on the *Switch*), and the underlying **device‑controller method is patented independently of
the pedal**, covering “any device.” So the head‑angle channel is a reusable **inclusive input**.

## Why it fits these populations
- **Foot‑free** — it does not depend on the lower limbs that **wheelchair users** often cannot use.
- **Nothing on the face or head** — the phone sits on a stand. This matters for people with a
  **tracheostomy**, facial sensitivity, or who must keep the airway and face clear.
- **Tunable to a restricted range of motion** — a *small offset* with a *large multiplier* lets a few
  degrees of residual head movement span the full output (as one study participant with a leg
  disability and a tracheostomy showed).

Because the head‑angle signal is a **continuous, proportional value** — not a single on/off switch —
it is a general **accessibility‑control primitive**: the same channel that here meters a sustain pedal
could, in principle, meter other graded controls (an environmental‑control setting, a communication‑aid
scan rate, a powered‑device level). *We present this as a direction for future work: bFaaaP is
validated for piano pedalling; broader assistive control is not yet validated.*

## How many people? (worldwide scale)
The populations are large and worldwide. **The figures below come from heterogeneous surveys with
different definitions/metrics and are not strictly comparable** — they convey scale, not a precise
ranking. (WHO publishes only a single *global* wheelchair estimate, not a country‑by‑country table.)

### Table 1 — Wheelchair users (or people who *need* a wheelchair), by region
| Region | Estimate | Year | Source |
|--------|----------|------|--------|
| World | ~80 million (~1% of the population) **need** a wheelchair | — | WHO [1], [2] |
| USA | 3.6 million users (1.5%, aged 15+) | 2010 | US Census [3] |
| UK (England) | ~1.2 million users (estimate) | 2017 | NHS England [4] |
| Canada | 288,800 wheelchair/scooter users (~1.0%) | 2012 | Smith et al. [5] |
| Japan | ~818,000 manual wheelchairs in use (~0.6%) | 2019 | Shirogane et al. [6] |
| Australia | ~119,000 manual‑wheelchair users (65+); 679,000 use mobility aids | 2018 | AIHW / ABS SDAC [7] |

*Definitions differ (“users” vs. “need”; community‑only vs. all; age cut‑offs); Germany has no official wheelchair‑user count.*

### Table 2 — Home mechanical ventilation (HMV) and the invasive/tracheostomy subset, by country
| Country | HMV users | Invasive (trach.) | per 100k | Year | Source |
|---------|-----------|-------------------|----------|------|--------|
| Japan | ~21,000 | 7,700 (TPPV) | — | 2020 | MHLW [8] |
| Europe (16 countries) | 21,526 | varies | 6.6 | 2002 | Eurovent [9] |
| Canada | 4,334 | ~18% | 12.9 | 2012 | Rose et al. [10] |
| Poland | 12,616 | — | 2.8→20.0 | 2009–19 | Czajkowska‑Malinowska et al. [11] |
| Hungary | 384 | 40 (10.4%) | 3.9 | 2018 | Valkó et al. [12] |
| South Korea | — | 62.8% trach. | 9.3 | 2016 | Kim et al. [13] |
| Germany | ~17,000/yr (episodes) | ~6% | — | 2018 | Schwarz et al. [14] |
| USA | no national registry | — | — | — | Mehta et al. [15] |

*Metric types differ: point‑prevalence headcount (Japan), prevalence per 100,000 (Europe, Canada, Poland, Hungary, South Korea), inpatient episodes/year (Germany), and no national home‑ventilation registry in the USA.*

## Cited works (references)
Verified June 2026. Saved copies of the open‑access/public sources are in
[`docs/references/`](references/README.md).

1. WHO. *WHO releases new wheelchair provision guidelines.* 2023. <https://www.who.int/news/item/05-06-2023-who-releases-new-wheelchair-provision-guidelines>
2. WHO & UNICEF. *Global Report on Assistive Technology.* 2022. <https://www.who.int/publications/i/item/9789240049451>
3. Brault, M. *Americans With Disabilities: 2010.* US Census Bureau, P70‑131, 2012. <https://www2.census.gov/library/publications/2012/demo/p70-131.pdf>
4. NHS England. *Wheelchair services.* <https://www.england.nhs.uk/wheelchair-services/>
5. Smith EM, Giesbrecht EM, Mortenson WB, Miller WC. *Prevalence of Wheelchair and Scooter Use Among Community‑Dwelling Canadians.* Phys Ther 96(8):1135–1142, 2016. <https://doi.org/10.2522/ptj.20150574>
6. Shirogane S, et al. *Provision of public funding for wheelchairs and postural support devices in Japan.* J Phys Ther Sci 31(2):122–126, 2019. <https://doi.org/10.1589/jpts.31.122>
7. AIHW. *People with disability in Australia* (ABS SDAC 2018). <https://www.aihw.gov.au/reports/disability/people-with-disability-in-australia>
8. MHLW (Japan), Intractable‑Disease Policy Research. *Nationwide home mechanical‑ventilation survey* (as of 2020). <https://mhlw-grants.niph.go.jp/>
9. Lloyd‑Owen SJ, et al. *Patterns of home mechanical ventilation use in Europe: results from the Eurovent survey.* Eur Respir J 25(6):1025–1031, 2005. <https://doi.org/10.1183/09031936.05.00066704>
10. Rose L, et al. *Home Mechanical Ventilation in Canada: A National Survey.* Respir Care 60(5):695–704, 2015. <https://doi.org/10.4187/respcare.03609>
11. Czajkowska‑Malinowska M, et al. *Development of Home Mechanical Ventilation in Poland in 2009–2019…* J Clin Med 11(8):2098, 2022. <https://doi.org/10.3390/jcm11082098>
12. Valkó L, Baglyas S, Gál J, Lorx A. *National survey: current prevalence and characteristics of home mechanical ventilation in Hungary.* BMC Pulm Med 18:190, 2018. <https://doi.org/10.1186/s12890-018-0754-x>
13. Kim H‑I, et al. *Home Mechanical Ventilation Use in South Korea Based on National Health Insurance Service Data.* Respir Care 64(5):528–535, 2019. <https://doi.org/10.4187/respcare.06310>
14. Schwarz SB, et al. *The Development of Inpatient Initiation and Follow‑up of Home Mechanical Ventilation in Germany.* Dtsch Arztebl Int 118(23):403–404, 2021. <https://doi.org/10.3238/arztebl.m2021.0193>
15. Mehta AB, et al. *Trends in Tracheostomy for Mechanically Ventilated Patients in the United States, 1993–2012.* Am J Respir Crit Care Med 192(4):446–454, 2015. <https://doi.org/10.1164/rccm.201502-0239OC>
16. bFaaaP device‑controller patent: **JP 7004771 B2** (covers “any device”). <https://patents.google.com/patent/JP7004771B2>

---

← Back to [How it works](how-it-works.md) · [APEE study](apee-study.md) · [Glossary](GLOSSARY.md)
