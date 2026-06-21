# 🎹 Pro を作る（アコースティックピアノ）

> 🌐 [English](../../../../docs/build/pro.md) · **日本語** · [Deutsch](../../../de/docs/build/pro.md)

Pro 装置を作る手順です —— アコースティックピアノのサステインペダルを小さなモーターで押し、*エアバック*の
空気クッションで固定します（ピアノにネジ留め不要）。用語が不安なら[用語集](../GLOSSARY.md)を。
詰まったら[AI支援サポート](../ai-support.md)で質問を。

> 🚧 **ドラフト**：枠組みはできていますが、一部の正確なピン配や機構寸法は作り手（成澤・田口）からの反映待ちです。
> **[Pro 設置ウォークスルー動画](https://www.youtube.com/watch?v=_9YopbCYTmI)** で実際の様子が見られます。

```
 1. 部品を印刷 ─▶ 2. 電子部品を入手 ─▶ 3. ドライブを組立 ─▶ 4. ボードを配線
       ─▶ 5. ファーム書込 ─▶ 6. 取付＋エアバック ─▶ 7. 力の設定＆校正 ─▶ 8. ペアリングして演奏
```

![Pro のビルド工程と各工程が使うリポジトリ内ファイル](../../../../docs/media/diagrams/pro-build-flow.png)
<sub>各工程は特定のファイルに対応します —— 完全な索引は[ソースマップ](../../../../docs/SOURCE-MAP.md)。</sub>

![Pro の駆動機構](../../../../docs/media/diagrams/pro-mechanism.png)

## はじめる前に —— 必要なもの
- **3Dプリンタ**（ベッド≥240mm があると安心）＋ **PLA+** フィラメント
- はんだごて、配線材、基本工具
- **電子部品**（[`PARTS-REFERENCE.md`](../../../../device-pro-acoustic/hardware/PARTS-REFERENCE.md) 参照）：
  Raspberry Pi **Pico**、**nRF52840** BLEボード、**IQ‑Fortiq** モーター *（または後継ステッパ）*、
  **HX711**、**2SK4017** MOSFET、可動上限スライダ、**24V電源**
- フレーム材：**アルミ押出**、**2GTベルト**、**T10リードスクリュー**、押し棒
- **エアバック**キット（エアジャック＋ポンプ＋ハンドコントローラ）
- Face ID 付き iPhone/iPad ＋ [iOSアプリ](ios.md)

## ステップ1 —— 機構部品を印刷
1. [`hardware/3d-print/`](../../../../device-pro-acoustic/hardware/3d-print/) の `.stl` / `.3mf` をスライサー（Bambu Studio、PrusaSlicer、OrcaSlicer 等）で開く。
2. **PLA+**、公差 **0.1〜0.2mm**、向きに注意（穴はサポートなし）。[3Dプリントの注意](../../../../device-pro-acoustic/hardware/3d-print/README.md)参照。
3. フレーム部品、PCBマウント、電源ボックス、押し棒、カバーを印刷。

## ステップ2 —— 電子部品を入手
[`PARTS-REFERENCE.md`](../../../../device-pro-acoustic/hardware/PARTS-REFERENCE.md) から発注。
**注意**：オリジナルの IQ/Fortiq モーターは **EOL** —— 後継（DRV8825互換の閉ループステッパ）は
[`HARDWARE-AVAILABILITY.md`](../../../../device-pro-acoustic/HARDWARE-AVAILABILITY.md)参照。

## ステップ3 —— ドライブユニットを組立
1. 押出材でフレームを組む。
2. **モーター → 2GTベルト → T10リードスクリュー → 押し棒** を、ロッドがペダルへ向かうように取り付ける。
3. 印刷した PCB ホルダにボードを載せる。

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
2. **エアバック**で固定：隣のペダルにエアジャックを膨らませて反力を吸収 —— ピアノの塗装に触れません。
   [`hardware/airback/`](../../../../device-pro-acoustic/hardware/airback/)参照。

![エアバックのエア弁](../../../../device-pro-acoustic/hardware/photos/airback_air_valve.jpg)

## ステップ7 —— 押下力の設定＆校正
- **DIPスイッチ**で押下力 **20〜35W**（1W刻み）と昇降距離 **5〜20mm** を設定。20W台前半から始め、確実に鳴るまで
  上げる（力は**電力ベース**でピアノ依存）。
- 自己校正を実行し、**シリアルモニタ@115200** を確認。約50mm超で安全停止します。

## ステップ8 —— アプリでペアリングして演奏
[iOSアプリ](ios.md)をビルド/インストールし、Bluetooth でペアリング、**しきい値**と**速さ**を設定、頭の角度の
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

市販の機械部品（IQモーター、**T10リードスクリュー ~150mm**、**2GT‑262 ベルト**、**T60プーリ** 5/10mmボア、
ベアリング、**4040 / 2040 / 20100** アルミ押出、**エアジャック 119×11cm**、φ3ポンプ）は
[assembly BOM](../../../../device-pro-acoustic/assembly/README.md)参照。ファイル↔トピックの完全索引は
[**ソースマップ**](../../../../docs/SOURCE-MAP.md)へ。

---
→ [ビルドハブ](README.md) · [iOS を作る](ios.md) · [Switch を作る](switch.md) · [仕組み](../how-it-works.md) · [ソースマップ](../../../../docs/SOURCE-MAP.md)
