# Die bFaaaP‑Geschichte 🎹

> 🌐 [English](../../../docs/story.md) · [日本語](../../ja/docs/story.md) · **Deutsch**

*Von einem Wunsch — zu einem freihändigen Klavierpedal, das jede und jeder bauen kann.*

![Eine spielende Person, der ein kleines freundliches Gerät das Pedal drückt](../../../docs/media/illustrations/intl-what-bfaaap.png)

> **bFaaaP** = **b**arrier‑**F**ree **a**ssist **a**s **a** **P**edal — ein KI‑gestütztes assistives
> Klavierpedal‑System. Neige den Kopf ein wenig, und das Haltepedal senkt sich. Keine Füße nötig.
> Diese Seite erzählt, wie es entstand, wer es gebaut hat und wo du es *sehen* und *hören* kannst.
> Neu? Beginne mit [Funktionsweise](how-it-works.md) und [Glossar](GLOSSARY.md); bereit zum Bauen?
> Springe zu [Selbst bauen](build/).

---

## 1. Es begann mit einem Wunsch (2018)

Im **Januar 2018** sagte eine **Rollstuhlnutzerin** — eine Klientin des Architekten
**Masahiro Ootaki** — etwas Einfaches und Tiefgründiges:

> *„Ich würde gern das Klavierpedal motorisieren, damit ich es drücken kann.“*

Am Klavier sitzend konnte sie die Tasten wunderbar spielen — aber die Pedale nicht erreichen, und
ohne Pedal verlor die Musik ihre Blüte. Aus diesem Wunsch wurde bFaaaP.

Der allererste Prototyp **„bFaaap‑1“** (*Klavierpedal‑Versuch #1*, **10. Feb. 2018**) war eine weiße,
mit Beton beschwerte Kiste voller Kabel. Das Motto von Tag eins war das Lieblingsmotto der
Ingenieure: *erst einmal **irgendetwas** bauen, das sich bewegt.*

## 2. Brille, Sensoren und ein Patent (bFaaaP1–4)

Das frühe System bestand aus zwei Hälften, gesteuert von einem Mikrocontroller (Ära Arduino /
M5Stack · ESP32 — bFaaaP4 trug sogar ein handgemachtes Holzgehäuse):

- ein **Kopf‑Bewegungssensor** — eine 9‑Achsen‑IMU an einem **Brillengestell**, die die sanfte
  Vor/Zurück‑Neigung des Kopfes liest, und
- ein **Aktuator** vor dem Pedal.

Die Kernidee — eine Kopfwinkel‑**Schwelle** plus eine Druck‑**Geschwindigkeit** — wurde 2018 als
**internationales PCT‑Patent** angemeldet und später in Japan erteilt (**特許第6726319号 / 第7004771号**).
Das öffentliche Debüt war um **2019** bei einem Vorspiel der Klavierklasse „Fleur“ von Kyoko Yamaguchi
(MUSICASA, Yoyogi‑Uehara).

## 3. Der Sprung zu heute: ein Telefon, eine Neigung, ein Pedal

Der brillengestützte Sensor wurde durch etwas ersetzt, das fast alle schon besitzen: ein
**Smartphone**. Apples **AR‑Gesichts‑Tracking** liest nun den Kopfwinkel und sendet ihn per
**Bluetooth Low Energy** an ein kleines Pedalgerät (einen **Raspberry Pi Pico** + **Adafruit ItsyBitsy
nRF52840**). Daraus wuchsen zwei Produktlinien:

![Funktionsweise: deine Absicht → Gesichtserkennung → Bluetooth → Controller](../../../docs/media/illustrations/intl-how-it-works.png)

| Linie | Für | Wie es drückt |
|------|-----|---------------|
| 🎹 **Pro** | **akustische** Flügel & Pianinos | ein kleiner **Motor** drückt das Haltepedal physisch (fixiert durch ein *Airback*) |
| 🎛️ **Switch** | **digitale** Klaviere & Keyboards | schaltet das Sustain **elektronisch** über die Pedalbuchse — winzig, ohne Motor |

![Pro für akustische, Switch für digitale Klaviere](../../../docs/media/illustrations/intl-pro-switch.png)

## 4. Die Menschen hinter bFaaaP 👋

bFaaaP wird von der **Platanus**‑Gruppe gebaut — Ingenieure, Musikerinnen, eine Klavierstimmerin, ein
Komponist und IP‑Fachleute, zusammengebracht von einer inklusiven Idee. *Die Porträts sind die
projekteigenen Karikaturen von **Saki Shiokawa**.*

| | Wer | Rolle |
|---|-----|-------|
| ![Masahiro Ootaki](../../../docs/members/ootaki-masahiro.jpg) | **大瀧 雅寛 / Masahiro Ootaki** | Geprüfter **Architekt** (barrierefreies Wohnen); Designer & Koordinator von bFaaaP — und derjenige, dessen Klientin den Anstoß gab. |
| ![Tomoyuki Shishido](../../../docs/members/shishido-tomoyuki.jpg) | **宍戸 知行 / Tomoyuki Shishido** | **iOS‑App.** Promoviert & Patentanwalt, derzeit Doktorand am Institute of Science Tokyo; lernte Swift, um bFaaaP zu bauen. Begann mit 45 Klavier. |
| ![Hiroyuki Narusawa](../../../docs/members/narusawa-hiroyuki.jpg) | **成澤 博行 / Hiroyuki Narusawa** | **Pedalgerät & Firmware.** Betreibt Naru Science Soft; entwirft und baut die Hardware, die drückt. |
| ![Kyoko Yamaguchi](../../../docs/members/yamaguchi-kyoko.jpg) | **山口 恭子 / Kyoko Yamaguchi** | **Klavier & Pädagogik.** ~15 Jahre Unterricht; setzt sich für eine neue Pedaltechnik im IT‑Zeitalter ein. |
| ![Daisuke Tokushige](../../../docs/members/tokushige-daisuke.jpg) | **徳重 大輔 / Daisuke Tokushige** | **Geistiges Eigentum.** Patentingenieur, der die Patente von bFaaaP betreut. |
| ![kana](../../../docs/members/kana.png) | **kana** | **Klavierstimmerin.** Sieht Pedal‑ und Fingertechnik als eine Phrase — und bFaaaP als dieses Ideal verwirklicht. |
| ![Fehmiju Fati](../../../docs/members/member2020.png) | **Fehmiju Fati** | **Komposition / Computermusik.** Internationale Auszeichnungen; studierte Computermusik in Japan; ging zur Sounddatenentwicklung bei KORG. |
| ![Midori](../../../docs/members/midori.png) | **Midori** | **Musik & Gesundheitswesen.** *„bFaaaP schaltet vielleicht auch das Herz ein.“* |
| ![Hiroyoshi Kawaguchi](../../../docs/members/kawaguchi.jpg) | **川口 洋慶 / Hiroyoshi Kawaguchi** | **Keyboards & Engineering.** Institute of Science Tokyo (System & Control); Programmierung + Deep Learning; Klavier seit dem 3. Lebensjahr. |
| ![Haruto Tanaka](../../../docs/members/tanaka.jpg) | **田中 遥斗 / Haruto Tanaka** | **Elektrotechnik.** Institute of Science Tokyo; möchte den Switch über das Klavier hinaus erweitern. |
| ![Taguchi](../../../docs/members/taguchi.jpg) | **田口 / Taguchi** | **Software‑Engineering.** Vertieft das bFaaaP‑Wissen, um es aus Nutzer‑Feedback zu verbessern. |

→ Vollständige Biografien: [`docs/members/`](../../../docs/members/).

## 5. Sehen — und hören 🎬

Der beste Weg, bFaaaP zu verstehen, ist, echte Aufführungen anzusehen. Alles ist auf dem
**[YouTube‑Kanal](https://www.youtube.com/channel/UCcAvTy1k8rHs2WrEKPx1amg)**; hier die Höhepunkte nach
Kategorie (neueste zuerst).

### 🏆 Zuerst — zwei herausragende Aufführungen
- **▶ [Platanus Suzukake Concert with bFaaaP 2025](https://www.youtube.com/watch?v=V3cXeNW9jXY)** · 72:20
  Ein ganzes Konzert auf einem **Flügel (Pro)** — *inkl. Einrichtungs‑Walkthrough ab 25:01–28:32*. Das beste Einzelvideo zum Pro.
- **▶ [Platanus with bFaaaP, Kodai‑Festival 2024 (Institute of Science Tokyo)](https://www.youtube.com/watch?v=Im4jsed1tJQ)** · 55:29
  Systemvorstellung + Mitglieder + drei Stücke auf einem **E‑Piano (Switch)**, dann ein praktischer **Workshop** (39:21–54:18).

![Platanus with bFaaaP — Konzertplakat](../../../docs/media/poster_concert_pro_2025.jpg)

### 🎹 Weitere Konzerte
- **▶ [Suzukake Science Day 2024](https://www.youtube.com/watch?v=B820ctNblJE)** · 35:02
- **▶ [Kodai‑Festival 2023 — bFaaaP Pro](https://www.youtube.com/watch?v=9Sc8G1ESa-g)** · 02:40
- **▶ [bFaaaP Pro @ MUSICASA, 23.07.2023](https://www.youtube.com/watch?v=S45xN5yFaRo)** · 03:45
- **▶ [Klaviervorspiel 02.04.2022 (Pro)](https://www.youtube.com/watch?v=O8X2gEqEU6k)** · 06:55
- **▶ [bFaaaP Performance, MusicFair 2020](https://www.youtube.com/watch?v=6_y9MI1IdTQ)** · 16:06
- **▶ [New bFaaaP6, MusicFair 2020](https://www.youtube.com/watch?v=j1ZIJ53j7NE)** · 06:39
- **▶ [bFaaaP Klavierrecital, 23.03.2019](https://www.youtube.com/watch?v=EK8Tx5uUcM4)** · 05:16

### 🛠️ Einrichtung & Justierung
- **▶ [bFaaaP Pro Einrichtung (24.07.2025)](https://www.youtube.com/watch?v=_9YopbCYTmI)** · 06:50 — Schritt für Schritt zur **Pro‑Installation**.
- **▶ [Sensor‑Justierung](https://www.youtube.com/watch?v=t7jpf-Yb7Bw)** · **▶ [Aktuator‑Justierung](https://www.youtube.com/watch?v=V22nsIJJGxI)** · **▶ [Recital‑Vorbereitung](https://www.youtube.com/watch?v=wqaxhvOI-yE)** (2019, frühes System)

### 📖 Handbuch
- **▶ [So benutzt du den bFaaaP Switch](https://youtu.be/XOVENtBsOp4)** · 03:18 — das offizielle **Bedienungs‑Video**.

### 📣 Überblick & Promotion
- **▶ [Eine Nutzerstimme — Ayano](https://www.youtube.com/watch?v=pYSLIV4H5dg)** · 00:16
- **▶ [bFaaaP Switch auf der HCR 2021](https://www.youtube.com/watch?v=jYLC7Hreovc)** · 23:17
- **▶ [bFaaaP Switch Promotion](https://www.youtube.com/watch?v=09QJAuZT2us)** · 07:09
- **▶ [bFaaaP Overview, MusicFair 2020](https://www.youtube.com/watch?v=iyRqPa8TLgE)** · 26:43 — längerer Überblick.
- **▶ [Früheste Demonstration (16.11.2018)](https://www.youtube.com/watch?v=5-roDvbRe5c)** · 01:38

### 📢 Ankündigungen
- **▶ [bFaaaP‑Unterricht jetzt an zwei Tokioter Klavierschulen (01/2026)](https://www.youtube.com/watch?v=xx_nsxWR6J0)** · 04:02
- **▶ [bFaaaP‑Vorspiel 2024](https://www.youtube.com/watch?v=8sVPmwiU-cY)** · 03:37

### 🎼 Verwandtes
- **▶ [Klavierstimmung eines Steinway K132](https://www.youtube.com/watch?v=k60HT7zp5pg)** · 30:27
- **▶ [Sarabande (Händel) — ein Stück, das *ohne* bFaaaP spielbar ist](https://www.youtube.com/watch?v=PEsBBFNyKBM)** · 03:21 — zeigt im Kontrast, was bFaaaP hinzufügt.

→ Vollständige kommentierte Liste: [`docs/videos/`](../../../docs/videos/).

## 6. Die Mission: Musik für alle 💛

![Hände halten ein Klavier mit einem wachsenden Spross, umgeben von einer Gemeinschaft](../../../docs/media/illustrations/intl-support.png)

bFaaaP gibt es, damit **alle** — Menschen mit Gliedmaßen‑Behinderungen, kleine Kinder, ältere
Menschen, jemand mit einem Tracheostoma — die Ausdruckskraft des Pedals genießen können. Heute wird
es in Konzerten und im Unterricht genutzt; sein Nutzen wurde sogar in einer klinischen Evaluierung gemessen.

Und nun ist es **Open Source**: die App, die Firmware, die 3D‑druckbaren Teile und diese Doku sind
veröffentlicht, damit andere lernen, bauen und verbessern können.

- 🔧 **Selber bauen:** [Selbst bauen](build/) — iOS‑App · Pro · Switch
- 🤖 **Hilfe beim Bauen:** [KI‑gestützter Support](ai-support.md) — frag in den GitHub Discussions
- 💛 **Das Projekt unterstützen:** [SUPPORT](../SUPPORT.md)

*Illustrationen von Saki Shiokawa und dem bFaaaP‑Projekt (KI‑gestützt). Siehe auch die
[Projektgeschichte](../../../docs/HISTORY.md).*
