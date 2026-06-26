# bFaaaP — 自分で作れる、フットフリーのピアノ・ペダル 🎹

> 🌐 [English](../../README.md) · **日本語** · [Deutsch](../de/README.md)

![bFaaaP — 頭の傾きでペダルを操作](../../docs/media/illustrations/hero-opensource.png)

> **bFaaaP** —（*barrier‑Free assist as a Pedal*）は、**AI補助ピアノ・ペダルシステム**です。
> 少し頭を傾けるとサステイン・ペダルが下がります —— **足は使いません。** iPhone/iPad がオンデバイスAIで
> 頭の角度を読み取り、Bluetooth で小さな装置に送り、その装置がピアノのペダルを押す（または電子的に切り替える）
> 仕組みです。

このプロジェクトは、足でペダルを操作しづらい人 —— 手足に障害のある方、小さな子ども、高齢の方、気管切開のある方 ——
が、ペダルの豊かな表現とともにピアノを弾けるように、という願いから生まれました。そして **オープンソース** です。
このリポジトリには、装置を作りコントローラを動かすために必要なものが**すべて**そろっています。

### はじめに
🌱 **初めての方へ** → [**bFaaaP の物語**](docs/story.md) · [仕組み](docs/how-it-works.md) · [用語集](docs/GLOSSARY.md)
🔧 **作ってみる** → [**自分で作る**](docs/build/)（iOS・Pro・Switch）
🗂 **元ファイルを探す** → [ソースマップ](../../docs/SOURCE-MAP.md) —— どの図/コードがどの説明に対応するか
🤖 **質問する** → [AI支援サポート](docs/ai-support.md) · 💛 [プロジェクトを支援](SUPPORT.md)

> ステータス：このフォルダ（`github_opensource/`）は公開準備中のステージング領域です
> （[`PUBLISHING-CHECKLIST.md`](../../PUBLISHING-CHECKLIST.md) 参照）。ドキュメントは**英語が原本**で、
> 日本語・ドイツ語はこの `i18n/` 配下に整備します。

---

## bFaaaP とは？

![bFaaaP とは —— 頭の傾きセンサーとスマートペダルを使う演奏者](../../docs/media/illustrations/intl-what-bfaaap.png)

小さな頭の動きが、ペダルの踏み込みになります。**しきい値**（どれだけ傾けるか）と**速さ**を自分で設定でき、
単なるオン/オフではなく、あなた仕様のペダリングになります。やさしい解説は[仕組み](docs/how-it-works.md)へ。

## 2つのハードウェア系列、1つのアプリ

![Pro はアコースティック、Switch はデジタル](../../docs/media/illustrations/intl-pro-switch.png)

| 系列 | 対象 | 動作方式 |
|------|------|----------|
| 🎹 **bFaaaP Pro** | アコースティックピアノ（**グランド・アップライト**） | **モーターが物理的に**サステインペダルを押す。*エアバック*の空気クッションで固定 → [`device-pro-acoustic/`](../../device-pro-acoustic/) |
| 🎛️ **bFaaaP Switch** | **電子ピアノ・キーボード** | **サステインペダル端子**に挿し、**電子スイッチ**として動作（モーター/エアバック不要）→ [`device-switch-electronic/`](../../device-switch-electronic/) |

**同じ iOS アプリ**（[`ios-app/`](../../ios-app/)）が両系列を駆動します。Bluetooth プロトコルは共通です。

## 仕組み

![システム構成](../../docs/media/diagrams/architecture.png)

```
   頭の傾き
        │  ARKit / TrueDepth 顔トラッキング（iPhone/iPad の AI）
        ▼
┌──────────────┐   BLE  "i00".."i99"   ┌─────────────────┐  UART  ┌──────────────┐  駆動
│   iOSアプリ   │ ────────────────────▶ │ BLEボード nRF52  │ ─────▶ │  Pico RP2040 │ ─────▶ ピアノのペダル
└──────────────┘                       └─────────────────┘        └──────────────┘
```

設計上の要点：ARKit は BLE で送るべき速度よりずっと速く頭の角度を生成するため、アプリは無線通信を
**ペーシング**（100msタイマー＋スロットル）して接続を安定させています ——
[`ios-app/DESIGN-HIGHLIGHTS.md`](../../ios-app/DESIGN-HIGHLIGHTS.md) を参照。

## 自分で作る

[**ビルド・ハブ**](docs/build/) を開いて系列を選んでください。手短に言うと（Pro）：

1. 機構部品を**印刷・組立** —— [`device-pro-acoustic/hardware/`](../../device-pro-acoustic/hardware/)。
2. 両ボードを**配線・書き込み** —— [`docs/toolchain/`](../../docs/toolchain/)（VS Code / PlatformIO / Arduino）。
3. エアバックで**固定**し、可動上限を設定。
4. **iOS アプリをビルド・インストール** —— [`ios-app/`](../../ios-app/)（自分の署名チーム＆バンドルID）。
5. **ペアリング・校正して演奏** —— [`docs/operation/`](../../docs/operation/)。

どの手順でも詰まったら **[AI支援サポートで質問](docs/ai-support.md)** を（メンテナがレビューするQ&A。
即答ではなく、人が各回答を確認します）。

### 部品表（概要・Pro系列）
- **TrueDepth** 前面カメラ付き iPhone / iPad（頭部トラッキング用）
- **Raspberry Pi Pico**（メイン）＋ **nRF52840** BLEボード（ブリッジ）
- **IQ‑FORTIQ‑M42BLS‑100** モーター *（参照=v039B；EOL → 後継は DRV8825互換インターフェースの閉ループ・ステッパ）*。
  **GT-2ベルト → T10リードスクリュー → 押し棒** をアルミ押出フレーム上で駆動
- **HX711** 空気圧センサー、**2SK4017** MOSFET（ポンプ）、可動上限スライダ、**24V電源**
  *（自己校正はモーターの**電力**で行い電流ではないため、電源電圧は問いません）*
- 3Dプリント部品（PLA+）＋ **エアバック**固定キット
- 完全な部品表・型番：[`device-pro-acoustic/hardware/PARTS-REFERENCE.md`](../../device-pro-acoustic/hardware/PARTS-REFERENCE.md)

> ⚠️ 一部のオリジナル部品は **EOL**（特にIQ/Fortiqモーター）。代替品とファームウェアの調整は
> [`device-pro-acoustic/HARDWARE-AVAILABILITY.md`](../../device-pro-acoustic/HARDWARE-AVAILABILITY.md)。

## 物語・人・音楽 🎬

bFaaaP は **2018年**、ある車椅子ユーザーの「ピアノを弾きたい」という願いから始まり、エンジニアと音楽家の
チームへと育ちました。メンバー紹介と**すべての演奏動画**を含むその歩みは
**[bFaaaP の物語](docs/story.md)** で。

![Platanus with bFaaaP —— コンサート](../../docs/media/poster_concert_pro_2025.jpg)

- 📜 [歴史](../../docs/HISTORY.md) · 👥 [メンバー](../../docs/members/) · 🎥 [全動画](../../docs/videos/)
- ▶ **一番のデモ動画**（グランドピアノ、*25:01から設置の解説あり*）：<https://www.youtube.com/watch?v=V3cXeNW9jXY>

## 💛 支援

装置は販売していません。みなさまの支援が bFaaaP を無償で成長させ続けます（開発、AI支援サポートの運用、
部品・貸出機、インクルーシブな演奏会・レッスン）。[**SUPPORT.md**](SUPPORT.md) を参照（PayPal は現在利用可、
Stripe＝カード/Apple Pay/Google Pay は近日）。または本リポジトリの **Sponsor** ボタンから。

## リポジトリ構成

| フォルダ | 内容 |
|----------|------|
| [`ios-app/`](../../ios-app/) | iOSコントローラアプリ —— コード・設計ノート・ビルド手順・サニタイズ済み `src/`。両系列を駆動。 |
| [`device-pro-acoustic/`](../../device-pro-acoustic/) | **Pro**（アコースティック）：ファームウェア、ハードウェア（`cad/`・`3d-print/`・`airback/`・`schematic/`）、モーター情報、組立。 |
| [`device-switch-electronic/`](../../device-switch-electronic/) | **Switch**（電子/キーボード）：電子サステイン設計（作業中）。 |
| [`docs/`](../../docs/) | 物語・仕組み・用語集・ビルドハブ・AIサポート・アーキテクチャ・操作・ツールチェーン・動画・メンバー・歴史。 |
| [`bfaaap_arxiv_latex/`](../../bfaaap_arxiv_latex/) | 研究 **arXivプレプリント**（LaTeX）。 |
| [`bfaaap_patent_info/`](../../bfaaap_patent_info/) | 平易な特許ガイド＋審査経過ファイル。 |

## ライセンス

ライセンスは**層別マルチライセンスを採用済み**（[`LICENSE`](../../LICENSE)／全文は [`LICENSES/`](../../LICENSES/)）。3層構成 ——
**Apache‑2.0**（ソフトウェア：iOSアプリ・ファームウェア。明示的な特許許諾）、
**CERN‑OHL‑W‑2.0**（ハードウェア：CAD・3Dプリント・回路図）、**CC‑BY‑4.0**（ドキュメント）。
第三者コンポーネントは各自のライセンスに従います（例：IQモジュールライブラリ）。取り込んだ貢献者の素材
（回路図/CAD/写真）は**同意のうえ**収録（全メンバー同意済 —— [`PUBLISHING-CHECKLIST.md`](../../PUBLISHING-CHECKLIST.md)）。

## 📄 研究

LaTeX の **arXiv** プレプリント（`main.tex`）が [`bfaaap_arxiv_latex/`](../../bfaaap_arxiv_latex/) にあります。
bFaaaP をインクルーシブ・デザイン／ヒューマン・マシン・インタラクションとして位置づけ、その核は
**定量的でユーザー調整可能な頭部角度の制御則**であり、**被験者による臨床的評価（APEE）**で検証しています。
著者：宍戸（責任著者）・成澤。*（査読付きの ACM TACCESS 版は非公開で別途管理）*

## 特許・商標・意匠

制御方式 —— **頭部角度の*しきい値*（アクチュエータを駆動しないオフセット範囲）と*押下速度*／ユーザー設定の
2パラメータ**からペダル信号を生成 —— は特許です。**日本で2件の特許**が成立し、英語 **PCT** が優先権の基礎です：

| 種別 | 番号 | 名称 | リンク |
|------|------|------|--------|
| 特許（JP） | **特許第6726319号** — JP 6726319 B2 | 補助ペダルシステム | <https://patents.google.com/patent/JP6726319B2/en> |
| 特許（JP） | **特許第7004771号** — JP 7004771 B2 | デバイスコントローラ | <https://patents.google.com/patent/JP7004771B2/en> |
| PCT（英語・優先） | **WO 2019/176164** | 補助ペダルシステム | <https://patentscope.wipo.int/search/en/detail.jsf?docId=WO2019176164> |

発明者：成澤・大瀧・宍戸・山口・徳重。**bFaaaP®** は登録商標、眼鏡装着型モーションセンサーは登録意匠です。
審査経過の全ファイルと平易な解説：[`bfaaap_patent_info/`](../../bfaaap_patent_info/)。

### 特許のライセンス
ライセンスは一般に**相手方の実施形態による**ものの、**真に公共的・オープンな目的の用途には無償で許諾する意向**です ——
特に**障害のある方（や必要とする方）がよりインクルーシブに社会参加できる製品・サービス（有償・商用を含む）には、方針として
bFaaaP特許を無償許諾**します。該当する場合は **宍戸知行**（ORCID <https://orcid.org/0000-0002-8944-2088>）まで。

## クレジット

開発：**宍戸知行**と bFaaaP / **Platanus** のメンバー（大瀧・成澤ほか —— [メンバー](../../docs/members/)参照）。
iOSアプリは App Store にて **bFaaaPSwitch** として公開。イラスト：塩川紗季ほか／bFaaaP プロジェクト（AI支援）。
