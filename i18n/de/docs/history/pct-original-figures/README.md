# Historisches Archiv — originale PCT-/APEE-Abbildungen (2018)

> 🌐 [English](../../../../../docs/history/pct-original-figures/README.md) · [日本語](../../../../ja/docs/history/pct-original-figures/README.md) · **Deutsch**

Dies sind **Originalabbildungen von 2018**, erstellt für die erste bFaaaP-Patentfamilie
(PCT **WO 2019/176164**, eingereicht am 12.11.2018) und die Probandenstudie
**Auxiliary Pedal Effect Evaluation (APEE)** (durchgeführt 08.2018–10.2018). Sie werden
hier als **historisches Material** aufbewahrt.

Einige zeigen **frühe Konzepte, die in den heutigen Geräten *nicht* mehr verwendet werden** —
einen M5Stack-basierten Kopfsensor und ein schweres „schallisoliertes Kammer“-Gehäuse —
was den Kontrast zum heutigen, leichten [Pro (Airback)](../../build/pro.md) und
[Switch](../../build/switch.md) zum Teil der Geschichte macht. Die APEE-Abbildungen sind
dagegen weiterhin das empirische Rückgrat des Projekts: Aus ihnen stammen die Werte des
Steuergesetzes (Totzonen-Offset, Multiplikator) und das Ergebnis „so gut wie der eigene Fuß“.
Dieselben Daten liegen dem [arXiv-Paper](../../../../../bfaaap_arxiv_latex/) zugrunde und sind in
[`docs/HISTORY.md`](../../HISTORY.md) und der [Story](../../story.md) zusammengefasst.

### Datenschutz / Anonymisierung

Alle Probandendaten hier sind **anonymisiert**. Teilnehmende erscheinen nur als
**Nr. 1 – Nr. 15** (Klasse III ergänzt eine **nicht identifizierende** Behinderungsangabe wie
„mit Beinbehinderung“). **Es gibt keine Namensspalte und keinen Namen, keine Adresse, kein Foto
und keine Kontaktdaten in irgendeiner Datei.** Die Rohtabelle mit Namen wird bewusst **nicht**
veröffentlicht; hier erscheinen nur die bereits anonymisierten Abbildungen. Die Veröffentlichung
entspricht der Studieneinwilligung (Offenlegung nach der Patentanmeldung erlaubt).

---

## A. Die APEE-Probandenstudie

Das Motiv (do-do-do, re-re-re, mi-mi-mi, 3/4, 4× wiederholt) wurde auf drei Arten aufgenommen —
**ohne Pedal (Muster 0)** und mit zwei bFaaaP-**Pedalmustern** — und der Nachklang als
**Tonschwingungsfläche (TVA)** gemessen (ohne Pedal = 1,00 normiert). 15 Teilnehmende in drei
Klassen; die von ihnen gewählten Parameterbereiche sind das, was das Patent beansprucht und das
Paper berichtet.

**Auf einen Blick — die ganze APEE-Pipeline** (eine moderne Übersichtsgrafik der Schritte, die
die Originalabbildungen unten einzeln dokumentieren):

![APEE-Pipeline-Übersicht](../../../../../bfaaap_arxiv_latex/figures/fig_apee_pipeline.png)

### A1 · Teststück und die zwei Pedalmuster
`apee-01-test-score-and-pedal-patterns.pdf` — PCT Abb. 23/24.
Muster 1 wechselt das Pedal bei jeder Dreiton-Gruppe; Muster 2 hält es über die Gruppen hinweg
(längerer, verbundener Nachklang). Deshalb klingt Muster 2 stärker nach als Muster 1.

![Teststück und Pedalmuster](../../../../../docs/history/pct-original-figures/previews/apee-01-test-score-and-pedal-patterns.png)

### A2 · Berechnung der Nachklang-Punktzahl (TVA-Verhältnis)
`apee-02-tva-ratio-method.pdf` — PCT Abb. 25.
Die Wellenformfläche jeder Aufnahme wird gemessen (Sonic Visualiser → ImageJ). Mit TVA₀ ≡ 1,00 ist
die Punktzahl jedes Musters TVAₙ / TVA₀. Mehr Nachklang → größere Fläche.

![TVA-Verhältnismethode](../../../../../docs/history/pct-original-figures/previews/apee-02-tva-ratio-method.png)

### A3 · Ergebnistabellen (Nachklangeffekt; bFaaaP vs. eigener Fuß)
`apee-03-results-tables.pdf` — relative TVA-Mittelwerte (Muster 0/1/2 = 1,00 / 1,59 / 1,80, alle
*p* < 0,01) und bFaaaP vs. eigener Fuß (kein signifikanter Unterschied, *p* > 0,05).

![APEE-Ergebnistabellen](../../../../../docs/history/pct-original-figures/previews/apee-03-results-tables.png)

### A4 · Daten je Aufnahme — Klasse I (Erwachsene), anonymisiert
`apee-04-classI-subjects-data-anonymized.pdf` — Probanden **Nr. 1–7**, vollständige Tabelle je
Aufnahme (Datum, Alter, Klavier, Gerät, Offset, Multiplikator, TVA Muster 0/1/2, Testnummer).

![Klasse-I-Daten](../../../../../docs/history/pct-original-figures/previews/apee-04-classI-subjects-data-anonymized.png)

### A5 · Daten je Aufnahme — Klasse II (Kinder) & Klasse III, anonymisiert
`apee-05-classII-III-subjects-data-anonymized.pdf` — Probanden **Nr. 8–15**.
Nr. 14 (teilweise Beinbehinderung **und** Tracheotomie) wählte einen kleinen Offset (3–5°) und einen
großen Multiplikator (40–50), sodass eine begrenzte Kopfneigung das ganze Pedal abdeckte — der im
Paper hervorgehobene Fall inklusiver Reichweite.

![Klasse-II/III-Daten](../../../../../docs/history/pct-original-figures/previews/apee-05-classII-III-subjects-data-anonymized.png)

### A6 · Testprotokoll
`apee-06-test-protocol.pdf` — das schrittweise Teilnehmerprotokoll der Studie.

![Testprotokoll](../../../../../docs/history/pct-original-figures/previews/apee-06-test-protocol.png)

### A7 · Kopfneigungswinkel während echter Aufführung
`apee-07-head-tilt-angle-histogram.pdf` — PCT Abb. 26. Die Verteilung der Kopfneigung beim
tatsächlichen Klavierspiel (meist innerhalb ≈ ±5°). Das ist der empirische Grund für einen kleinen
**Offset/eine Totzone**: gewöhnliche Spielbewegung soll das Pedal *nicht* auslösen.

![Kopfneigungs-Histogramm](../../../../../docs/history/pct-original-figures/previews/apee-07-head-tilt-angle-histogram.png)

---

## B. Systemarchitektur (PCT-Form von 2018)

### B1 · System-Blockschaltbild
`system-01-configuration-block-diagram.pdf` — Detektorseite (Winkelsensor → Datenprozessor mit
**Offset** + **Multiplikator** → Sender) und Aktorseite (Empfänger → Aktorsteuerung mit
**freiem Pedalspiel** + **Betätigungsweite** → Aktor). Die Begriffe des Steuergesetzes sind bereits
2018 vorhanden.

![Systemkonfiguration](../../../../../docs/history/pct-original-figures/previews/system-01-configuration-block-diagram.png)

### B2 · Flussdiagramm Detektorseite
`system-02-flowchart-sensor-side.pdf`

![Detektorseiten-Fluss](../../../../../docs/history/pct-original-figures/previews/system-02-flowchart-sensor-side.png)

### B3 · Programmablauf (Detektorseite + Aktorseite)
`system-03-program-flow-detector-actuator.pdf`

![Programmablauf](../../../../../docs/history/pct-original-figures/previews/system-03-program-flow-detector-actuator.png)

---

## C. Frühe Konzepte (abgelöst — von historischem Interesse)

### C1 · Früher M5Stack-Binärwechsel-Kopfsensor (06.2018)
`history-01-early-m5stack-binary-motion-detector.pdf` — der frühe Detektor auf M5Stack-Basis
(Gyroskop), vor dem Wechsel zur Smartphone-ARKit-Gesichtsverfolgung. (Mehrere frühe APEE-Aufnahmen
sind als „bFaaaP2 (M5Stack)“ gekennzeichnet.)

![Früher M5Stack-Detektor](../../../../../docs/history/pct-original-figures/previews/history-01-early-m5stack-binary-motion-detector.png)

### C2 · Frühes „schallisoliertes Kammer“-Gehäusekonzept
`history-02-early-embodiment-soundproof-chamber.pdf` — eine handgezeichnete Ausführung mit
schallisolierter Kammer und Gewichtskammern. Das unterscheidet sich **stark** vom heutigen leichten
Pro, der die Reaktionskraft stattdessen mit einem pneumatischen **Airback** auf einem Nachbarpedal
aufnimmt — ein gutes Beispiel für die Entwicklung des Designs.

![Frühes Schallkammer-Konzept](../../../../../docs/history/pct-original-figures/previews/history-02-early-embodiment-soundproof-chamber.png)

---

*Herkunft:* Die Abbildungen stammen aus der bFaaaP-PCT-Anmeldung (WO 2019/176164) und ihrer
APEE-Studie, vom bFaaaP-Team. Siehe auch [`bfaaap_patent_info/`](../../../../../bfaaap_patent_info/)
für die erteilten Patente und den Prüfungsverlauf. Mehrseitige PDFs (die Probandentabellen und die
Ausführungszeichnungen) sind vollständig enthalten; die Inline-Bilder oben zeigen nur die erste Seite.
Bilder und PDFs verweisen gemeinsam auf den englischen Ordner (`docs/history/pct-original-figures/`).
