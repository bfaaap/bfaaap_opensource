# コントローラ＝再利用可能なアクセシビリティ入力 —— そして誰の役に立つか

> 🌐 [English](../../../docs/accessibility-impact.md) · **日本語** · [Deutsch](../../de/docs/accessibility-impact.md)

*（本ページは[論文](../../../bfaaap_arxiv_latex/README.md)の §4.6「Generality and the practical value of
the controller（コントローラの汎用性と実用的価値）」と人口に関する議論を、2つの人口表と引用とともに要約したものです。）*

## 再利用できるのはコントローラ
bFaaaP のスマホ**コントローラ** —— 汎用ハードウェア上の**定量的・ユーザー調整可能な頭部角度チャンネル**
—— が最も実用的価値の高い構成要素で、ペダル専用の要素は何もありません。同じコントローラが既に**2種類の
アクチュエータ**（*Pro* のモーター、*Switch* の電子スイッチ）を駆動し、その基盤となる**デバイス制御方式は
ペダルとは独立に特許化**され「あらゆる装置」を対象にしています。つまり頭部角度チャンネルは**再利用可能な
インクルーシブ入力**です。

## なぜこれらの方々に適合するのか
- **足を使わない（foot‑free）** —— **車いす利用者**がしばしば使えない下肢に依存しません。
- **顔や頭に何も付けない** —— スマホは譜面台に置きます。**気管切開**の方、顔が敏感な方、気道や顔を
  確保しておく必要がある方に重要です。
- **狭い可動域に調整できる** —— *小さなオフセット＋大きな倍率*で、わずか数度の頭の動きが全出力範囲を
  カバーできます（足の障害と気管切開のある参加者が実証）。

頭部角度信号は**連続的で比例的な値**（単一のオン/オフではない）なので、汎用の
**アクセシビリティ制御プリミティブ**になります。ここでサステインペダルを調整する同じチャンネルが、原理的には
他の段階的制御（環境制御の設定、コミュニケーション支援のスキャン速度、電動機器のレベル）も調整できます。
*これは今後の課題としての提示です：bFaaaP はピアノのペダリングで検証済みですが、より広い支援制御は未検証です。*

## 対象となる人はどれくらい？（全世界規模）
対象集団は大きく全世界に及びます。**以下の数値は定義・指標の異なる不均一な調査に基づき、厳密には比較できません**
——規模を示すためのもので、正確な順位付けではありません。（WHO は単一の*世界*推定のみで、車いすの国別表は
ありません。）

### 表1 —— 車いす利用者（または車いすを*必要とする*人）の地域別
| 地域 | 推定値 | 年 | 出典 |
|------|--------|----|------|
| 世界 | 約8,000万人（人口の約1%）が車いすを**必要** | — | WHO [1], [2] |
| 米国 | 利用者360万人（15歳以上の1.5%） | 2010 | US Census [3] |
| 英国（イングランド） | 利用者 約120万人（推定） | 2017 | NHS England [4] |
| カナダ | 車いす/スクーター利用者 288,800人（約1.0%） | 2012 | Smith et al. [5] |
| 日本 | 使用中の手動車いす 約818,000台（約0.6%） | 2019 | Shirogane et al. [6] |
| 豪州 | 手動車いす利用者 約119,000人（65歳以上）；移動補助具利用 679,000人 | 2018 | AIHW / ABS SDAC [7] |

*定義が異なる（「利用者」対「必要」、地域居住のみ対全体、年齢区分）。ドイツには公的な車いす利用者数がありません。*

### 表2 —— 在宅人工呼吸（HMV）と侵襲（気管切開）サブセットの国別
| 国 | HMV利用者 | 侵襲（気管切開） | 10万対 | 年 | 出典 |
|----|-----------|------------------|--------|----|------|
| 日本 | 約21,000 | 7,700（TPPV） | — | 2020 | MHLW [8] |
| 欧州（16か国） | 21,526 | 国により異なる | 6.6 | 2002 | Eurovent [9] |
| カナダ | 4,334 | 約18% | 12.9 | 2012 | Rose et al. [10] |
| ポーランド | 12,616 | — | 2.8→20.0 | 2009–19 | Czajkowska‑Malinowska et al. [11] |
| ハンガリー | 384 | 40（10.4%） | 3.9 | 2018 | Valkó et al. [12] |
| 韓国 | — | 気管切開62.8% | 9.3 | 2016 | Kim et al. [13] |
| ドイツ | 約17,000/年（エピソード） | 約6% | — | 2018 | Schwarz et al. [14] |
| 米国 | 全国登録なし | — | — | — | Mehta et al. [15] |

*指標の種類が異なる：点有病率の実数（日本）、10万対有病率（欧州・カナダ・ポーランド・ハンガリー・韓国）、入院エピソード/年（ドイツ）、米国は全国の在宅人工呼吸登録なし。*

## 引用文献（References）
2026年6月確認。オープンアクセス/公的資料の保存PDFは [`docs/references/`](../../../docs/references/README.md) にあります。

1. WHO. *WHO releases new wheelchair provision guidelines.* 2023. <https://www.who.int/news/item/05-06-2023-who-releases-new-wheelchair-provision-guidelines>
2. WHO & UNICEF. *Global Report on Assistive Technology.* 2022. <https://www.who.int/publications/i/item/9789240049451>
3. Brault, M. *Americans With Disabilities: 2010.* US Census Bureau, P70‑131, 2012. <https://www2.census.gov/library/publications/2012/demo/p70-131.pdf>
4. NHS England. *Wheelchair services.* <https://www.england.nhs.uk/wheelchair-services/>
5. Smith EM, Giesbrecht EM, Mortenson WB, Miller WC. *Prevalence of Wheelchair and Scooter Use Among Community‑Dwelling Canadians.* Phys Ther 96(8):1135–1142, 2016. <https://doi.org/10.2522/ptj.20150574>
6. Shirogane S, et al. *Provision of public funding for wheelchairs and postural support devices in Japan.* J Phys Ther Sci 31(2):122–126, 2019. <https://doi.org/10.1589/jpts.31.122>
7. AIHW. *People with disability in Australia* (ABS SDAC 2018). <https://www.aihw.gov.au/reports/disability/people-with-disability-in-australia>
8. MHLW (Japan), Intractable‑Disease Policy Research. *Nationwide home mechanical‑ventilation survey* (as of 2020). <https://mhlw-grants.niph.go.jp/>
9. Lloyd‑Owen SJ, et al. *Patterns of home mechanical ventilation use in Europe: results from the Eurovent survey.* Eur Respir J 25(6):1025–1031, 2005. <https://doi.org/10.1183/09031936.05.00066704>
10. Rose L, et al. *Home Mechanical Ventilation in Canada: A National Survey.* Respir Care 60(5):695–704, 2015. <https://doi.org/10.4187/respcare.03609>
11. Czajkowska‑Malinowska M, et al. *Development of Home Mechanical Ventilation in Poland in 2009–2019…* J Clin Med 11(8):2098, 2022. <https://doi.org/10.3390/jcm11082098>
12. Valkó L, Baglyas S, Gál J, Lorx A. *National survey: current prevalence and characteristics of home mechanical ventilation in Hungary.* BMC Pulm Med 18:190, 2018. <https://doi.org/10.1186/s12890-018-0754-x>
13. Kim H‑I, et al. *Home Mechanical Ventilation Use in South Korea Based on National Health Insurance Service Data.* Respir Care 64(5):528–535, 2019. <https://doi.org/10.4187/respcare.06310>
14. Schwarz SB, et al. *The Development of Inpatient Initiation and Follow‑up of Home Mechanical Ventilation in Germany.* Dtsch Arztebl Int 118(23):403–404, 2021. <https://doi.org/10.3238/arztebl.m2021.0193>
15. Mehta AB, et al. *Trends in Tracheostomy for Mechanically Ventilated Patients in the United States, 1993–2012.* Am J Respir Crit Care Med 192(4):446–454, 2015. <https://doi.org/10.1164/rccm.201502-0239OC>
16. bFaaaP デバイス制御特許：**JP 7004771 B2**（「あらゆる装置」を対象）。<https://patents.google.com/patent/JP7004771B2>

---

← [仕組み](how-it-works.md) へ戻る · [APEE 試験](apee-study.md) · [用語集](GLOSSARY.md)
