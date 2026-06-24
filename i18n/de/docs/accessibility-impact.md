# Der Controller als wiederverwendbare Barrierefreiheits-Eingabe — und wem er helfen könnte

> 🌐 [English](../../../docs/accessibility-impact.md) · [日本語](../../ja/docs/accessibility-impact.md) · **Deutsch**

*(Diese Seite fasst §4.6 „Generality and the practical value of the controller“ und die
Bevölkerungs­diskussion des [Papers](../../../bfaaap_arxiv_latex/README.md) zusammen, mit den zwei
Bevölkerungs­tabellen und den zitierten Quellen.)*

## Der Controller ist der wiederverwendbare Teil
bFaaaPs Smartphone-**Controller** — ein quantitativer, **nutzerabstimmbarer Kopfwinkel-Kanal** auf
Standard-Hardware — ist die Komponente mit dem höchsten praktischen Wert, und nichts daran ist
pedalspezifisch. Derselbe Controller steuert bereits **zwei verschiedene Aktuatoren** (einen Motor beim
*Pro*, einen elektronischen Schalter beim *Switch*), und die zugrunde liegende
**Geräte-Controller-Methode ist unabhängig vom Pedal patentiert** und umfasst „jedes Gerät“. Der
Kopfwinkel-Kanal ist also eine wiederverwendbare **inklusive Eingabe**.

## Warum er zu diesen Gruppen passt
- **Fußfrei** — er benötigt nicht die unteren Gliedmaßen, die **Rollstuhlnutzende** oft nicht
  einsetzen können.
- **Nichts am Gesicht oder Kopf** — das Smartphone steht auf einem Ständer. Das ist wichtig für
  Menschen mit **Tracheostoma**, Gesichtsempfindlichkeit oder wenn Atemweg und Gesicht frei bleiben
  müssen.
- **Auf eingeschränkten Bewegungsumfang abstimmbar** — ein *kleiner Offset* mit einem *großen Faktor*
  lässt wenige Grad verbleibender Kopfbewegung den gesamten Ausgabebereich abdecken (eine Studien­person
  mit Beinbehinderung und Tracheostoma hat dies gezeigt).

Da das Kopfwinkel-Signal ein **kontinuierlicher, proportionaler Wert** ist — kein einzelner Ein/Aus-
Schalter — ist es eine allgemeine **Barrierefreiheits-Steuerungsprimitive**: derselbe Kanal, der hier
ein Haltepedal dosiert, könnte im Prinzip andere abgestufte Steuerungen dosieren (eine Einstellung der
Umfeld­steuerung, die Scan-Rate einer Kommunikationshilfe, die Stufe eines elektrischen Geräts).
*Wir präsentieren dies als Richtung für künftige Arbeit: bFaaaP ist für das Klavierpedalspiel
validiert; eine breitere assistive Steuerung ist noch nicht validiert.*

## Wie viele Menschen? (weltweite Größenordnung)
Die Gruppen sind groß und weltweit. **Die folgenden Zahlen stammen aus heterogenen Erhebungen mit
unterschiedlichen Definitionen/Metriken und sind nicht streng vergleichbar** — sie vermitteln die
Größenordnung, keine genaue Rangfolge. (WHO veröffentlicht nur eine einzige *globale* Rollstuhl­schätzung,
keine länderweise Tabelle.)

### Tabelle 1 — Rollstuhlnutzende (oder Menschen, die einen Rollstuhl *benötigen*), nach Region
| Region | Schätzung | Jahr | Quelle |
|--------|-----------|------|--------|
| Welt | ~80 Mio. (~1 % der Bevölkerung) **benötigen** einen Rollstuhl | — | WHO [1], [2] |
| USA | 3,6 Mio. Nutzende (1,5 %, ab 15 J.) | 2010 | US Census [3] |
| UK (England) | ~1,2 Mio. Nutzende (Schätzung) | 2017 | NHS England [4] |
| Kanada | 288.800 Rollstuhl-/Scooter-Nutzende (~1,0 %) | 2012 | Smith et al. [5] |
| Japan | ~818.000 manuelle Rollstühle in Nutzung (~0,6 %) | 2019 | Shirogane et al. [6] |
| Australien | ~119.000 manuelle Rollstuhlnutzende (65+); 679.000 nutzen Mobilitätshilfen | 2018 | AIHW / ABS SDAC [7] |

*Definitionen unterscheiden sich („Nutzende“ vs. „Bedarf“; nur Gemeinde vs. alle; Altersgrenzen); Deutschland hat keine offizielle Rollstuhlnutzer-Zahl.*

### Tabelle 2 — Häusliche mechanische Beatmung (HMV) und invasive/Tracheostoma-Teilmenge, nach Land
| Land | HMV-Nutzende | Invasiv (Trach.) | pro 100k | Jahr | Quelle |
|------|--------------|------------------|----------|------|--------|
| Japan | ~21.000 | 7.700 (TPPV) | — | 2020 | MHLW [8] |
| Europa (16 Länder) | 21.526 | je nach Land | 6,6 | 2002 | Eurovent [9] |
| Kanada | 4.334 | ~18 % | 12,9 | 2012 | Rose et al. [10] |
| Polen | 12.616 | — | 2,8→20,0 | 2009–19 | Czajkowska‑Malinowska et al. [11] |
| Ungarn | 384 | 40 (10,4 %) | 3,9 | 2018 | Valkó et al. [12] |
| Südkorea | — | 62,8 % Trach. | 9,3 | 2016 | Kim et al. [13] |
| Deutschland | ~17.000/Jahr (Episoden) | ~6 % | — | 2018 | Schwarz et al. [14] |
| USA | kein nationales Register | — | — | — | Mehta et al. [15] |

*Metrik-Typen unterscheiden sich: Punktprävalenz-Kopfzahl (Japan), Prävalenz pro 100.000 (Europa, Kanada, Polen, Ungarn, Südkorea), stationäre Episoden/Jahr (Deutschland), und kein nationales Register in den USA.*

## Zitierte Quellen (References)
Geprüft im Juni 2026. Gespeicherte Kopien der Open-Access-/öffentlichen Quellen liegen in
[`docs/references/`](../../../docs/references/README.md).

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
16. bFaaaP Geräte-Controller-Patent: **JP 7004771 B2** (umfasst „jedes Gerät“). <https://patents.google.com/patent/JP7004771B2>

---

← Zurück zu [Funktionsweise](how-it-works.md) · [APEE-Studie](apee-study.md) · [Glossar](GLOSSARY.md)
