# Glossar — bFaaaP‑Begriffe, einfach erklärt

> 🌐 [English](../../../docs/GLOSSARY.md) · [日本語](../../ja/docs/GLOSSARY.md) · **Deutsch**

Neu bei Elektronik, 3D‑Druck oder App‑Entwicklung? Hier sind die Begriffe, die dir begegnen, einfach
erklärt. (Weitere Begriffe kommen hinzu, während die Bauanleitungen wachsen.)

## Das große Ganze
- **bFaaaP** — *barrier‑Free assist as a Pedal.* Ein System, das das Haltepedal des Klaviers für dich
  drückt, gesteuert durch eine kleine Kopfbewegung.
- **Haltepedal (Sustain)** — das Klavierpedal (meist rechts), das Töne weiterklingen lässt, nachdem du
  die Finger hebst. bFaaaP bedient dieses Pedal.
- **Pro / Switch** — die zwei Geräte‑Versionen. **Pro** drückt das Pedal eines *akustischen* Klaviers
  mit einem Motor; **Switch** schaltet das Sustain eines *digitalen* Klaviers elektronisch.

## App & Erfassung
- **iOS‑App** — die iPhone/iPad‑App, die deinen Kopf beobachtet und Befehle sendet. Steuert beide Geräte.
- **ARKit / TrueDepth** — Apples Gesichts‑Tracking (die Face‑ID‑Kamera). bFaaaP misst damit den
  **Kopfwinkel**.
- **Kopfwinkel / Schwelle** — wie weit du neigst. Übersteigt die Neigung einen Sollwert (**Schwelle**),
  greift das Pedal ein; du stellst die **Schwelle (Offset)** und den **Faktor** auf dich ein, und beide
  zusammen ergeben die Reaktionsgeschwindigkeit (wie schnell das Pedal dem Kopf folgt).

## Die Verbindung
- **BLE (Bluetooth Low Energy)** — kurzreichweitiger Funk. Das Telefon sendet den Kopfwinkel per BLE
  an das Gerät.
- **Nordic UART Service (NUS)** — ein gängiges BLE‑Profil („serielles Kabel über Bluetooth“), das
  bFaaaP für kleine Textnachrichten nutzt (`i00`–`i99` = 0–99 % Neigung).
- **UART / `Serial1`** — eine einfache kabelgebundene serielle Verbindung. Im Gerät reicht das
  BLE‑Board Bytes an den Pico weiter.

## Das Gerät (Hardware)
- **Raspberry Pi Pico (RP2040)** — der günstige, beliebte Mikrocontroller, der die **Hauptplatine**
  des Geräts ist (steuert Motor, Sensoren, Kalibrierung).
- **nRF52840 (BLE‑Board)** — eine zweite kleine Platine für die Bluetooth‑Seite, die zum Pico überbrückt.
- **Mikrocontroller** — ein winziger Computer auf einem Chip, der **Firmware** ausführt.
- **Firmware** — das Programm, das auf den Boards läuft (als Arduino‑**`.ino`‑Sketches** geschrieben).
- **arduino‑pico (Philhower)‑Core** — das Board‑Support‑Paket, mit dem der Pico Arduino‑Code ausführt.
- **Closed‑Loop‑Motor / IQ‑Fortiq** — der Motor des Pro; „Closed Loop“ heißt, er kennt seine eigene
  Position/Kraft und kann präzise drücken. (Das Original ist abgekündigt — EOL; ein Schrittmotor‑Nachfolger ist geplant.)
- **Airback** — ein **geprägter Begriff** (kein „airbag"): bFaaaPs aufblasbarer, **luftgestützter
  Anker**. Ein Luftkissen bläst sich unter einem Nachbarpedal auf und nimmt die Reaktionskraft des
  Aktuators auf, sodass das Pro‑Gerät auf einem *unveränderten* Klavier fest sitzt — nichts wird
  angeschraubt (zerstörungsfrei, schnell abnehmbar). Der Name ist *air* + *back* (stützen), nicht
  das Sicherheits‑„airbag". → [Wie es funktioniert](how-it-works.md)
- **HX711** — ein winziger Verstärker‑Chip, der den Luftdrucksensor ausliest.
- **MOSFET (2SK4017)** — ein elektronischer Schalter, mit dem der Pico die Luftpumpe ein-/ausschaltet.
- **DIP‑Schalter** — eine Reihe winziger physischer Schalter auf der Platine, um die **Pedaldruckkraft**
  (≈20–35 W) und den Hubweg einzustellen.

## Die Teile herstellen
- **3D‑Druck / STL / Slicer / G‑Code** — die mechanischen Teile werden **3D‑gedruckt**. Du öffnest ein
  **STL**‑Modell in einem **Slicer** (z. B. Bambu Studio, PrusaSlicer), der daraus **G‑Code** macht,
  dem der Drucker folgt.
- **CAD / FreeCAD (`.FCStd`)** — die bearbeitbaren 3D‑Designdateien (öffnen, um ein Teil zu ändern).
- **KiCad / Schaltplan** — der elektronische Verdrahtungsplan (und das Werkzeug, das ihn zeichnet).
- **Stückliste (BOM)** — die Einkaufsliste der Teile.

## Lizenzierung
- **Apache‑2.0 / CERN‑OHL‑W / CC‑BY** — die offenen Lizenzen für die Schichten **Software / Hardware /
  Dokumentation**. Siehe [`LICENSE`](../../../LICENSE).

→ Zurück zu: [Funktionsweise](how-it-works.md) · [Selbst bauen](build/) · [Die Geschichte](story.md)
