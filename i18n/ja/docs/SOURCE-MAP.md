# ソースマップ —— どのファイルがどの説明の裏付けか

> 🌐 [English](../../../docs/SOURCE-MAP.md) · **日本語** · [Deutsch](../../de/docs/SOURCE-MAP.md)

**何がどこで説明され**、**どのソースファイル・CADモデル・回路図・コード・写真・図に対応するか**（リポジトリ内の
場所つき）の一覧です。任意のトピックから、その正本ファイルへ飛べます。パスはリポジトリルート
（`github_opensource/`）からの相対です。

> 凡例：📄 doc · 💻 code · 📐 CAD/3D · ⚡ 回路図/電子 · 📊 図（生成） · 📷 写真

## 1. システム全体／仕組み
| トピック | 📄 説明 | ソース＆図 |
|------|---------|-----------|
| 概念・データフロー | [`how-it-works`](how-it-works.md) | 📊 `../../../docs/media/diagrams/architecture.png` · 📊 `../../../docs/media/illustrations/intl-how-it-works.png` |
| 制御則（頭の角度→ペダル） | [`how-it-works`](how-it-works.md)、特許ガイド | 📊 `../../../docs/media/diagrams/control-law.png` · 📄 [`patent`](../../../bfaaap_patent_info/general_description/README.md) |
| AR↔BLE タイミング（ペーシング） | [`DESIGN-HIGHLIGHTS`](../../../ios-app/DESIGN-HIGHLIGHTS.md) | 📊 `../../../docs/media/diagrams/rate-decoupling.png` |
| 用語集 | [`GLOSSARY`](GLOSSARY.md) | — |

## 2. iOSアプリ
| トピック | 📄 説明 | 💻 code / 📷 図 |
|------|---------|-----------------|
| ビルド＆実行 | [`ios-app/BUILD.md`](../../../ios-app/BUILD.md)、[`build/ios`](build/ios.md) | 💻 [`ios-app/src/bFaaaPSwitch1/`](../../../ios-app/src/bFaaaPSwitch1/) |
| コード構成 | [`CODE-STRUCTURE`](../../../ios-app/CODE-STRUCTURE.md) | 💻 `ios-app/src/bFaaaPSwitch1/` |
| 頭部角度（ARKit） | [`DESIGN-HIGHLIGHTS`](../../../ios-app/DESIGN-HIGHLIGHTS.md) | 💻 `…/ARKit/` |
| BLE送信＋ペーシング（「100ms」の妙） | [`DESIGN-HIGHLIGHTS`](../../../ios-app/DESIGN-HIGHLIGHTS.md)、[`BLE-CONNECTION-FLOW`](../../../ios-app/BLE-CONNECTION-FLOW.md) | 💻 `…/BLEManager/` |
| App Store 用素材 | [`ios-app/app-store/`](../../../ios-app/app-store/) | 📷 `ios-app/app-store/screenshots/` |

## 3. ファームウェア（装置のボード）
| トピック | 📄 説明 | 💻 code |
|------|---------|---------|
| 概要／どのスケッチを使うか | [`firmware/README`](../../../device-pro-acoustic/firmware/README.md) | — |
| **メイン（Pico）＝参照** | [`firmware/DESIGN-HIGHLIGHTS`](../../../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md)、[`CODE-STRUCTURE`](../../../device-pro-acoustic/firmware/CODE-STRUCTURE.md) | 💻 `device-pro-acoustic/firmware/pico/bFaaaP_autopro_pico_v039B_20250725.ino` |
| BLEボード（nRF52） | [`firmware/README`](../../../device-pro-acoustic/firmware/README.md) | 💻 `device-pro-acoustic/firmware/pico/bFaaaPpro_BLE_2024010309_bord_A.ino` |
| ステッパ後継（⚠初期・ビルド不可） | [`HARDWARE-AVAILABILITY`](../../../device-pro-acoustic/HARDWARE-AVAILABILITY.md) | 💻 `…/pico/bFaaaP_autopro_pico_v052B_step_20251111.ino` |
| モーター通信ライブラリ | [`firmware/README`](../../../device-pro-acoustic/firmware/README.md) | 💻 `device-pro-acoustic/firmware/libraries/iq-module-communication-arduino/` |
| 書込み／ツールチェーン | [`toolchain`](toolchain/README.md) | — |
| 確定済みの配線・校正メモ | [`DISCORD-FINDINGS`](../../../device-pro-acoustic/DISCORD-FINDINGS.md) | — |

## 4. 電子・配線
| トピック | 📄 説明 | ⚡ 回路図 / 📷 写真 |
|------|---------|-------------------|
| 部品表（ボード・モーター・コネクタ） | [`hardware/PARTS-REFERENCE`](../../../device-pro-acoustic/hardware/PARTS-REFERENCE.md) | ⚡ [`fortiq42`](../../../device-pro-acoustic/hardware/reference/fortiq42_electrical-interface.png) |
| 回路図 | [`schematic/README`](../../../device-pro-acoustic/hardware/schematic/README.md) | ⚡ `hardware/schematic/schematic_2025-03-05_kicad.png` · `block-diagram.png` · `power-supply-options.png` |
| ピン配（GP4/5 モーター・GP2/3 HX711・GP12 ポンプ・ADC0 スライダ） | [`firmware/DESIGN-HIGHLIGHTS`](../../../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md) ＋ `.ino` | ⚡ 上記回路図 |
| I/Oパネル・電源 | [`hardware/photos/README`](../../../device-pro-acoustic/hardware/photos/README.md) | 📷 `hardware/photos/pro_io_panel.jpg` ほか |

## 5. 機構 —— CAD・3Dプリント・組立
| トピック | 📄 説明 | 📐 CAD/STL · 📊 図 · 📷 写真 |
|------|---------|------------------------------|
| 組立ガイド＆BOM | [`assembly/README`](../../../device-pro-acoustic/assembly/README.md)、[`build/pro`](build/pro.md) | 📊 `../../../docs/media/diagrams/pro-build-flow.png` |
| 駆動機構（モーター→ベルト→ねじ→棒） | [`build/pro`](build/pro.md) | 📐 `hardware/cad/from-discord-2025/bfaaap_belt_gotai14.FCStd` · 📊 `pro-mechanism.png` · 📷 `pro_components_airback_and_drive.jpg` |
| 編集用CAD（curated） | [`hardware/cad/README`](../../../device-pro-acoustic/hardware/cad/README.md) | 📐 `hardware/cad/*.FCStd` |
| 編集用CAD（Discord全集） | [`from-discord-2025/README`](../../../device-pro-acoustic/hardware/cad/from-discord-2025/README.md) | 📐 `hardware/cad/from-discord-2025/*.FCStd` |
| 3Dプリント・設定 | [`hardware/3d-print/README`](../../../device-pro-acoustic/hardware/3d-print/README.md) | 📐 `hardware/3d-print/*.stl`, `*.3mf`；新筐体 `…/from-discord-2025/bFaaaP_{AA,CC,DD,E_a,FF}*.stl` |
| エアバック固定 | [`hardware/airback/README`](../../../device-pro-acoustic/hardware/airback/README.md) | 📷 `hardware/photos/airback_air_valve.jpg` |
| 機械BOM（CAD導出） | [`build/pro`](build/pro.md) §BOM | 📐 `hardware/cad/from-discord-2025/`（BREP実寸） |

## 6. 校正＆操作
| トピック | 📄 説明 | ソース |
|------|---------|--------|
| 設置・日常操作 | [`operation`](operation/README.md) | 🎥 [動画](https://www.youtube.com/watch?v=_9YopbCYTmI) |
| 取扱説明 | [`user-manual`](user-manual/README.md) | 🎥 [Switchマニュアル](https://youtu.be/XOVENtBsOp4) |
| 押下力校正（DIP, 20–35W） | [`DISCORD-FINDINGS`](../../../device-pro-acoustic/DISCORD-FINDINGS.md) | 💻 ファーム `…v039B….ino` |

## 7. 物語・人・研究・法務
| トピック | 📄 説明 | ソース |
|------|---------|--------|
| 物語 | [`story`](story.md) | 📷 メンバー・ポスター；🎥 動画 |
| 歴史 / メンバー / 動画 | [`HISTORY`](HISTORY.md) · [`members`](members/README.md) · [`videos`](videos/README.md) | 📷 `../../../docs/members/*` |
| 研究プレプリント | [`arxiv/README`](../../../bfaaap_arxiv_latex/README.md) | `bfaaap_arxiv_latex/main.tex`, `figures/` |
| 特許・商標 | [`patent_info`](../../../bfaaap_patent_info/README.md) | 審査経過PDF |
| ライセンス | [`LICENSE`](../../../LICENSE), `LICENSES/` | — |
| AI支援サポート | [`ai-support`](ai-support.md) | 📊 `../../../docs/media/diagrams/ai-support-timeline.png` |
| 支援 | [`SUPPORT`](../SUPPORT.md) | 📊 `../../../docs/media/illustrations/intl-support.png` |

## 8. 生成図の一覧（`docs/media/diagrams/`）
| ファイル | 内容 | 生成 |
|------|------|------|
| `architecture.png` | iOS→BLE→Pico→モーターのデータフロー | （流用） |
| `control-law.png` | 頭の角度→ペダル（デッドゾーン・倍率・ヒステリシス） | matplotlib |
| `rate-decoupling.png` | AR取得 vs BLE送信のタイミング | （流用） |
| `pro-mechanism.png` | 駆動系＋エアバック機構 | （流用） |
| `pro-build-flow.png` | Pro 8工程→各工程が使うファイル | matplotlib |
| `ai-support-timeline.png` | AI支援サポートの流れ | matplotlib |

イラスト（`docs/media/illustrations/`）と全クレジット：[`docs/media/CREDITS.md`](../../../docs/media/CREDITS.md)。

> 注：AI図は `AI-assistedSupport/` の private ツールで生成（リポジトリ外）。**出力画像のみ**を同梱。写真は直接同梱
> （bfaaap.com への外部リンクなし）。
