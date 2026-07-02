# 🎹 Pro を作る（アコースティックピアノ）

> 🌐 [English](../../../../docs/build/pro.md) · **日本語** · [Deutsch](../../../de/docs/build/pro.md)

Pro 装置を作る手順です —— アコースティックピアノのサステインペダルを小さなモーターで押し、*エアバック*の
空気クッションで固定します（ピアノにネジ留め不要）。用語が不安なら[用語集](../GLOSSARY.md)を。
詰まったら[AI支援サポート](../ai-support.md)で質問を。

![グランドピアノを足を使わず演奏：譜面台のスマホが頭の傾きを読み、小さな装置と空気クッションがサステインを押す](../../../../docs/media/illustrations/pro-play-hero.png)
<sub>めざす姿：未改造のグランドでフットフリーのペダリング。イラスト：AIイラスト：Harmonia による塩川紗季風 © 宍戸＆アソシエーツ。</sub>

> 🚧 **ドラフト**：**電気回路**（田口）と**機械レイアウト**（成澤の手書き）は確定済みで下記に反映しています。
> 確定待ちは **ステッパ後継のビルド可能なファーム**（後継機は同寸の **NEMA17**・STEP/DIR の予定。オリジナルは EOL）と **最終的な印刷部品の変種** です。
> **[Pro 設置ウォークスルー動画](https://www.youtube.com/watch?v=_9YopbCYTmI)** で実際の様子が見られます。

```
 1. 部品を印刷 ─▶ 2. 電子部品を入手 ─▶ 3. ドライブを組立 ─▶ 4. ボードを配線
       ─▶ 5. ファーム書込 ─▶ 6. 取付＋エアバック ─▶ 7. 力の設定＆校正 ─▶ 8. ペアリングして演奏
```

![Pro のビルド工程と各工程が使うリポジトリ内ファイル](../../../../docs/media/diagrams/pro-build-flow.png)
<sub>各工程は特定のファイルに対応します —— 完全な索引は[ソースマップ](../../../../docs/SOURCE-MAP.md)。</sub>

![Pro の駆動機構](../../../../docs/media/diagrams/pro-mechanism.png)

駆動は**縦型コラム**です：モーターはスクリューの**横**に置かれ、**押し棒が真下に**サステインペダルを押します。
全体像は **[リファレンス設計](../../../../device-pro-acoustic/hardware/reference-design/)** を参照
—— 実機に基づく[システムアーキテクチャ図](../../../../device-pro-acoustic/hardware/reference-design/pro-architecture.png)
と[機械レイアウト図](../../../../device-pro-acoustic/hardware/reference-design/pro-mechanical-layout.png)があります。

## はじめる前に —— 必要なもの
- **3Dプリンタ**（ベッド≥240mm があると安心）＋ **PLA+** フィラメント
- はんだごて、配線材、基本工具
- **電子部品**（[`PARTS-REFERENCE.md`](../../../../device-pro-acoustic/hardware/PARTS-REFERENCE.md) 参照）：
  Raspberry Pi **Pico**、**nRF52840** BLEボード、**IQ‑Fortiq** モーター *（または NEMA17 後継ステッパ）*、
  **+5V 冷却ファン**、**HX711**、**2SK4017** MOSFET、可動上限スライダ、**24V電源**
- フレーム材：**2040＋2080＋4040 アルミ押出**、**GT-2‑262 ベルト**＋**T60/T60 プーリ**、**T10リードスクリュー**（**リード16mm/回・150mm**）、押し棒
- **エアバック**キット：**WINBAG** エアジャック＋小型の**電動エアポンプ**（BOX内に収納、**GP12**→**2SK4017** MOSFET
  で駆動、パネルの **PUMP SW** で操作）—— 実機は WINBAG の手動球は**使いません**
- Face ID 付き iPhone/iPad ＋ [iOSアプリ](ios.md)

## ステップ1 —— 機構部品を印刷
1. [`hardware/3d-print/`](../../../../device-pro-acoustic/hardware/3d-print/) の `.stl` / `.3mf` をスライサー（Bambu Studio、PrusaSlicer、OrcaSlicer 等）で開く。
2. **PLA+**、公差 **0.1〜0.2mm**、向きに注意（穴はサポートなし）。[3Dプリントの注意](../../../../device-pro-acoustic/hardware/3d-print/README.md)参照。
3. フレーム部品、PCBマウント、電源ボックス、押し棒、カバーを印刷。

## ステップ2 —— 電子部品を入手
[`PARTS-REFERENCE.md`](../../../../device-pro-acoustic/hardware/PARTS-REFERENCE.md) から発注。
**注意**：オリジナルの IQ/Fortiq モーターは **EOL** —— 後継は**同寸の NEMA17（17型）ステッパ**（既存フレームを流用）で
**STEP/DIR 方式**の予定。[`HARDWARE-AVAILABILITY.md`](../../../../device-pro-acoustic/HARDWARE-AVAILABILITY.md)参照。

## ステップ3 —— ドライブユニットを組立
駆動は**縦型コラム**です（[リファレンス設計](../../../../device-pro-acoustic/hardware/reference-design/)参照）：
1. フレームを組む —— **縦の 2040 支柱**（L≈200mm）を **2080 の土台**（L≈200mm）に立てる。
2. **モーターをスクリューの横**（上部）に取り付け、**GT-2‑262 ベルト**で **T60 プーリ2個（1:1）**を介して連結
   —— ベルトはモーターを横に*オフセット*するためで、**減速ではありません**。
3. **縦の T10 リードスクリュー**（リード**16mm/回**）を **2040 支柱の左側**に取り付ける。**ナット/キャリッジ**が
   フレームを下降し、**押し棒**——**2040 L=75mm** に上部 **15mm の PLA**（ナット保持）と下部の **PLA＋硬質ゴム先端**
   （計 **115mm**）——が サステインペダルを**真下に**押す。モーターに **+5V 冷却ファン**を付ける。
4. ボードは印刷した**電子部品BOX**（BLE＋Pico＋エアジャックポンプ）に、電源は**電源BOX（PW）**に収める。

![ドライブユニット＋エアバック部品](../../../../device-pro-acoustic/hardware/photos/pro_components_airback_and_drive.jpg)

## ステップ4 —— ボードを配線
[`hardware/schematic/`](../../../../device-pro-acoustic/hardware/schematic/) の回路図に従う。主な接続（参照 v039B）：
- モーターシリアル → Pico **GP4 / GP5**
- **HX711** 空気圧 → **GP2 / GP3**；エアポンプは **MOSFET → GP12** 経由で +5V
- 可動上限スライダ → **ADC0 / GP26**；力/昇降は **DIPスイッチ**
- BLEボード ↔ Pico は **UART（`Serial1`）**、GND共通；モーターに **24V**

![I/Oパネル](../../../../device-pro-acoustic/hardware/photos/pro_io_panel.jpg)
![電源コネクタ](../../../../device-pro-acoustic/hardware/photos/pro_power_connector.jpg)

> 🚧 *正確なピン/コネクタ表は作り手と確認中 —— 確定済みの詳細は
> [`DISCORD-FINDINGS.md`](../../../../device-pro-acoustic/DISCORD-FINDINGS.md) を参照。*

## ステップ5 —— ファームウェアを書き込み
**2枚のボード**に書き込み（手順は [`docs/toolchain/`](../../../../docs/toolchain/)）：
- **BLEボード（nRF52）**：Adafruit nRF52 サポートを入れ、RESET 2回押し、BLEスケッチをアップロード。
- **メイン（Pico）**：**arduino‑pico（Philhower）コア**＋HX711＋IQライブラリを入れ、**BOOTSEL** を押しながら
  **`bFaaaP_autopro_pico_v039B_…ino`** をアップロード *（ステッパ版 `v052B` は使わない）*。

## ステップ6 —— ピアノに取付＋エアバック
1. 押し棒がサステインペダルの上に来るようにドライブを配置。
2. **エアバック**で固定：BOX内の**電動ポンプ**から **エアチューブ** を WINBAG に通し、パネルの **PUMP SW** で
   隣のペダルに膨らませて反力を吸収 —— ピアノの塗装に触れません。
   [`hardware/airback/`](../../../../device-pro-acoustic/hardware/airback/)参照。

![エアバックのエア弁](../../../../device-pro-acoustic/hardware/photos/airback_air_valve.jpg)

## ステップ7 —— 押下力の設定＆校正
- **DIPスイッチ**で押下力 **20〜35W**（1W刻み）と昇降距離 **5〜20mm** を設定。20W台前半から始め、確実に鳴るまで
  上げる（力は**電力ベース**でピアノ依存）。
- 自己校正を実行し、**シリアルモニタ@115200** を確認。約50mm超で安全停止します。

## ステップ8 —— アプリでペアリングして演奏
[iOSアプリ](ios.md)をビルド/インストールし、Bluetooth でペアリング、**オフセット（しきい値）**と**倍率**を
プリセット（この2つでペダルが頭に追従する速さが決まります —— [仕組み](../how-it-works.md)参照）、頭の角度の
ゼロを校正して演奏。[`docs/operation/`](../../../../docs/operation/)参照。

## 機械BOM＆CADリファレンス

価格・市販部品込みの完全な BOM は
[`assembly/README.md`](../../../../device-pro-acoustic/assembly/README.md) にあります。以下は **3Dプリント部品**で、
**CAD（BREP）から実測した寸法**と各部品の**編集用ソースファイル**を示します（印刷・改変に利用可）。

> 🚧 各部品の**最終変種**と**ファスナー一覧**は作り手（成澤）と確認中。下記は Discord CAD セットの最新版です。

| 印刷部品 | 寸法 (mm, L×W×H) | 編集用CAD —— `device-pro-acoustic/hardware/cad/from-discord-2025/` |
|---|---|---|
| 新筐体 **AA** | 135×120×62 | `bFaaaP_AA.FCStd`（STL: `3d-print/from-discord-2025/bFaaaP_AA-A.stl`） |
| 新筐体 **CC / DD** | 250×100×60 / 250×100×10 | STL `bFaaaP_CC-CC.stl` / `bFaaaP_DD-DD.stl` *（大型プリンタ要）* |
| ベース＋エアジャック | 292×124×50 | `bfaaap_base_plus_airjack2.FCStd` |
| ベース＋押さえ(osae) | 260×121×55 | `bfaaap_base_plus_osae_d.FCStd` |
| エアボックス | 200×125×35 | `bfaaap_airbox_a_2.FCStd` *（変種 a/a‑1/a‑2/c あり）* |
| スライダ（可動上限） | 243×132×25 | `bfaaap_slide2_20241028.FCStd` |
| DIPスイッチ箱 | 60×30×6 | `bfaaap_dipsw_box_top_bot.FCStd` |
| ハンドコントローラのノブ | 50×50×10 / 50×50×20 | `bfaaap_nob_a.FCStd` / `bfaaap_nob_b.FCStd` |
| 押し棒 | （CAD参照） | `bfaaap_push_poll.FCStd` |
| **ドライブ全体（参照レイアウト）** | 530×290×216 | `bfaaap_belt_gotai14.FCStd` |

市販の機械部品（IQモーター→**NEMA17** 後継、**T10リードスクリュー** リード**16mm/回**／150mm、**GT-2‑262 ベルト**、**T60プーリ** 5/10mmボア、
ベアリング、**2040＋2080＋4040** アルミ押出、**WINBAG エアジャック** 160×150mm／≤50mm／135kg ＋BOX内の**電動ポンプ**）は
[assembly BOM](../../../../device-pro-acoustic/assembly/README.md)参照。ファイル↔トピックの完全索引は
[**ソースマップ**](../../../../docs/SOURCE-MAP.md)へ。

---
→ [ビルドハブ](README.md) · [iOS を作る](ios.md) · [Switch を作る](switch.md) · [仕組み](../how-it-works.md) · [ソースマップ](../../../../docs/SOURCE-MAP.md)
