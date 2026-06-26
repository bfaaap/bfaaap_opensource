# Wie bFaaaP funktioniert (die einfache Version)

> 🌐 [English](../../../docs/how-it-works.md) · [日本語](../../ja/docs/how-it-works.md) · **Deutsch**

Neu hier? Diese Seite erklärt die ganze Idee in einfachen Worten. Unbekannte Begriffe stehen im
[Glossar](GLOSSARY.md).

![Deine Absicht → Gesichtserkennung → Bluetooth → Controller](../../../docs/media/illustrations/intl-how-it-works.png)

## In einem Satz
Du **neigst den Kopf** ein wenig; ein iPhone/iPad **sieht die Neigung**; es sendet sie per
**Bluetooth** an ein kleines Gerät am Klavier; das Gerät **drückt das Haltepedal**. Keine Füße nötig.

## Die vier Schritte
1. **Deine Absicht (Kopfwinkel).** Du neigst den Kopf leicht. Diese Bewegung ist deine Absicht
   „Pedal hoch / Pedal runter“.
2. **Das Telefon liest sie.** Apples Gesichts‑Tracking (**ARKit / TrueDepth**) misst den Kopfwinkel
   und macht daraus eine Zahl von 0–99 %.
3. **Bluetooth überträgt sie.** Die App sendet kleine Nachrichten (`i00`–`i99`) per **BLE** an das
   Gerät. Du legst deine eigene **Schwelle (Offset)** und deinen **Faktor** fest — passend zu dir.
4. **Das Gerät drückt das Pedal.**
   - **Pro** (akustisch): ein kleiner **Motor** schiebt eine Stange auf das Haltepedal; ein
     **Airback**‑Kissen fixiert es, ohne die Klavieroberfläche zu berühren.
   - **Switch** (E‑Piano): das Gerät schließt die Sustain‑Funktion **elektronisch** über die
     Pedalbuchse des Instruments — ganz ohne Motor.

#### Warum „airback" (ein geprägter Begriff, kein „airbag")
Der **„airback"** ist bFaaaPs aufblasbarer, **luftgestützter Anker** — *kein* „airbag". Ein
Luftkissen (ein **WINBAG**-Luftheber, aufgepumpt von einer kleinen **elektrischen Pumpe im Gerät**
über einen Luftschlauch) bläst sich unter einem Nachbarpedal auf und nimmt die **Reaktionskraft** des
Aktuators auf, sodass das **Pro**-Gerät auf einem *unveränderten* akustischen Klavier fest sitzt: **ohne
Schrauben, zerstörungsfrei und schnell auf-/abzubauen**. Der Name verbindet *air* + *back*
(stützen/abstützen) und betont das Verankern statt der Sicherheitsbedeutung von „airbag".

![Schema: ein einzelnes breites „airback"-Kissen liegt unter den beiden linken Pedalen und verankert das Pro-Gerät gegen die Reaktionskraft beim Drücken des Haltepedals; die Antriebseinheit sitzt auf dem rechten (Halte-)Pedal; keine Schrauben](../../../docs/media/illustrations/airback-anchoring.png)

*„airback"-Reaktionskraft-Verankerung (Schema). © Shishido & Associates (CC BY 4.0).*

### Das Regelgesetz — wie eine Neigung zum Pedaldruck wird
Das ist das Herzstück von bFaaaP (und Gegenstand der Patente). Eine kleine **Totzone (Offset)**
sorgt dafür, dass kleine, unwillkürliche Kopfbewegungen nichts bewirken; jenseits deiner Schwelle
folgt das Pedal deiner Neigung mit einem von dir gewählten **Faktor** und erreicht innerhalb
weniger Grad das volle Pedal. Eine kleine **Hysterese** (Eingriff vs. Lösen) verhindert Flattern.

![Regelgesetz: Kopfwinkel → Pedal, mit Totzone, Faktor und Hysterese](../../../docs/media/diagrams/control-law.png)

In der iOS‑App stellst du nur zwei Dinge ein: die **Schwelle (Offset)** und den **Faktor**. Beide
zusammen ergeben eine sekundäre, zeitliche **Reaktionsgeschwindigkeit** (wie schnell das Pedal dem
Kopf jenseits der Totzone folgt) — kein separater Regler. Dieses quantitative, abstimmbare
Regelgesetz ist der **Schlüssel**, der eine kleine Kopfneigung in das *vom Spieler beabsichtigte*
Pedalspiel verwandelt — natürliches, ausdrucksvolles Spiel statt eines groben An/Aus — und zugleich
die **Voraussetzung für die Patenterteilung**: Die bloße Kopf→Pedal‑Idee war bekannt, daher wurden
die Patente auf *dieses spezifische, abstimmbare Gesetz* erteilt, nicht auf die Architektur.
(Hintergrund: das patentierte Verfahren nutzt eine Offset‑Obergrenze von 3–10°, einen Faktor von
10–50 und volles Pedal innerhalb +2–10°. Siehe den
[Patent‑Leitfaden](../../../bfaaap_patent_info/general_description/README.md).)

![Eine kleine Kopfneigung ist der „Schlüssel", der das vom Spieler beabsichtigte, natürliche Pedalspiel freisetzt](../../../docs/media/illustrations/control-law-key.png)

*Das Regelgesetz ist der **Schlüssel**: Eine **kleine Kopfneigung** — geformt durch die von dir
voreingestellte Schwelle (Offset) und den Faktor — setzt dein **eigenes, beabsichtigtes und
natürliches** Pedalspiel frei statt eines groben An/Aus, und genau dieses spezifische, abstimmbare
Gesetz (nicht die bloße Kopf→Pedal‑Idee) war Voraussetzung für die Patenterteilung. Illustration:
KI‑generiert (Gemini, Stil von Saki Shiokawa) © Shishido & Associates.*

#### Das Regelgesetz, genau (Abbildungen 3 & 4 aus dem Paper)
Diese zwei Abbildungen (aus dem [Paper](../../../bfaaap_arxiv_latex/README.md)) machen das Regelgesetz
exakt (Text in den Abbildungen auf Englisch).

**Abbildung 3 — das Regelgesetz.** (a) Oberhalb deines neutralen **Offsets** wird der Kopfwinkel
**linear** auf den Pedalwert (0–99) abgebildet, mit deinem **Faktor** skaliert und beim Vollwert
begrenzt. (b) Drücken und Loslassen nutzen eine kleine **Hysterese (Totband δ)**, damit das Pedal
nicht flattert, wenn der Kopf nahe der Schwelle schwebt.

![Abbildung 3: (a) Kopfwinkel über dem Offset wird linear auf den Pedalwert abgebildet, bei 99 begrenzt; (b) Drücken/Loslassen mit Hysterese-Totband](../../../docs/media/diagrams/fig-control-law.png)

*Abbildung 3 aus dem Paper — Kopfwinkel‑Regelgesetz. © Shishido & Associates (CC BY 4.0).*

**Abbildung 4 — warum es patentierbar ist.** Der Stand der Technik war ein **binärer An/Aus**‑Kopfschalter
(gestrichelte Stufe). bFaaaP sendet stattdessen einen **kontinuierlichen, proportionalen** Befehl,
dessen **Totzone** (Offset 3–10°) und **Steigung** (Faktor 10–50) jeder Spieler voreinstellt — das
quantitative, nutzerabstimmbare Gesetz, auf das die Patente erteilt wurden.

![Abbildung 4: bFaaaPs proportionaler, abstimmbarer Befehl (zwei Steigungen) gegenüber binärem An/Aus des Stands der Technik an einer einzigen Schwelle](../../../docs/media/diagrams/fig-control-vs-priorart.png)

*Abbildung 4 aus dem Paper — quantitative, nutzerabstimmbare Abbildung vs. binärer Stand der Technik. © Shishido & Associates (CC BY 4.0).*

**Funktioniert es wirklich?** Eine Studie mit 15 Versuchspersonen sagt ja — siehe die
**[APEE‑Studie](apee-study.md)** (Methode, Ergebnisse und die vollständigen anonymisierten Daten).

**Wem könnte es helfen, und was kann der Controller noch?** Siehe
**[Barrierefreiheits‑Wirkung](accessibility-impact.md)** — der Controller als wiederverwendbare
Eingabe, mit weltweiten Rollstuhl‑ und Heimbeatmungs‑Zahlen (mit Quellen).

## Ein eleganter Designtrick
Das Telefon erzeugt Kopfwinkel *viel schneller*, als Bluetooth sie senden sollte. Daher **taktet**
die App den Funk (≈100‑ms‑Timer + Drossel), um die Verbindung absolut stabil zu halten. Ein kleiner
Trick mit großer Wirkung — siehe [`ios-app/DESIGN-HIGHLIGHTS.md`](../../../ios-app/DESIGN-HIGHLIGHTS.md).

## Was im Gerät steckt
```
iPhone/iPad‑App ──BLE (i00–i99)──▶ BLE‑Board (nRF52840) ──UART (1 Byte)──▶ Pico (RP2040) ──▶ Pedal
```
Der **Pico** ist das Gehirn, das den Motor (Pro) oder den Schalter (Switch) ansteuert; das
**nRF52840** übernimmt Bluetooth. Verdrahtung, Teile und Schritt‑für‑Schritt: [Selbst bauen](build/).

---
→ Weiter: [Selbst bauen](build/) · [Die bFaaaP‑Geschichte](story.md) · [Glossar](GLOSSARY.md) · [Quellenübersicht](../../../docs/SOURCE-MAP.md)
