# APEE 試験 —— bFaaaP は本当に効くのか？

> 🌐 [English](../../../docs/apee-study.md) · **日本語** · [Deutsch](../../de/docs/apee-study.md)

ペダルを*頭で*踏んで、足でペダルを踏んだときのような豊かで伸びのある響きが本当に得られるのか？
私たちは人を対象とした試験 —— **補助ペダル効果評価（Auxiliary Pedal Effect Evaluation, APEE）** ——
を **15名**（成人、足がペダルに届かない子ども、障害のある方）で実施しました。

![スマホを譜面台に置き、床にペダル装置を置いて、子どもや車いすの奏者がやさしいAPEEピアノ試験に参加する様子](../../../docs/media/illustrations/apee-children.png)

*APEE のひとこま（イラスト）。AI生成（Gemini・塩川紗季風）© 宍戸＆アソシエーツ。*

## どう測ったか
各参加者は同じ短い旋律を**3通り**で演奏しました —— **ペダルなし**（pattern 0）、**bFaaaP pattern 1**
（3音グループごとに踏み替え）、**bFaaaP pattern 2**（グループをまたいで保持） —— そのそれぞれを録音。
次に**音振動面積（tone‑vibration area, TVA）**＝録音波形の塗りつぶし面積（音が伸びるほど大きくなる）を
測定します。各録音は自身のペダルなし録音で正規化（TVA₀ ≡ 1.00）し、**サステインスコア = TVAₙ / TVA₀** とします。

![APEE のパイプライン：2つのペダルパターンの楽譜 → 3テイク録音 → 音振動面積の測定 → 正規化 → 相対サステインスコア](../../../docs/media/diagrams/fig-apee-pipeline.png)

*図（論文）—— APEE 法の全体像。© 宍戸＆アソシエーツ（CC BY 4.0）。図中は英語。*

![実際の試験楽譜。pattern 1（3音グループごとに踏み替え）と pattern 2（グループをまたいで保持）](../../../docs/media/diagrams/fig-apee-test-score.png)

*実際の試験楽譜と2つのペダルパターン（特許図より）。図中は英語。*

### サステインの測定（TVA）
ペダルが多い → 弦がより長く響く → 波形の塗りつぶし面積が大きい。試験全体の平均は、ペダルなし／pattern 1／
pattern 2 で **1.00 / 1.59 / 1.80** でした。

![3つの波形 —— ペダルなし（面積1.00）、pattern 1（1.59）、pattern 2（1.80）—— ペダルが多いほど音振動面積が大きい](../../../docs/media/diagrams/fig-apee-tva.png)

*図（論文）—— 音振動面積からサステインスコアを計算。© 宍戸＆アソシエーツ（CC BY 4.0）。図中は英語。*

## 何がわかったか
- **bFaaaP はサステイン（伸びる音のエネルギー）を有意に増やす** —— どちらのパターンもペダルなしを上回りました
  （**p < 0.01**）。
- **奏者自身の足と統計的に区別できない**（**p > 0.05**、"n.s."）。
- **参加者のクラス間で有意差なし**（成人／子ども／障害のある方）。**足の障害と気管切開**のある参加者も、
  小さなオフセットと大きな倍率で問題なく演奏できました。

![APEE の結果：(a) bFaaaP の両パターンがサステインを有意に増加（p<0.01）、(b) bFaaaP と奏者自身の足では有意差なし](../../../docs/media/diagrams/fig-apee-results.png)

*図（論文）—— APEE の臨床結果。© 宍戸＆アソシエーツ（CC BY 4.0）。図中は英語。*

## 匿名化した全データ（Appendix A）
**全46録音**（参加者は **No. 1–15** として匿名化）。各奏者が選んだオフセット・倍率と、pattern 1・2 の
相対サステインを掲載。元の試験図から転記。出典：[`bfaaap_arxiv_latex`](../../../bfaaap_arxiv_latex/README.md)
の Appendix A。

![Appendix A —— 匿名化した APEE 全記録データ：成人・子ども・障害のある方にわたる46録音、各オフセット・倍率と pattern 1・2 の相対サステイン](../../../docs/media/diagrams/table-apee-data.png)

*Appendix A —— 匿名化した APEE 全データ（No. 1–15、46録音）。© 宍戸＆アソシエーツ（CC BY 4.0）。図中は英語。*

元の匿名化試験図は [`docs/history/pct-original-figures/`](../../../docs/history/pct-original-figures/README.md)
に保存しています。手法・統計・考察の詳細は[論文](../../../bfaaap_arxiv_latex/README.md)をご覧ください。

---

← [仕組み](how-it-works.md) へ戻る · [用語集](GLOSSARY.md) · [ストーリー](story.md)
