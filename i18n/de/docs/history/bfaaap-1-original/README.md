# bFaaaP 1 — wo die Erfindung begann (2018)

> 🌐 [English](../../../../../docs/history/bfaaap-1-original/README.md) · [日本語](../../../../ja/docs/history/bfaaap-1-original/README.md) · **Deutsch**

Dies sind die **allerersten bFaaaP‑Zeichnungen**, erstellt **2018** für die erste Patentfamilie
(PCT **WO 2019/176164**, eingereicht am 2018‑11‑12). Wir nennen diese Generation **„bFaaaP 1“**. Sie
sieht reizvoll anders aus als das heutige Smartphone‑und‑Airback‑System — doch bei genauem Hinsehen
war **fast jede wichtige Idee schon da.** bFaaaP 1 ist der Ursprung der Erfindung und der Grundlagen
eines guten, zerstörungsfreien Geräts.

![Eine warme Bilderbuch-Illustration: ein Pianist von 2018 mit einer Brille, an deren Rahmen ein kleiner Kopfwinkel-Sensor sitzt, spielt einen Flügel; neben den Pedalen steht ein kleines Gerät](../../../../../docs/history/bfaaap-1-original/bfaaap1-pianist-2018.png)

*Das erste bFaaaP, 2018: ein Sensor an einer Brille und ein Pedalgerät am Boden. Illustration: KI‑generiert (Gemini, Stil von Saki Shiokawa) © Shishido & Associates.*

## Die Erfindung war schon da
Nimmt man die Hardware von 2018 weg, ist der **Kern identisch mit heute**: ein **quantitatives,
nutzerabstimmbares Regelgesetz** — vom Kopfwinkel eine **Totzone (Offset)** abziehen, mit einem
**Faktor** multiplizieren, auf **0–99** begrenzen und drahtlos an einen Pedal‑Aktuator senden; die
spielende Person stellt Offset und Faktor **voreingestellt** ein. Genau das ist der „Schlüssel“, auf
den die Patente erteilt wurden (siehe [Funktionsweise](../../how-it-works.md) und das
[Paper](../../../../../bfaaap_arxiv_latex/README.md)). Nur **Sensor** und **Halterung** haben sich
weiterentwickelt.

![Vergleichsabbildung: ein grünes Band „THE INVENTION — unverändert seit 2018“ (das abstimmbare Regelgesetz) über zwei Karten — bFaaaP 1 (2018: Brillen-MPU-9250-IMU + schalldichte Kammer) und Heute/bFaaaP 4 (Smartphone-ARKit + Airback oder Switch) — mit einem Pfeil, der die technische Entwicklung zeigt](../../../../../docs/history/bfaaap-1-original/the-invention-from-the-start.png)

**Was bFaaaP 1 bereits richtig machte (die Saat):**
- **Das Regelgesetz als Beitrag** — Offset + Faktor + Begrenzung, nutzervoreingestellt (Abb. 2, Abb. 3).
- **Kopfwinkel, fußfreie Erfassung** — den Kopf messen, die Füße befreien (der Brillensensor, Abb. 1).
- **Detektor/Aktuator‑Trennung über Funk** — exakt die heutige Form Smartphone → BLE → Gerät.
- **Zerstörungsfreies, freistehendes Gerät** — es steht eigenständig an den Pedalen; das Klavier wird
  nicht verändert. Der heutige pneumatische **[Airback](../../how-it-works.md)** ist der direkte
  Nachkomme dieses „das Instrument nicht berühren“-Prinzips.
- **Technische Sorgfalt** — sogar eine *schalldichte Kammer* gegen Vibration und saubere
  **Handskizzen**, vor dem CAD ausgearbeitet.

## Was sich änderte — ein riesiger Motor und eine Brille
Die zwei auffälligsten Unterschiede zu heute sind der **Antriebsmotor** und der **Sensor**. bFaaaP 1
bewegte das Pedal mit einem **großen, industrieroboter‑tauglichen Schrittmotor von Oriental Motor
Co., Ltd.** aus einer schweren schalldichten Kammer heraus — und las den Kopf über einen **an einer
Brille getragenen Sensor**. Heute erledigt dieselbe Aufgabe ein **handflächengroßer Closed‑Loop‑Motor**
(vom Airback verankert) — oder **gar kein Motor** beim elektronischen Switch — und ein **Smartphone auf
einem Ständer, ohne dass etwas getragen wird**. Das Kopfwinkel‑Regelgesetz dazwischen änderte sich nie.

![Damals vs. heute: bFaaaP 1 (2018) nutzte einen an der Brille getragenen Kopfsensor und einen GROSSEN industrieroboter-tauglichen Schrittmotor von Oriental Motor Co. in einer schalldichten Kammer; heute ein Smartphone (nichts getragen) und ein kompakter Closed-Loop-Motor — oder gar kein Motor beim Switch](../../../../../docs/history/bfaaap-1-original/then-vs-now-sensor-and-motor.png)

## Die Reaktionskraft verankern — von totem Gewicht zum Airback
Es gab einen zweiten Grund, warum bFaaaP 1 so groß und schwer war: **wie es an Ort und Stelle blieb.**
Ein Pedaldruck erzeugt eine **Reaktionskraft**, die ein leichtes Gerät wegzudrücken versucht; bFaaaP 1
**füllte daher ein Fach im Boden seines Gehäuses mit schwerem Metall** und hielt der Kraft mit reiner Masse stand.
Später erfand das Projekt den **„Airback“**: ein airbagartiges Luftkissen, das sich **gegen ein
Nachbarpedal stemmt** und die Reaktionskraft in die **Struktur des Klaviers selbst** verankert, statt
sie mit Masse zu bekämpfen. Die Kraft an ihrer Quelle abzufangen ist weit effizienter — so konnte das
Gerät **viel kleiner und leichter** werden (der Airback ist zudem zerstörungsfrei und schnell
aufgebaut; siehe [Funktionsweise](../../how-it-works.md)).

![Damals vs. heute: bFaaaP 1 (2018) hielt der Pedal-Reaktionskraft mit schwerem Metall stand, das in ein Fach des schalldichten Kammergehäuses gepackt war, während der Motor oben das Pedal drückte und die Kraft in den Boden verankerte (groß & schwer); heute bläst sich der Airback auf und stemmt sich gegen ein Nachbarpedal, verankert die Kraft im Klavier selbst, sodass das Gerät leicht & klein ist](../../../../../docs/history/bfaaap-1-original/anchoring-weight-vs-airback.png)

## Die Originalzeichnungen

### Abb. 1 — Übersicht, mit dem Brillensensor
**1000** ist der Brillenrahmen; **1100** der daran befestigte Kopfwinkelsensor; **1200** der
Hand‑Controller (Offset‑ & Faktor‑Regler); **100** das schalldichte Kammergerät an den Pedalen. Die
**brillenmontierte Sensoreinheit wurde auch als Design eingetragen (意匠登録).**

![Abb. 1: Brille (1000) mit Kopfwinkelsensor (1100), kleiner Hand-Controller (1200) und kastenförmiges schalldichtes Kammergerät (100) an den Klavierpedalen](../../../../../docs/history/bfaaap-1-original/fig1-overview-glasses-sensor.png)

### Abb. 2 — Systemblockschaltbild (das Regelgesetz von 2018)
Die Detektorseite (Winkelsensor → Datenprozessor → Sender) zeigt bereits **Offset‑Wert** und
**Faktor**; die Aktuatorseite (Empfänger → Controller → Aktuator) zeigt **Pedalspiel‑Offset** und
**Stellbereich**.

![Abb. 2: eine Detektorseite (Winkelsensor, Datenprozessor, Sender, Offset-Wert, Faktor) und eine Aktuatorseite (Empfänger, Aktuator-Controller, Aktuator, Pedalspiel-Offset, Stellbereich)](../../../../../docs/history/bfaaap-1-original/fig2-system-block-diagram.png)

### Abb. 3 — Firmware-Ablauf der Detektorseite
BLE und die **MPU‑9250**‑IMU einrichten, Beschleunigung/Gyro/Geomagnetik lesen, einen
**Madgwick‑Filter** für die Kopfneigung ausführen, **Offset abziehen**, **multiplizieren**, auf
**0–99 begrenzen**, per BLE senden — mit laufendem Neulesen der Offset‑ und Faktor‑Regler.

![Abb. 3: Flussdiagramm S100–S128 — BLE/MPU9250-Setup, Sensorlesen, Madgwick-Filter, Offset abziehen, multiplizieren, auf 0–99 begrenzen, BLE-Senden, Regler lesen](../../../../../docs/history/bfaaap-1-original/fig3-detector-side-flow.png)

### Abb. 5 — Aktuator-Bewegungsfunktion (MOV)
Wie der Controller die Motorbits umschaltete, um das Pedal einen Schritt weiterzubewegen.

![Abb. 5: Flussdiagramm S300–S310 — warten solange beschäftigt, Motorbits Mo0–Mo5 setzen, Verzögerung, Startbit umschalten, warten](../../../../../docs/history/bfaaap-1-original/fig5-actuator-mov-function.png)

## Handgezeichnete Konstruktionsskizzen (der schöne Teil)
Vor dem sauberen CAD wurde die schalldichte Kammer **von Hand** ausgearbeitet (T. Shishido,
2018‑09‑11) — Frontschnitt, Seite, Rückseite und Ober/Mittel/Unteransicht, mit denselben
Teilenummern wie die formalen Abbildungen. Eine schöne Erinnerung daran, dass gute Geräte oft auf
Papier beginnen.

![Handgezeichneter Frontschnitt der schalldichten Kammer](../../../../../docs/history/bfaaap-1-original/handdrawn-front-cross-section.png)

![Handgezeichnete linke Seitenansicht: vordere/hintere Plattenelemente, Schallabsorber, Öffnung](../../../../../docs/history/bfaaap-1-original/handdrawn-left-side-view.png)

![Handgezeichnete Rückansicht des Kammergehäuses](../../../../../docs/history/bfaaap-1-original/handdrawn-rear-view.png)

![Handgezeichnete Ober-, Mittel- und Unteransichten der Kammer](../../../../../docs/history/bfaaap-1-original/handdrawn-top-intermediate-bottom.png)

*Originale Handskizzen © bFaaaP‑Team (T. Shishido).*

---

## Privatsphäre & Daten
Dies sind **nur technische Zeichnungen** — keine Personen, Namen oder personenbezogenen Daten. Die
**APEE‑Studie ist gesondert dokumentiert** und wird hier nicht wiederholt — siehe die
[PCT‑/APEE‑Originalabbildungen](../pct-original-figures/README.md) (mit dem **bFaaaP‑2**‑M5Stack‑Sensor
und den **anonymisierten** APEE‑Abbildungen) und Anhang A des Papers.

## Dateien
- Illustrationen: `bfaaap1-pianist-2018.png` (Gemini), `the-invention-from-the-start.png` (matplotlib).
- Originalabbildungen (PNG): `fig1-overview-glasses-sensor.png`, `fig2-system-block-diagram.png`,
  `fig3-detector-side-flow.png`, `fig5-actuator-mov-function.png` und die vier `handdrawn-*.png`.
- Archiv‑Quell‑PDFs: `source-handdrawn-embodiment-2018.pdf`, `source-configuration-diagram-2018.pdf`.

## Siehe auch
[History](../../HISTORY.md) · [Story](../../story.md) · [Funktionsweise](../../how-it-works.md) ·
[PCT‑/APEE‑Abbildungen](../pct-original-figures/README.md) · [das Paper](../../../../../bfaaap_arxiv_latex/README.md)
