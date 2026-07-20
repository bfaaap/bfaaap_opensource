# bFaaaP — Projektgeschichte

> 🌐 [English](../../../docs/HISTORY.md) · [日本語](../../ja/docs/HISTORY.md) · **Deutsch**

![Platanus‑with‑bFaaaP‑Plakat](../../../docs/media/poster_concert_pro_2025.jpg)

*bFaaaP = **b**arrier‑**F**ree **a**ssist **a**s **a** **P**edal — ein KI‑gestütztes System zur
Bedienung des Klavierpedals. Projektseite: <https://bfaaap.com>*

## Ursprung (2018)

bFaaaP begann im **Januar 2018**. Eine **Rollstuhlnutzerin** — Klientin des Architekten
**Masahiro Ootaki** — fragte: *„Ich würde gern das Klavierpedal motorisieren, damit ich es drücken
kann.“* Am Klavier sitzend konnte sie die Tasten spielen, aber die Pedale nicht erreichen, sodass
dem Spiel der Ausdruck fehlte. Aus diesem Wunsch wurde bFaaaP.

Der allererste Prototyp **„bFaaap‑1“** (Klavierpedal‑Versuch #1, **10.02.2018**) war eine weiße,
mit Beton beschwerte Kiste voller Elektronik und Kabel — „erst einmal *irgendetwas* bauen, das sich bewegt“.
Die Originalzeichnungen — der **brillenmontierte Sensor** (eine als Design eingetragene Idee) und die
schalldichte Kammer, mit bereits vorhandenem Regelgesetz — sind, mit Handskizzen, in
[**bFaaaP 1 — wo die Erfindung begann**](history/bfaaap-1-original/README.md) gesammelt.

## Frühes Design (bFaaaP1–4)

Das frühe System bestand aus zwei Teilen, gesteuert von einem Mikrocontroller (Ära Arduino IDE,
M5Stack / ESP32; Holzgehäuse bei bFaaaP4):

- ein **Kopf‑Bewegungssensor** — eine 9‑Achsen‑IMU an einem **Brillengestell**, die die Vor/Zurück‑Bewegung des Kopfes liest, und
- ein **Aktuator** vor dem Pedal.

2018 wurde ein **internationales PCT‑Patent** angemeldet; das Verfahren (Kopfwinkel‑**Offset +
Multiplikator**, die zusammen die **Reaktionsgeschwindigkeit** festlegen) wurde später in Japan als **特許第6726319号 / 第7004771号** erteilt.

Öffentliches Debüt: ~2019 bei einem Klaviervorspiel der Klasse „Fleur“ von Kyoko Yamaguchi
(MUSICASA, Yoyogi‑Uehara).

## Der Weg bis heute

Die brillengestützte IMU wurde durch **Smartphone‑AR‑Gesichts‑Tracking (iOS‑KI)** ersetzt, das den
Kopfwinkel per **BLE** an das Pedalgerät sendet (heute ein Raspberry Pi Pico + Adafruit ItsyBitsy
nRF52840). Zwei Produktlinien entstanden:

- **Switch** — für E‑Pianos & Keyboards (elektronischer Sustain‑Buchsenschalter),
- **Pro** — für akustische Klaviere (ein Motor drückt das Haltepedal).

Aktuelle Vorführungen:

- **2024** — Kodai‑Festival, Institute of Science Tokyo (<https://www.youtube.com/watch?v=Im4jsed1tJQ>)
- **2025** — Platanus Suzukake Concert with bFaaaP (<https://www.youtube.com/watch?v=V3cXeNW9jXY>)

## Menschen

Entwickelt von den bFaaaP‑/**Platanus**‑Mitgliedern:

- **Tomoyuki Shishido** — iOS‑App
- **Hiroyuki Narusawa** — Pedalgerät / Firmware
- **Masahiro Ootaki** — Architekt; Design & Gesamtkoordination
- **Kyoko Yamaguchi**, **Daisuke Tokushige** u. a.

> Das Ziel: ein **inklusives** Design, damit **alle** — Menschen mit Gliedmaßen‑Behinderungen,
> kleine Kinder, ältere Menschen — das Klavier mit Pedal genießen können.
