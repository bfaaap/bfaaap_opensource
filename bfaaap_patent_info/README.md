# bFaaaP — Patent information

This folder collects the **patent file‑wrapper documents** behind bFaaaP's
head‑angle pedal‑control technology: the originating **English PCT** application and
its international search report, and the **two granted Japanese patents** (one for
the *Pro* acoustic pedal robot, one for the head‑angle *controller*), each with its
office action(s), amendment, and written argument.

> 📖 **New to patents?** Read the plain‑language guide first:
> **[`general_description/README.md`](general_description/README.md)** — it explains
> the Japanese patent procedure with diagrams, how the English PCT becomes Japanese
> patents, and walks through both patents' prosecution with the examiner‑vs‑applicant
> key points and the **academic take‑aways** used to re‑frame the papers.

## The family in one picture

```
English PCT  PCT/JP2018/041771  (= WO 2019/176164 A1, filed 2018-11-12)
      │
      ├── ISR + Written Opinion (ISA = JPO, mailed 2019-01-29)
      │
      └── Japan national phase → 特願2018-567754
                 ├── JP 6726319 B2  「補助ペダルシステム」 Auxiliary Pedal System   (reg. 2020-06-30)
                 └── divisional 特願2020-110051
                            └── JP 7004771 B2  「デバイスコントローラー」 Device Controller (reg. 2022-01-06)
```

Inventors (both patents): **Hiroyuki Narusawa, Masahiro Ootaki, Tomoyuki Shishido,
Kyoko Yamaguchi, Daisuke Tokushige.** Patentees: **Tomoyuki Shishido** and
**Otaki Architectural Office, Ltd.** (有限会社大滝建築事務所).

## Folder contents

| File | What it is | Public? |
|------|-----------|---------|
| `WO2019176164A1/bFaaaP_PCT_WO2019176164A1.pdf` | PCT pamphlet (the application as published) | gazette — unchanged |
| `WO2019176164A1/ISR_20190131.pdf` | International Search Report + Written Opinion | transmittal **address redacted** |
| `JP6726319B_auxiliarypedalsystem/bFaaaP_JPB 006726319.pdf` | Granted patent gazette | gazette — unchanged |
| `JP6726319B…/First_OfficeAction_*.pdf` | Office Action, 2020‑04‑21 | — |
| `JP6726319B…/WrittenAmendment_*.pdf` | Amendment, 2020‑06‑13 (underlined = changes) | — |
| `JP6726319B…/WrittenOpinion_*.pdf` | Written Argument, 2020‑06‑13 | — |
| `JP6726319B…/Certificate_JP6726319B_*.pdf` | Certificate of patent | **address redacted** |
| `JP7004771B_devicecontroller/DeviceController_JP7004771B.pdf` | Granted patent gazette | gazette — unchanged |
| `JP7004771B…/AppealLevel_OfficeAction_*.pdf` | Appeal‑stage Office Action, 2021‑10‑20 (FINAL) | — |
| `JP7004771B…/WrittenAmendment_*.pdf` | Amendment, 2021‑11‑25 (underlined = changes) | — |
| `JP7004771B…/WrittenOpinion_*.pdf` | Written Argument, 2021‑11‑25 | — |
| `JP7004771B…/Certificate_JP7004771B_*.pdf` | Certificate of patent | **address redacted** |
| `general_description/README.md` | Plain‑language guide (start here) | — |

## Patent 1 — JP 6726319 B2 「補助ペダルシステム」 (Auxiliary Pedal System)

The **bFaaaP Pro** invention: head motion → processor → actuator presses an
**acoustic** piano pedal. Granted **2020‑06‑30**.

- **Office Action (2020‑04‑21)** — novelty §29(1), inventive step §29(2), clarity
  §36(6)(ii). Cited: **(1)** JP 2017‑21461 A (HMD, head‑angle + customizable
  threshold); **(2)** NPL *Head‑Activated Piano Pedal*, CanAssist/U. Victoria (2018);
  **(3)** JP 2006‑154504 A (Yamaha, pedal assist / free‑play offset).
- **Amendment (2020‑06‑13)** — 39→15 claims; added the **quantitative control law**:
  `command = (head_tilt − offset_upper_limit) × multiplier`, **multiplier 10–50
  (user‑chosen)**, full press within **+2–10°** (from the human‑subject *APEE* study).
- **Granted** essentially as amended (17 days later).

## Patent 2 — JP 7004771 B2 「デバイスコントローラー」 (Device Controller)

The **head‑angle controller** (iOS side), generalizing beyond the pedal. A
**divisional** of Patent 1; refused in ordinary examination and **granted on appeal**
(不服2021‑11503). Granted **2022‑01‑06**.

- **Appeal Office Action (2021‑10‑20, FINAL)** — clarity §36(6)(ii), support
  §36(6)(i), inventive step §29(2). Cited: **(1)** JP (Tokuhyō) 2012‑514392 A
  (head‑gesture earphone/headset controller; ±5° dead range, 3.5° steps, 3 dB
  steps, USB‑adjustable sensitivity); **(2)** JP 2017‑21461 A (HMD, glasses sensor).
- **Amendment (2021‑11‑25)** — 8→5 claims; added a **pre‑adjustable _response speed_**
  and the **3–10° / +2–10°** window, made concrete as **"usable by people with a leg
  disability *and* a tracheostomy"** (spec Table 2, subject #14).
- **Granted** after appeal (≈6 weeks later).

## PCT International Search Report — citation list

PCT/JP2018/041771, ISA = JPO, mailed **2019‑01‑29**. Opinion: claims **1–39** had
**novelty** and **industrial applicability**, but **no inventive step** over:

| Ref | Cat. | Document | Claims |
|-----|------|----------|--------|
| D1 | Y | NPL *Head‑Activated Piano Pedal*, CanAssist (U. Victoria), online 2018‑04‑02 | 1–39 |
| D2 | Y | JP 2017‑37567 A (COLOPL) | 1–39 |
| D3 | Y | JP 2014‑95953 A (Tokyo Tech) · WO 2014/073121 A1 | 1–39 |
| D4 | Y | US 2018/0064371 A1 (ALPS Electric) · WO 2016/194581, EP 3305193, CN 107708552 | 2–3, 8–11, 14–15, 18–19, 22–23, 26–27, 30–33, 36–39 |
| D5 | Y | JP 2006‑154504 A (Yamaha) · US 2006/0112809 A1 | 20–27 |
| — | A | US 4736664 A (Hinsley & Norwood, 1988) — background | 1–39 |

Full reasoning and links: [`general_description/README.md`](general_description/README.md#6-the-pct-international-search-isr-and-its-citations).

## Privacy & licensing

- **Redaction:** personal **addresses** on the **certificates** and the **ISR
  transmittal pages** were blacked out before publication; the **public gazettes**
  (PCT pamphlet, granted‑patent 公報) are unchanged. See the privacy note in the
  guide.
- **Licensing policy:** free for genuinely public/open uses, and — as a matter of
  policy — free for products/services that enable inclusive participation by people
  with disabilities (even commercial ones). Contact **Tomoyuki Shishido** via
  <https://bfaaap.com> / ORCID <https://orcid.org/0000-0002-8944-2088>. See the
  [top‑level README](../README.md#patent-licensing).
