# bFaaaP — a hands‑free piano pedal you can build 🎹

![bFaaaP — play the pedal with a tilt of your head](docs/media/illustrations/hero-opensource.png)

> **bFaaaP** — *(**b**arrier‑**F**ree **a**ssist **a**s **a** **P**edal)* — is an **AI
> assistive piano‑pedal system**. Tilt your head a little and the sustain pedal goes down —
> **no feet needed.** An iPhone/iPad reads your head angle with on‑device AI and sends it over
> Bluetooth to a small device that presses (or switches) the piano's pedal.

It exists so that people who can't easily use a foot pedal — players with limb disabilities,
small children, the elderly, even a user with a tracheostomy — can play the piano with the
full expressive power of the pedal. And it's **open source**: this repository has everything
to build the device and run the controller **yourself**.

### Start here
🌱 **New?** → [**The bFaaaP story**](docs/story.md) · [How it works](docs/how-it-works.md) · [Glossary](docs/GLOSSARY.md)
🔧 **Make one** → [**Build it yourself**](docs/build/) (iOS · Pro · Switch)
🤖 **Get help** → [AI‑assisted Support](docs/ai-support.md) · 💛 [Support the project](SUPPORT.md)

> Status: this folder (`github_opensource/`) is the staging area being prepared for public
> release (see [`PUBLISHING-CHECKLIST.md`](PUBLISHING-CHECKLIST.md)). Docs are **English‑first**;
> Japanese & German will follow in `i18n/` subfolders.

---

## What is bFaaaP?

![What is bFaaaP — a player using the head‑tilt sensor and smart pedal](docs/media/illustrations/intl-what-bfaaap.png)

A small head movement becomes a pedal press. You set your own **threshold** (how far to tilt)
and **speed**, so the pedalling is tuned to *you* — not just a crude on/off. See
[How it works](docs/how-it-works.md) for the friendly explanation.

## Two hardware lines, one app

![Pro for acoustic pianos, Switch for digital pianos](docs/media/illustrations/intl-pro-switch.png)

| Line | For | How it actuates |
|------|-----|-----------------|
| 🎹 **bFaaaP Pro** | Acoustic pianos (**grand & upright**) | a **motor physically presses** the sustain pedal, anchored by an *airback* air‑cushion → [`device-pro-acoustic/`](device-pro-acoustic/) |
| 🎛️ **bFaaaP Switch** | **Electric pianos & keyboards** | plugs into the **sustain‑pedal jack** as an **electronic switch** (no motor/airback) → [`device-switch-electronic/`](device-switch-electronic/) |

The **same iOS app** ([`ios-app/`](ios-app/)) drives both lines; the Bluetooth protocol is identical.

## How it works

![System architecture](docs/media/diagrams/architecture.png)

```
   Your head tilt
        │  ARKit / TrueDepth face tracking (iPhone/iPad AI)
        ▼
┌──────────────┐   BLE  "i00".."i99"   ┌─────────────────┐  UART  ┌──────────────┐  drive
│   iOS app    │ ────────────────────▶ │ BLE board nRF52  │ ─────▶ │  Pico RP2040 │ ─────▶ piano pedal
└──────────────┘                       └─────────────────┘        └──────────────┘
```

A key design point: ARKit produces head angles much faster than BLE should send them, so the
app **paces** the radio (a 100 ms timer + throttle) to keep the link solid — see
[`ios-app/DESIGN-HIGHLIGHTS.md`](ios-app/DESIGN-HIGHLIGHTS.md).

## Build it yourself

Open the **[Build hub](docs/build/)** and pick a track. The short version (Pro):

1. **Print & assemble** the mechanical parts — [`device-pro-acoustic/hardware/`](device-pro-acoustic/hardware/).
2. **Wire & flash** both boards — [`docs/toolchain/`](docs/toolchain/) (VS Code / PlatformIO / Arduino).
3. **Anchor** with the airback; set the travel limit.
4. **Build & install the iOS app** — [`ios-app/`](ios-app/) (your own signing team & bundle ID).
5. **Pair, calibrate, and play** — [`docs/operation/`](docs/operation/).

Stuck on any step? **[Ask in AI‑assisted Support](docs/ai-support.md)** — a maintainer‑reviewed
Q&A (it's not instant; real people check each answer).

### Bill of materials (overview, Pro line)
- iPhone / iPad with **TrueDepth** front camera (head tracking)
- **Raspberry Pi Pico** (main) + **nRF52840** BLE board (bridge)
- **IQ‑FORTIQ‑M42BLS‑100** motor *(reference v039B; EOL → closed‑loop‑stepper successor with a
  DRV8825‑compatible interface)* driving a **2GT belt → T10 lead‑screw → push‑rod** on an
  aluminium‑extrusion frame
- **HX711** air‑pressure sensor, **2SK4017** MOSFET (pump), travel‑limit slider, **24 V PSU**
  *(self‑calibration uses motor **power**, not current — so supply voltage doesn't matter)*
- 3D‑printed parts (PLA+) + **airback** anchoring kit
- Full BOM & part numbers: [`device-pro-acoustic/hardware/PARTS-REFERENCE.md`](device-pro-acoustic/hardware/PARTS-REFERENCE.md)

> ⚠️ Some original parts are **EOL** (notably the IQ/Fortiq motor). Replacements & firmware tips:
> [`device-pro-acoustic/HARDWARE-AVAILABILITY.md`](device-pro-acoustic/HARDWARE-AVAILABILITY.md).

## The story, the people, the music 🎬

bFaaaP began in **2018** from one wheelchair user's wish to play the piano, and grew into a
team of engineers and musicians. Read the whole journey — with member introductions and **every
performance video** — in **[The bFaaaP story](docs/story.md)**.

![Platanus with bFaaaP — concert](docs/media/poster_concert_pro_2025.jpg)

- 📜 [History](docs/HISTORY.md) · 👥 [Members](docs/members/) · 🎥 [All videos](docs/videos/)
- ▶ **Best single demo** (grand piano, *with a setup walkthrough at 25:01*): <https://www.youtube.com/watch?v=V3cXeNW9jXY>

## 💛 Support

The devices aren't sold — your support keeps bFaaaP free and growing (development, the
AI‑assisted Support service, parts/loaners, and inclusive concerts & lessons). See
[**SUPPORT.md**](SUPPORT.md) (PayPal now; Stripe — card / Apple Pay / Google Pay — coming) or use
the **Sponsor** button on this repo.

## Repository layout

| Folder | Contents |
|--------|----------|
| [`ios-app/`](ios-app/) | iOS controller app — code, design notes, build guide, sanitized `src/`. Drives both lines. |
| [`device-pro-acoustic/`](device-pro-acoustic/) | **Pro** (acoustic): firmware, hardware (`cad/`, `3d-print/`, `airback/`, `schematic/`), motor info, assembly. |
| [`device-switch-electronic/`](device-switch-electronic/) | **Switch** (electric/keyboard): electronic‑sustain design (in progress). |
| [`docs/`](docs/) | Story, how‑it‑works, glossary, build hub, AI‑support, architecture, operation, toolchain, videos, members, history. |
| [`bfaaap_arxiv_latex/`](bfaaap_arxiv_latex/) | The research **arXiv preprint** (LaTeX). |
| [`bfaaap_patent_info/`](bfaaap_patent_info/) | Plain‑language patent guide + prosecution files. |

## License

A final license is **proposed** (see [`LICENSE`](LICENSE); full license texts live in
`LICENSES/`): a three‑layer split — **Apache‑2.0** (software: iOS app, firmware; explicit patent grant),
**CERN‑OHL‑W‑2.0** (hardware: CAD, 3D‑print, schematic), **CC‑BY‑4.0** (documentation).
Third‑party components keep their own licenses (e.g. the IQ module library).

## 📄 Research

A LaTeX **arXiv** preprint (`main.tex`) is in [`bfaaap_arxiv_latex/`](bfaaap_arxiv_latex/). It
frames bFaaaP as inclusive design / human–machine interaction whose inventive core is a
**quantitative, user‑tunable head‑angle control law**, validated by a **human‑subject clinical
evaluation (APEE)**. Authors: T. Shishido (corresponding), H. Narusawa. *(A peer‑reviewed ACM
TACCESS version is maintained privately.)*

## Patents, trademark & design

The control method — generating the pedal signal from **two parameters: a head‑angle
*threshold* (an offset range within which the actuator is not driven) and the *press speed* /
user preference** — is patented. **Two patents are in force in Japan**, with an English **PCT**
as priority basis:

| Kind | Number | Title | Link |
|------|--------|-------|------|
| Patent (JP) | **特許第6726319号** — JP 6726319 B2 | Auxiliary pedal system | <https://patents.google.com/patent/JP6726319B2/en> |
| Patent (JP) | **特許第7004771号** — JP 7004771 B2 | Device controller | <https://patents.google.com/patent/JP7004771B2/en> |
| PCT (EN, priority) | **WO 2019/176164** | Auxiliary pedal system | <https://patentscope.wipo.int/search/en/detail.jsf?docId=WO2019176164> |

Inventors: H. Narusawa, M. Ootaki, T. Shishido, K. Yamaguchi, D. Tokushige. **bFaaaP®** is a
registered trademark; the glasses‑mounted motion sensor is a registered design. Full prosecution
file & a plain‑language guide: [`bfaaap_patent_info/`](bfaaap_patent_info/).

### Patent licensing
Licensing generally **depends on the intended embodiment**. However, **for uses with a genuinely
public, open purpose the authors intend to grant a licence free of charge** — in particular **for
products/services (even commercial) that help people with disabilities participate more
inclusively, bFaaaP patent licensing is, as policy, free.** If that fits your use, please contact
**Tomoyuki Shishido** (ORCID <https://orcid.org/0000-0002-8944-2088>).

## Credits

Developed by **Tomoyuki Shishido** and the bFaaaP / **Platanus** members (incl. M. Ootaki,
H. Narusawa, and others — see [Members](docs/members/)). The iOS app is on the App Store as
**bFaaaPSwitch**. Illustrations by **Saki Shiokawa** and the bFaaaP project (AI‑assisted).
