# Quellenübersicht — welche Dateien jede Erklärung stützen

> 🌐 [English](../../../docs/SOURCE-MAP.md) · [日本語](../../ja/docs/SOURCE-MAP.md) · **Deutsch**

Ein Index, **was wo erklärt wird** und **welche Quelldatei, welches CAD‑Modell, welcher Schaltplan,
Code, welches Foto oder welche Abbildung dazugehört** (mit Ort im Repository). Springe von jedem Thema
zu seinen maßgeblichen Dateien. Pfade sind relativ zur Repo‑Wurzel (`github_opensource/`).

> Legende: 📄 doc · 💻 code · 📐 CAD/3D · ⚡ Schaltplan/Elektronik · 📊 Abbildung (generiert) · 📷 Foto

## 1. Das Gesamtsystem / Funktionsweise
| Thema | 📄 Erklärung | Quellen & Abbildungen |
|-------|--------------|-----------------------|
| Konzept & Datenfluss | [`how-it-works`](how-it-works.md) | 📊 `../../../docs/media/diagrams/architecture.png` · 📊 `../../../docs/media/illustrations/intl-how-it-works.png` |
| Regelgesetz (Kopfwinkel→Pedal) | [`how-it-works`](how-it-works.md), Patent‑Leitfaden | 📊 `../../../docs/media/diagrams/control-law.png` · 📄 [`patent`](../../../bfaaap_patent_info/general_description/README.md) |
| AR↔BLE‑Timing (Taktung) | [`DESIGN-HIGHLIGHTS`](../../../ios-app/DESIGN-HIGHLIGHTS.md) | 📊 `../../../docs/media/diagrams/rate-decoupling.png` |
| Glossar | [`GLOSSARY`](GLOSSARY.md) | — |

## 2. iOS‑App
| Thema | 📄 Erklärung | 💻 code / 📷 Abb. |
|-------|--------------|-------------------|
| Bauen & Ausführen | [`ios-app/BUILD.md`](../../../ios-app/BUILD.md), [`build/ios`](build/ios.md) | 💻 [`ios-app/src/bFaaaPSwitch1/`](../../../ios-app/src/bFaaaPSwitch1/) |
| Code‑Struktur | [`CODE-STRUCTURE`](../../../ios-app/CODE-STRUCTURE.md) | 💻 `ios-app/src/bFaaaPSwitch1/` |
| Kopfwinkel (ARKit) | [`DESIGN-HIGHLIGHTS`](../../../ios-app/DESIGN-HIGHLIGHTS.md) | 💻 `…/ARKit/` |
| BLE‑Senden + Taktung (der „100‑ms“‑Trick) | [`DESIGN-HIGHLIGHTS`](../../../ios-app/DESIGN-HIGHLIGHTS.md), [`BLE-CONNECTION-FLOW`](../../../ios-app/BLE-CONNECTION-FLOW.md) | 💻 `…/BLEManager/` |
| App‑Store‑Material | [`ios-app/app-store/`](../../../ios-app/app-store/) | 📷 `ios-app/app-store/screenshots/` |

## 3. Firmware (die Geräte‑Boards)
| Thema | 📄 Erklärung | 💻 code |
|-------|--------------|---------|
| Überblick / welcher Sketch | [`firmware/README`](../../../device-pro-acoustic/firmware/README.md) | — |
| **Hauptplatine (Pico) — Referenz** | [`firmware/DESIGN-HIGHLIGHTS`](../../../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md), [`CODE-STRUCTURE`](../../../device-pro-acoustic/firmware/CODE-STRUCTURE.md) | 💻 `device-pro-acoustic/firmware/pico/bFaaaP_autopro_pico_v039B_20250725.ino` |
| BLE‑Board (nRF52) | [`firmware/README`](../../../device-pro-acoustic/firmware/README.md) | 💻 `device-pro-acoustic/firmware/pico/bFaaaPpro_BLE_2024010309_bord_A.ino` |
| **Switch‑Gerät (nRF52, eigenständig on/off)** | [`switch firmware/README`](../../../device-switch-electronic/firmware/README.md) | 💻 `device-switch-electronic/firmware/bFaaaPSW_20211007_for_ex_fs_J_13_ymc/` |
| Schrittmotor‑Nachfolger (⚠ früh, nicht bauen) | [`HARDWARE-AVAILABILITY`](../../../device-pro-acoustic/HARDWARE-AVAILABILITY.md) | 💻 `…/pico/bFaaaP_autopro_pico_v052B_step_20251111.ino` |
| Motor‑Kommunikationsbibliothek | [`firmware/README`](../../../device-pro-acoustic/firmware/README.md) | 💻 `device-pro-acoustic/firmware/libraries/iq-module-communication-arduino/` |
| Flashen / Toolchain | [`toolchain`](toolchain/README.md) | — |
| Gesicherte Verdrahtungs-/Kalibriernotizen | [`DISCORD-FINDINGS`](../../../device-pro-acoustic/DISCORD-FINDINGS.md) | — |

## 4. Elektronik / Verdrahtung
| Thema | 📄 Erklärung | ⚡ Schaltplan / 📷 Foto |
|-------|--------------|------------------------|
| Teileliste (Boards, Motor, Stecker) | [`hardware/PARTS-REFERENCE`](../../../device-pro-acoustic/hardware/PARTS-REFERENCE.md) | ⚡ [`fortiq42`](../../../device-pro-acoustic/hardware/reference/fortiq42_interface_bfaaap.png) |
| Schaltplan | [`schematic/README`](../../../device-pro-acoustic/hardware/schematic/README.md) | ⚡ `hardware/schematic/schematic_2025-03-05_kicad.png` · `block-diagram.png` · `power-supply-options.png` |
| Pin‑Belegung (GP4/5 Motor, GP2/3 HX711, GP12 Pumpe, ADC0 Schieber) | [`firmware/DESIGN-HIGHLIGHTS`](../../../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md) + `.ino` | ⚡ Schaltplan oben |
| I/O‑Panel & Strom | [`hardware/photos/README`](../../../device-pro-acoustic/hardware/photos/README.md) | 📷 `hardware/photos/pro_io_panel.jpg` usw. |

## 5. Mechanik — CAD, 3D‑Druck, Montage
| Thema | 📄 Erklärung | 📐 CAD/STL · 📊 Abb. · 📷 Foto |
|-------|--------------|-------------------------------|
| Montageanleitung & Stückliste | [`assembly/README`](../../../device-pro-acoustic/assembly/README.md), [`build/pro`](build/pro.md) | 📊 `../../../docs/media/diagrams/pro-build-flow.png` |
| Antriebsmechanik (Motor→Riemen→Spindel→Stange) | [`build/pro`](build/pro.md) | 📐 `hardware/cad/from-discord-2025/bfaaap_belt_gotai14.FCStd` · 📊 `pro-mechanism.png` · 📷 `pro_components_airback_and_drive.jpg` |
| Bearbeitbares CAD (kuratiert) | [`hardware/cad/README`](../../../device-pro-acoustic/hardware/cad/README.md) | 📐 `hardware/cad/*.FCStd` |
| Bearbeitbares CAD (Discord‑Archiv) | [`from-discord-2025/README`](../../../device-pro-acoustic/hardware/cad/from-discord-2025/README.md) | 📐 `hardware/cad/from-discord-2025/*.FCStd` |
| 3D‑Druck & Einstellungen | [`hardware/3d-print/README`](../../../device-pro-acoustic/hardware/3d-print/README.md) | 📐 `hardware/3d-print/*.stl`, `*.3mf`; neues Gehäuse `…/from-discord-2025/bFaaaP_{AA,CC,DD,E_a,FF}*.stl` |
| Airback‑Fixierung | [`hardware/airback/README`](../../../device-pro-acoustic/hardware/airback/README.md) | 📷 `hardware/photos/airback_air_valve.jpg` |
| Mechanische Stückliste (CAD‑abgeleitet) | [`build/pro`](build/pro.md) §Stückliste | 📐 `hardware/cad/from-discord-2025/` (BREP‑Maße) |

## 6. Kalibrierung & Betrieb
| Thema | 📄 Erklärung | Quelle |
|-------|--------------|--------|
| Einrichtung & täglicher Betrieb | [`operation`](operation/README.md) | 🎥 [Video](https://www.youtube.com/watch?v=_9YopbCYTmI) |
| Benutzerhandbuch | [`user-manual`](user-manual/README.md) | 🎥 [Switch‑Handbuch](https://youtu.be/XOVENtBsOp4) |
| Druckkraft‑Kalibrierung (DIP, 20–35 W) | [`DISCORD-FINDINGS`](../../../device-pro-acoustic/DISCORD-FINDINGS.md) | 💻 Firmware `…v039B….ino` |

## 7. Geschichte, Menschen, Forschung, Recht
| Thema | 📄 Erklärung | Quellen |
|-------|--------------|---------|
| Die Geschichte | [`story`](story.md) | 📷 Mitglieder, Plakate; 🎥 Videos |
| Geschichte / Mitglieder / Videos | [`HISTORY`](HISTORY.md) · [`members`](members/README.md) · [`videos`](videos/README.md) | 📷 `../../../docs/members/*` |
| Forschungs‑Preprint | [`arxiv/README`](../../../bfaaap_arxiv_latex/README.md) | `bfaaap_arxiv_latex/main.tex`, `figures/` |
| Patente / Marke | [`patent_info`](../../../bfaaap_patent_info/README.md) | Erteilungsakten (PDF) |
| Lizenzierung | [`LICENSE`](../../../LICENSE), `LICENSES/` | — |
| Community‑Support | [`ai-support`](ai-support.md) | 📊 `../../../docs/media/diagrams/ai-support-timeline.png` |
| Unterstützung | [`SUPPORT`](../SUPPORT.md) | 📊 `../../../docs/media/illustrations/intl-support.png` |

## 8. Generierte Abbildungen (`docs/media/diagrams/`)
| Datei | Zeigt | Erstellt mit |
|-------|-------|--------------|
| `architecture.png` | Datenfluss iOS→BLE→Pico→Motor | (wiederverwendet) |
| `control-law.png` | Kopfwinkel→Pedal (Totzone, Faktor, Hysterese) | matplotlib |
| `rate-decoupling.png` | AR‑Abtastung vs. BLE‑Senden | (wiederverwendet) |
| `pro-mechanism.png` | Antrieb + Airback‑Mechanik | (wiederverwendet) |
| `pro-build-flow.png` | Pro: 8 Schritte → genutzte Dateien | matplotlib |
| `ai-support-timeline.png` | Ablauf des Community‑Supports | matplotlib |

Illustrationen (`docs/media/illustrations/`) und vollständige Credits: [`docs/media/CREDITS.md`](../../../docs/media/CREDITS.md).

Zitierte Quellen — gespeicherte Kopien der Open-Access-Artikel und der Patente, dazu stabile Links
und Zugriffsdaten für alles Übrige: [`docs/references/`](../../../docs/references/README.md).

> Hinweis: KI‑Abbildungen werden vom privaten Werkzeug in `AI-assistedSupport/` erzeugt (außerhalb des
> Repos); nur die **Ausgabebilder** sind eingecheckt. Fotos sind direkt eingecheckt (keine externen
> Links auf bfaaap.com).
