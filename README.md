# bFaaaP — Open Source Hands‑Free Piano Pedal

**bFaaaP** — *(**b**arrier‑**F**ree **a**ssist **a**s **a** **P**edal)* — is an
**AI assistive piano‑pedal system** (AI補助ピアノペダルシステム).

It lets people who cannot easily use a foot pedal — players with limb
disabilities, small children, and the elderly — sustain piano tones with a
small **head motion**. A head tilt is detected by an iPhone/iPad's **AI**, sent
over Bluetooth Low Energy to a pedal device, and that device presses the piano
pedal to sustain the note.

This repository collects everything needed to **build the device and run the
controller yourself**: the iOS app, the microcontroller firmware, the
3D‑printable mechanical parts, and the documentation.

> Status: this folder (`github_opensource/`) is the staging area being prepared
> for public release. See [`PUBLISHING-CHECKLIST.md`](PUBLISHING-CHECKLIST.md)
> for items to review **before** going public.
>
> Language: documentation is being written **English‑first**; Japanese and
> German versions are planned in separate `i18n/` subfolders.

---

## Two hardware lines, one app

| Line | For | How it actuates |
|------|-----|--------|
| **bFaaaP Pro** | Acoustic pianos (**grand & upright**) | a **motor physically presses** the sustain pedal → [`device-pro-acoustic/`](device-pro-acoustic/) |
| **bFaaaP Switch** | **Electric pianos & keyboards** | plugs into the **sustain‑pedal jack** as an **electronic switch** (no motor/airback) → [`device-switch-electronic/`](device-switch-electronic/) |

The **same iOS app** ([`ios-app/`](ios-app/)) drives both lines; the BLE
protocol is identical.

## How it works

```
   User head motion
        │  ARKit / TrueDepth face tracking
        ▼
┌─────────────────────┐   BLE  (Nordic UART Service 6E400001)   ┌──────────────────────┐
│   iOS app           │ ─────────────────────────────────────▶  │  Pedal driver device │
│  (bFaaaPSwitch)     │   "i00".."i99"  +  N / F signal          │  (RP2040 / Pico)     │
└─────────────────────┘                                          └──────────┬───────────┘
                                                                            │ IQ module serial
                                                                            ▼
                                                                 ┌──────────────────────┐
                                                                 │  IQ / Fortiq motor   │ ──▶ piano pedal
                                                                 └──────────────────────┘
```

A key design point: ARKit produces head angles much faster than BLE should send
them, so the app **paces** the radio traffic (a 100 ms timer + event throttle) to
keep the link bug‑free. See
[`ios-app/DESIGN-HIGHLIGHTS.md`](ios-app/DESIGN-HIGHLIGHTS.md).

## Repository layout

| Folder | Contents |
|--------|----------|
| [`ios-app/`](ios-app/) | iOS controller app — code, design notes, build guide, and sanitized source in `src/`. Drives both Pro and Switch. |
| [`device-pro-acoustic/`](device-pro-acoustic/) | **bFaaaP Pro** (acoustic): firmware, hardware (`cad/`, `3d-print/`, `airback/`), motor info, assembly. |
| [`device-switch-electronic/`](device-switch-electronic/) | **bFaaaP Switch** (electric/keyboard): planned. |
| [`docs/`](docs/) | Shared docs: system `architecture/` and `operation/` guide. |

## Bill of materials (overview, Pro line)

- iPhone / iPad with **TrueDepth front camera** (Face ID) — for head tracking
- **Raspberry Pi Pico** (main) + **Adafruit ItsyBitsy nRF52840 Express** (BLE bridge, onboard DotStar)
- **IQ‑FORTIQ‑M42BLS‑100** motor (EOL → closed‑loop stepper / DRV8825) driving a
  **2GT belt → T10 lead screw → push‑rod** on an **aluminium‑extrusion frame**
- **HX711** pressure sensor, **2SK4017** MOSFET (pump), **slide pot** (travel limit), **24 V PSU**
- 3D‑printed parts (PLA+) + **airback** anchoring kit (air jack 119×11 cm + pump + hand controller)
- Full BOM with part numbers/prices: [`device-pro-acoustic/assembly/`](device-pro-acoustic/assembly/)

> ⚠️ **Some original parts are EOL** (notably the IQ/Fortiq motor). Current
> replacements and firmware‑adaptation tips are in
> [`device-pro-acoustic/HARDWARE-AVAILABILITY.md`](device-pro-acoustic/HARDWARE-AVAILABILITY.md).

## Quick start (Pro)

1. **Print & assemble** the mechanical parts — `device-pro-acoustic/hardware/`.
2. **Anchor** the unit with the airback; set the travel limit on the hand controller.
3. **Flash the firmware** to both boards — see [`docs/toolchain/`](docs/toolchain/)
   (VSCode/PlatformIO/Arduino: how to flash, test, and run).
4. **Build & install the iOS app** — `ios-app/` (set your own signing team & bundle ID).
5. Pair, calibrate the head‑angle zero, and play. See [`docs/operation/`](docs/operation/).

> Tooling at a glance: iOS app = **Xcode (Mac)**; boards = **VSCode + PlatformIO/Arduino**;
> 3D parts = a **slicer**. Full steps in [`docs/toolchain/`](docs/toolchain/).

## License

Project license is **not yet chosen** — see [`LICENSE`](LICENSE) and the
checklist. Third‑party components keep their own licenses (e.g. the IQ module
library under `device-pro-acoustic/firmware/libraries/`).

## Demo & links

![Platanus with bFaaaP](docs/media/poster_concert_pro_2025.jpg)

- Project site: **<https://bfaaap.com>** · device store (build‑to‑order, Japan):
  <https://ui.saaipf.com/app3/>
- **Source repository:** <https://github.com/TomoShishido/bfaaap_opensource>
  (one of T. Shishido's repositories; **private during preparation** — made public
  after review and after obtaining the members' consent)
- iOS app on the App Store: <https://apps.apple.com/jp/app/bfaaapswitch/id1545866059>
- **Pro** (acoustic) demo — incl. a **setup walkthrough at 25:01–28:32**:
  <https://www.youtube.com/watch?v=V3cXeNW9jXY>
- **Switch** (electric piano) demo — system intro + workshop:
  <https://www.youtube.com/watch?v=Im4jsed1tJQ>
- **🎥 All videos** (concerts, setup, manual, promotion — by category, newest first):
  [`docs/videos/`](docs/videos/) · channel
  <https://www.youtube.com/channel/UCcAvTy1k8rHs2WrEKPx1amg>
- **User manual:** [`docs/user-manual/`](docs/user-manual/) ·
  **History:** [`docs/HISTORY.md`](docs/HISTORY.md) ·
  **Members:** [`docs/members/`](docs/members/)
- **📄 Preprint (paper):** a LaTeX manuscript describing the system and its
  control method is in [`bfaaap_arxiv_latex/`](bfaaap_arxiv_latex/) (planned for
  arXiv; **arXiv ID to be added**). Authors: T. Shishido (corresponding),
  H. Narusawa.

## Patents, trademark & design

The control method — generating the pedal signal from **two parameters: a head‑
angle *threshold* (an offset range within which the actuator is not driven) and
the *press speed* / user preference** — is patented. **Two patents are currently
in force in Japan**, with an English **PCT** application as the priority basis:

| Kind | Number | Title | Link |
|------|--------|-------|------|
| Patent (JP) | **特許第6726319号** — JP 6726319 B2 | Auxiliary pedal system | <https://patents.google.com/patent/JP6726319B2/en> |
| Patent (JP) | **特許第7004771号** — JP 7004771 B2 | Device controller | <https://patents.google.com/patent/JP7004771B2/en> |
| PCT (priority basis, EN) | **WO 2019/176164** | Auxiliary pedal system | <https://patentscope.wipo.int/search/en/detail.jsf?docId=WO2019176164> |

JPO (J‑PlatPat) records are reachable by number and from the inventors' ORCID
(e.g. T. Shishido — <https://orcid.org/0000-0002-8944-2088>). Inventors:
H. Narusawa, M. Ootaki, T. Shishido, K. Yamaguchi, D. Tokushige. **bFaaaP®** is a
registered trademark; the glasses‑mounted motion sensor is a registered design.

### Patent licensing

Licensing of the patents generally **depends on the counterparty's intended
embodiment / implementation**. However, **for uses with a genuinely public, open
purpose the authors intend to grant a licence free of charge.**

In particular, **for products or services that enable people with disabilities
(and others who need it) to participate in society more inclusively — even
commercial, paid ones — bFaaaP‑related patent licensing is, as a matter of
policy, granted free of charge.** If that applies to your use, please
**contact Tomoyuki Shishido** (via <https://bfaaap.com> or ORCID
<https://orcid.org/0000-0002-8944-2088>).

For software reuse also see [`PUBLISHING-CHECKLIST.md`](PUBLISHING-CHECKLIST.md)
and choose a licence with an explicit patent grant (e.g. Apache‑2.0).

## Credits

bFaaaP is developed by **Tomoyuki Shishido** and contributors (the bFaaaP /
Platanus members — incl. Otaki, Narusawa, and others). The iOS app is published
on the App Store as **bFaaaPSwitch**.
