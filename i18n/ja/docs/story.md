# bFaaaP の物語 🎹

> 🌐 [English](../../../docs/story.md) · **日本語** · [Deutsch](../../de/docs/story.md)

*ひとりの願いから —— 誰でも作れる、フットフリーのピアノ・ペダルへ。*

![小さな装置にペダルを押してもらいながら演奏するピアニスト](../../../docs/media/illustrations/intl-what-bfaaap.png)

> **bFaaaP** = **b**arrier‑**F**ree **a**ssist **a**s **a** **P**edal —— AI補助ピアノ・ペダルシステム。
> 頭を少し傾けると、サステインペダルが下がります。足は不要。このページは、それがどう生まれ、誰が作り、
> どこで*見て・聴いて*もらえるかの物語です。初めての方は[仕組み](how-it-works.md)と[用語集](GLOSSARY.md)から、
> 作りたい方は[自分で作る](build/)へ。

---

## 1. ひとつの願いから始まった（2018年）

**2018年1月**、建築家**大瀧雅寛**さんの依頼主である**車椅子ユーザー**が、シンプルで深い一言を口にしました：

> *「ピアノのペダルを電動化して、自分で踏めるようにしたい。」*

ピアノの前に座り、鍵盤は美しく弾けるのに、ペダルには届かない —— ペダルなしでは音楽が花開かない。
その願いが bFaaaP になりました。

最初の試作機 **「bFaaap‑1」**（*ピアノ・ペダル試作#1*、**2018年2月10日**）は、コンクリートで重しをした白い箱に
配線を詰め込んだもの。初日からのモットーはエンジニアの定番 —— *まず「動く何か」を作る*。

## 2. 眼鏡、センサー、そして特許（bFaaaP1〜4）

初期システムは2つの半分から成り、マイコンで制御していました（Arduino / M5Stack・ESP32 の時代。bFaaaP4 は
手作りの木製筐体も）：

- **頭部モーションセンサー** —— **眼鏡フレーム**に載せた9軸IMUで、頭の前後の傾きを読む、そして
- ペダルの前に置く**アクチュエータ**。

核となる考え —— 頭部角度の**しきい値**＋押下**速度** —— は2018年に **PCT国際特許**として出願され、のちに日本で
成立しました（**特許第6726319号 / 第7004771号**）。公開デビューは2019年ごろ、山口恭子さんのピアノ教室
「フルール」の発表会（ムジカーザ、代々木上原）。

## 3. 今への飛躍：スマホ、傾き、ペダル

眼鏡型センサーは、ほぼ誰もが持つもの —— **スマートフォン** に置き換わりました。Apple の **AR顔トラッキング**が
頭の角度を読み、**Bluetooth Low Energy** で小さなペダル装置（**Raspberry Pi Pico** ＋ **Adafruit ItsyBitsy
nRF52840**）に送ります。ここから2つの系列が育ちました：

![仕組み：あなたの意図 → 顔認識 → Bluetooth → コントローラ](../../../docs/media/illustrations/intl-how-it-works.png)

| 系列 | 対象 | 押し方 |
|------|------|--------|
| 🎹 **Pro** | **アコースティック**グランド・アップライト | 小さな**モーター**が物理的にサステインペダルを押す（*エアバック*で固定） |
| 🎛️ **Switch** | **デジタル**ピアノ・キーボード | ペダル端子で**電子的に**サステインを切替 —— 小型・モーター不要 |

![Pro はアコースティック、Switch はデジタル](../../../docs/media/illustrations/intl-pro-switch.png)

## 4. bFaaaP を支える人々 👋

bFaaaP は **Platanus** グループ —— エンジニア、音楽家、調律師、作曲家、知財の専門家 —— が、ひとつの
インクルーシブな思いのもとに作っています。*似顔絵はプロジェクト独自のもの（**塩川紗季**による）。*

| | 誰 | 役割 |
|---|-----|------|
| ![Masahiro Ootaki](../../../docs/members/ootaki-masahiro.jpg) | **大瀧 雅寛 / Masahiro Ootaki** | 一級**建築士**（バリアフリー住宅）。bFaaaP のデザイン＆まとめ役 —— そして、その依頼主の願いが全ての始まり。 |
| ![Tomoyuki Shishido](../../../docs/members/shishido-tomoyuki.jpg) | **宍戸 知行 / Tomoyuki Shishido** | **iOSアプリ**。博士・弁理士。現在は東京科学大学の博士課程。bFaaaP のために Swift を習得。45歳でピアノを始めた。 |
| ![Hiroyuki Narusawa](../../../docs/members/narusawa-hiroyuki.jpg) | **成澤 博行 / Hiroyuki Narusawa** | **ペダル装置＆ファームウェア**。Naru Science Soft 主宰。押す側のハードを設計・製作。 |
| ![Kyoko Yamaguchi](../../../docs/members/yamaguchi-kyoko.jpg) | **山口 恭子 / Kyoko Yamaguchi** | **ピアノ＆指導**。指導歴約15年。IT時代の新しいペダル奏法を提唱。 |
| ![Daisuke Tokushige](../../../docs/members/tokushige-daisuke.jpg) | **徳重 大輔 / Daisuke Tokushige** | **知的財産**。bFaaaP の特許を支える特許技術者。 |
| ![kana](../../../docs/members/kana.png) | **kana** | **ピアノ調律師**。ペダルと指の技術をひとつのフレーズと捉え、bFaaaP をその理想の具現と見る。 |
| ![Fehmiju Fati](../../../docs/members/member2020.png) | **Fehmiju Fati** | **作曲／コンピュータ音楽**。国際的な受賞歴。日本でコンピュータ音楽を学び、KORG の音源開発に参加。2019〜2023年は bFaaaP にボランティアとして参加。 |
| ![Midori](../../../docs/members/midori.png) | **Midori** | **音楽＆ヘルスケア**。*「bFaaaP は心のスイッチも入れてくれるかも。」* |
| ![Hiroyoshi Kawaguchi](../../../docs/members/kawaguchi.jpg) | **川口 洋慶 / Hiroyoshi Kawaguchi** | **キーボード＆開発**。東京科学大（システム制御）。プログラミング＋深層学習、ピアノは3歳から。 |
| ![Haruto Tanaka](../../../docs/members/tanaka.jpg) | **田中 遥斗 / Haruto Tanaka** | **電気工学**。東京科学大。Switch をピアノ以外にも広げたい。 |
| ![Taguchi](../../../docs/members/taguchi.jpg) | **田口 / Taguchi** | **ソフトウェア工学**。bFaaaP の知見を深め、ユーザーの声から改良することを目指す。 |

→ 詳しいプロフィール：[`docs/members/`](../../../docs/members/)。

## 5. 見て、聴いてください 🎬

bFaaaP を理解する一番の近道は、実際の演奏を見ることです。すべて
**[YouTube チャンネル](https://www.youtube.com/channel/UCcAvTy1k8rHs2WrEKPx1amg)** にあります。カテゴリ別の
ハイライト（新しい順）：

### 🏆 まずはこの2本
- **▶ [2025 プラタナスすずかけコンサート with bFaaaP](https://www.youtube.com/watch?v=V3cXeNW9jXY)** · 72:20
  **グランドピアノ（Pro）**でのフルコンサート。**25:01〜28:32 に装置の設置解説**も。Pro を理解するなら最適の1本。
- **▶ [2024 工大祭（東京科学大学）](https://www.youtube.com/watch?v=Im4jsed1tJQ)** · 55:29
  システム紹介＋メンバー＋**電子ピアノ（Switch）**で3曲、その後ハンズオン**ワークショップ**（39:21〜54:18）。

![Platanus with bFaaaP —— コンサート ポスター](../../../docs/media/poster_concert_pro_2025.jpg)

### 🎹 そのほかの演奏会
- **▶ [すずかけサイエンスデイ 2024](https://www.youtube.com/watch?v=B820ctNblJE)** · 35:02
- **▶ [工大祭2023 — bFaaaP Pro](https://www.youtube.com/watch?v=9Sc8G1ESa-g)** · 02:40
- **▶ [bFaaaP Pro @ ムジカーザ 2023‑07‑23](https://www.youtube.com/watch?v=S45xN5yFaRo)** · 03:45
- **▶ [夏の響演2022 — 7大学合同演奏会](https://youtu.be/uXMLea6_eKM)**（豊洲シビックセンターホール, 2022‑09‑05）—— 東工大**プラタナス**のメンバーが **bFaaaP** で「花の歌」を演奏。他大学の奏者と並ぶ**正式な合同演奏会**での使用例（[イベント情報](https://natsunokyoen2022.github.io/)）。
- **▶ [ピアノ発表会 2022‑04‑02（Pro）](https://www.youtube.com/watch?v=O8X2gEqEU6k)** · 06:55
- **▶ [bFaaaP Performance, MusicFair 2020](https://www.youtube.com/watch?v=6_y9MI1IdTQ)** · 16:06
- **▶ [New bFaaaP6, MusicFair 2020](https://www.youtube.com/watch?v=j1ZIJ53j7NE)** · 06:39
- **▶ [bFaaaP ピアノリサイタル 2019‑03‑23](https://www.youtube.com/watch?v=EK8Tx5uUcM4)** · 05:16

### 🛠️ 設置・調整
- **▶ [bFaaaP Pro 設置手順（2025‑07‑24）](https://www.youtube.com/watch?v=_9YopbCYTmI)** · 06:50 —— **Pro 設置**の手順。
- **▶ [センサー調整](https://www.youtube.com/watch?v=t7jpf-Yb7Bw)** · **▶ [アクチュエータ調整](https://www.youtube.com/watch?v=V22nsIJJGxI)** · **▶ [発表会準備](https://www.youtube.com/watch?v=wqaxhvOI-yE)**（2019・初期システム）

### 📖 マニュアル
- **▶ [bFaaaP Switch の使い方](https://youtu.be/XOVENtBsOp4)** · 03:18 —— 公式の**操作マニュアル**動画。

### 📣 概要・宣伝
- **▶ [ユーザーの声 — Ayano さん](https://www.youtube.com/watch?v=pYSLIV4H5dg)** · 00:16
- **▶ [bFaaaP Switch @ 国際福祉機器展2021（HCR）](https://www.youtube.com/watch?v=jYLC7Hreovc)** · 23:17
- **▶ [bFaaaP Switch Promotion](https://www.youtube.com/watch?v=09QJAuZT2us)** · 07:09
- **▶ [bFaaaP Overview, MusicFair 2020](https://www.youtube.com/watch?v=iyRqPa8TLgE)** · 26:43 —— 長めの仕組み紹介。
- **▶ [最初期のデモ（2018‑11‑16）](https://www.youtube.com/watch?v=5-roDvbRe5c)** · 01:38

### 📢 お知らせ
- **▶ [都内2つのピアノ教室で bFaaaP レッスン可能に（2026‑01）](https://www.youtube.com/watch?v=xx_nsxWR6J0)** · 04:02
- **▶ [2024年 bFaaaP 発表会](https://www.youtube.com/watch?v=8sVPmwiU-cY)** · 03:37

### 🎼 関連
- **▶ [スタインウェイ K132 の調律](https://www.youtube.com/watch?v=k60HT7zp5pg)** · 30:27
- **▶ [サラバンド（ヘンデル）— bFaaaP なしで弾ける曲](https://www.youtube.com/watch?v=PEsBBFNyKBM)** · 03:21 —— サステイン不要の古典様式。対比で bFaaaP の価値が分かる。

→ 注釈付きの全リスト：[`docs/videos/`](../../../docs/videos/)。

## 6. ミッション：すべての人に音楽を 💛

![ピアノと若芽を手で支え、人々のコミュニティに囲まれる](../../../docs/media/illustrations/intl-support.png)

bFaaaP は、**誰もが** —— 手足に障害のある方、小さな子ども、高齢の方、気管切開のある方 —— ペダルの豊かな
表現でピアノを楽しめるように存在します。今では演奏会やレッスンで使われ、その効果は臨床的な評価でも
測られました。

そして今や **オープンソース** です。アプリ・ファームウェア・3Dプリント部品・このドキュメントはすべて公開され、
誰もが学び、作り、改良できます。

- 🔧 **自分で作る：** [自分で作る](build/) —— iOSアプリ・Pro・Switch
- 🤖 **製作のヘルプ：** [AI支援サポート](ai-support.md) —— GitHub Discussions で質問
- 💛 **プロジェクトを支援：** [SUPPORT](../SUPPORT.md)

*イラスト：塩川紗季、および bFaaaP プロジェクト（AI支援）。[プロジェクトの歴史](../../../docs/HISTORY.md)も参照。*
