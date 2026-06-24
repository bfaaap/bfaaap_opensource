# Source map — which files back each explanation

> 🌐 **English** · [日本語](../i18n/ja/docs/SOURCE-MAP.md) · [Deutsch](../i18n/de/docs/SOURCE-MAP.md)

A single index of **what is explained where**, and **which source file, CAD model, schematic,
code, photo, or figure it corresponds to** (with its location in this repository). Use this to
jump from any topic to its authoritative files. All paths are relative to the repo root
(`github_opensource/`).

> Legend: 📄 doc · 💻 code · 📐 CAD/3D · ⚡ schematic/electronics · 📊 figure (generated) · 📷 photo

## 1. The whole system / how it works
| Topic | 📄 Explanation | Sources & figures |
|------|----------------|-------------------|
| Concept & data flow | [`docs/how-it-works.md`](how-it-works.md) | 📊 [`docs/media/diagrams/architecture.png`](media/diagrams/architecture.png) · 📊 [`media/illustrations/intl-how-it-works.png`](media/illustrations/intl-how-it-works.png) |
| Control law (head angle → pedal) | [`docs/how-it-works.md`](how-it-works.md), patent guide | 📊 [`docs/media/diagrams/control-law.png`](media/diagrams/control-law.png) · 📄 [`bfaaap_patent_info/general_description/`](../bfaaap_patent_info/general_description/README.md) |
| AR↔BLE timing (pacing) | [`ios-app/DESIGN-HIGHLIGHTS.md`](../ios-app/DESIGN-HIGHLIGHTS.md) | 📊 [`docs/media/diagrams/rate-decoupling.png`](media/diagrams/rate-decoupling.png) |
| Glossary of terms | [`docs/GLOSSARY.md`](GLOSSARY.md) | — |

## 2. iOS app
| Topic | 📄 Explanation | 💻 Code / 📷 figures |
|------|----------------|----------------------|
| Build & run | [`ios-app/BUILD.md`](../ios-app/BUILD.md), [`docs/build/ios.md`](build/ios.md) | 💻 [`ios-app/src/bFaaaPSwitch1/`](../ios-app/src/bFaaaPSwitch1/) (Xcode project) |
| Code structure | [`ios-app/CODE-STRUCTURE.md`](../ios-app/CODE-STRUCTURE.md) | 💻 `ios-app/src/bFaaaPSwitch1/` |
| Head-angle (ARKit) | [`ios-app/DESIGN-HIGHLIGHTS.md`](../ios-app/DESIGN-HIGHLIGHTS.md) | 💻 `…/ARKit/` |
| BLE send + pacing (the "100 ms" trick) | [`ios-app/DESIGN-HIGHLIGHTS.md`](../ios-app/DESIGN-HIGHLIGHTS.md), [`ios-app/BLE-CONNECTION-FLOW.md`](../ios-app/BLE-CONNECTION-FLOW.md) | 💻 `…/BLEManager/` |
| App Store assets | [`ios-app/app-store/`](../ios-app/app-store/) | 📷 `ios-app/app-store/screenshots/` |

## 3. Firmware (the device boards)
| Topic | 📄 Explanation | 💻 Code |
|------|----------------|---------|
| Overview / which sketch to use | [`device-pro-acoustic/firmware/README.md`](../device-pro-acoustic/firmware/README.md) | — |
| **Main board (Pico) — reference** | [`firmware/DESIGN-HIGHLIGHTS.md`](../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md), [`firmware/CODE-STRUCTURE.md`](../device-pro-acoustic/firmware/CODE-STRUCTURE.md) | 💻 `device-pro-acoustic/firmware/pico/bFaaaP_autopro_pico_v039B_20250725.ino` |
| BLE board (nRF52) | [`firmware/README.md`](../device-pro-acoustic/firmware/README.md) | 💻 `device-pro-acoustic/firmware/pico/bFaaaPpro_BLE_2024010309_bord_A.ino` |
| Stepper successor (⚠ early, do not build) | [`HARDWARE-AVAILABILITY.md`](../device-pro-acoustic/HARDWARE-AVAILABILITY.md) | 💻 `…/pico/bFaaaP_autopro_pico_v052B_step_20251111.ino` |
| Motor comms library | [`firmware/README.md`](../device-pro-acoustic/firmware/README.md) | 💻 `device-pro-acoustic/firmware/libraries/iq-module-communication-arduino/` |
| Flashing / toolchain | [`docs/toolchain/README.md`](toolchain/README.md) | — |
| Confirmed wiring & calibration notes | [`device-pro-acoustic/DISCORD-FINDINGS.md`](../device-pro-acoustic/DISCORD-FINDINGS.md) | — |

## 4. Electronics / wiring
| Topic | 📄 Explanation | ⚡ schematic / 📷 photo |
|------|----------------|------------------------|
| Parts list (boards, motor, connectors) | [`hardware/PARTS-REFERENCE.md`](../device-pro-acoustic/hardware/PARTS-REFERENCE.md) | ⚡ [`hardware/reference/fortiq42_electrical-interface.png`](../device-pro-acoustic/hardware/reference/fortiq42_electrical-interface.png) |
| Circuit schematic | [`hardware/schematic/README.md`](../device-pro-acoustic/hardware/schematic/README.md) | ⚡ `hardware/schematic/schematic_2025-03-05_kicad.png` · `block-diagram.png` · `power-supply-options.png` |
| Pin map (GP4/5 motor, GP2/3 HX711, GP12 pump, ADC0 slider) | [`firmware/DESIGN-HIGHLIGHTS.md`](../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md) + the `.ino` | ⚡ schematic above |
| I/O panel & power | [`hardware/photos/README.md`](../device-pro-acoustic/hardware/photos/README.md) | 📷 `hardware/photos/pro_io_panel.jpg` · `pro_power_connector.jpg` · `pro_printed_io_panels.jpg` |

## 5. Mechanics — CAD, 3D print, assembly
| Topic | 📄 Explanation | 📐 CAD/STL · 📊 figure · 📷 photo |
|------|----------------|----------------------------------|
| Assembly guide & BOM | [`device-pro-acoustic/assembly/README.md`](../device-pro-acoustic/assembly/README.md), [`docs/build/pro.md`](build/pro.md) | 📊 [`docs/media/diagrams/pro-build-flow.png`](media/diagrams/pro-build-flow.png) |
| Drive mechanism (motor→belt→screw→rod) | [`docs/build/pro.md`](build/pro.md) | 📐 `hardware/cad/from-discord-2025/bfaaap_belt_gotai14.FCStd` · 📊 `docs/media/diagrams/pro-mechanism.png` · 📷 `hardware/photos/pro_components_airback_and_drive.jpg` |
| Editable CAD (curated) | [`hardware/cad/README.md`](../device-pro-acoustic/hardware/cad/README.md) | 📐 `hardware/cad/*.FCStd` |
| Editable CAD (full Discord archive) | [`hardware/cad/from-discord-2025/README.md`](../device-pro-acoustic/hardware/cad/from-discord-2025/README.md) | 📐 `hardware/cad/from-discord-2025/*.FCStd` |
| 3D-print files & settings | [`hardware/3d-print/README.md`](../device-pro-acoustic/hardware/3d-print/README.md) | 📐 `hardware/3d-print/*.stl`, `*.3mf` ; new housing `hardware/3d-print/from-discord-2025/bFaaaP_{AA,CC,DD,E_a,FF}*.stl` |
| Airback anchoring | [`hardware/airback/README.md`](../device-pro-acoustic/hardware/airback/README.md) | 📷 `hardware/photos/airback_air_valve.jpg` |
| Mechanical BOM (CAD-derived) | [`docs/build/pro.md`](build/pro.md) §BOM | 📐 from `hardware/cad/from-discord-2025/` (BREP dimensions) |

## 6. Calibration & operation
| Topic | 📄 Explanation | source |
|------|----------------|--------|
| Setup & daily operation | [`docs/operation/README.md`](operation/README.md) | 🎥 [video](https://www.youtube.com/watch?v=_9YopbCYTmI) |
| End-user manual | [`docs/user-manual/README.md`](user-manual/README.md) | 🎥 [Switch manual](https://youtu.be/XOVENtBsOp4) |
| Pressing-force calibration (DIP, 20–35 W) | [`DISCORD-FINDINGS.md`](../device-pro-acoustic/DISCORD-FINDINGS.md) | 💻 firmware `…v039B….ino` |

## 7. Story, people, research, legal
| Topic | 📄 Explanation | sources |
|------|----------------|---------|
| The story | [`docs/story.md`](story.md) | 📷 members, posters; 🎥 videos |
| History / Members / Videos | [`docs/HISTORY.md`](HISTORY.md) · [`docs/members/`](members/) · [`docs/videos/`](videos/) | 📷 `docs/members/*` |
| Research preprint | [`bfaaap_arxiv_latex/README.md`](../bfaaap_arxiv_latex/README.md) | `bfaaap_arxiv_latex/main.tex`, `figures/` |
| Patents / trademark | [`bfaaap_patent_info/`](../bfaaap_patent_info/README.md) | prosecution PDFs |
| Licensing | [`../LICENSE`](../LICENSE), `LICENSES/` | — |
| AI-assisted Support | [`docs/ai-support.md`](ai-support.md) | 📊 `docs/media/diagrams/ai-support-timeline.png` |
| Support / donate | [`../SUPPORT.md`](../SUPPORT.md) | 📊 `media/illustrations/intl-support.png` |

## 8. Generated figures (what each is) — `docs/media/diagrams/`
| File | Shows | Made with |
|------|-------|-----------|
| `architecture.png` | iOS → BLE → Pico → motor data flow | (reused project figure) |
| `control-law.png` | head angle → pedal mapping (dead-zone, multiplier, hysteresis) | matplotlib |
| `rate-decoupling.png` | AR sampling vs BLE send timing | (reused project figure) |
| `pro-mechanism.png` | drivetrain + airback mechanism | (reused project figure) |
| `pro-build-flow.png` | the 8 Pro build steps → files each uses | matplotlib |
| `ai-support-timeline.png` | the AI-assisted Support process timeline | matplotlib |

Illustrations (`docs/media/illustrations/`) and full credits/licensing: [`docs/media/CREDITS.md`](media/CREDITS.md).

Cited references — saved copies of the open-access papers and the patents, plus stable links and
access dates for everything else: [`docs/references/`](references/README.md).

> Note: AI figures are generated by the private tooling in `AI-assistedSupport/` (outside this
> repo); only the **output images** are committed here. Photos are committed directly (no external
> hot-links).
