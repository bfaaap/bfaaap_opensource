# The bFaaaP Story 🎹

*From one person's wish — to a hands‑free piano pedal that **anyone can build**.*

![A pianist playing, the pedal pressed by a small friendly device](media/illustrations/intl-what-bfaaap.png)

> **bFaaaP** = **b**arrier‑**F**ree **a**ssist **a**s **a** **P**edal — an AI assistive
> piano‑pedal system. Tilt your head a little, and the sustain pedal goes down. No feet
> required. This page tells the story of how it came to be, who built it, and where you
> can *see* and *hear* it. New here? Start with [How it works](how-it-works.md) and the
> [glossary](GLOSSARY.md); ready to make one? jump to [Build it yourself](build/).

---

## 1. It began with a wish (2018)

In **January 2018**, a **wheelchair user** — a client of the architect
**Masahiro Ootaki** — said something simple and profound:

> *"I'd like to motorize the piano's pedal so I can press it."*

Seated at the piano, they could play the keys beautifully — but could not reach the
pedals, and without the pedal the music lost its bloom. That single wish became bFaaaP.

The very first prototype, **"bFaaap‑1"** (*piano‑pedal trial #1*, **10 Feb 2018**), was a
white box weighted with concrete and stuffed with wiring. The philosophy from day one was
the engineer's favourite: *first, build **something** that moves.*

## 2. Glasses, sensors, and a patent (bFaaaP1–4)

The early system had two halves, run by a microcontroller (the Arduino / M5Stack · ESP32
era — bFaaaP4 even wore a hand‑made wooden enclosure):

- a **head‑motion sensor** — a 9‑axis IMU mounted on an **eyeglass frame**, reading the
  gentle fore/aft tilt of the head, and
- an **actuator** sitting in front of the pedal.

The core idea — a head‑angle **threshold** plus a press **speed** — was filed as a **PCT
international patent** in 2018 and later granted in Japan (**特許第6726319号 / 第7004771号**).
bFaaaP made its public debut around **2019** at a recital of Kyoko Yamaguchi's piano class
*"Fleur"* (MUSICASA, Yoyogi‑Uehara).

## 3. The leap to today: a phone, a tilt, a pedal

The glasses‑mounted sensor was replaced by something almost everyone already owns: a
**smartphone**. Apple's **AR face tracking** now reads the head angle and sends it over
**Bluetooth Low Energy** to a small pedal device (a **Raspberry Pi Pico** + **Adafruit
ItsyBitsy nRF52840**). Two product lines grew from this:

![How it works: your intent → face recognition → Bluetooth → controller](media/illustrations/intl-how-it-works.png)

| Line | For | How it presses |
|------|-----|----------------|
| 🎹 **Pro** | **Acoustic** grand & upright pianos | a small **motor** physically presses the sustain pedal (anchored by an *airback* air‑cushion) |
| 🎛️ **Switch** | **Digital** pianos & keyboards | switches the sustain **electronically** through the pedal jack — tiny, no motor |

![Pro for acoustic pianos, Switch for digital pianos](media/illustrations/intl-pro-switch.png)

## 4. The people behind bFaaaP 👋

bFaaaP is built by the **Platanus** group — engineers, musicians, a tuner, a composer, and
IP specialists, brought together by one inclusive idea. *Portraits are the project's own
hand‑drawn caricatures by **Saki Shiokawa (塩川紗季)**.*

| | Who | Role |
|---|-----|------|
| ![Masahiro Ootaki](members/ootaki-masahiro.jpg) | **Masahiro Ootaki** 大瀧雅寛 | First‑class **architect** (barrier‑free housing); bFaaaP's designer & coordinator — and the one whose client's wish started it all. |
| ![Tomoyuki Shishido](members/shishido-tomoyuki.jpg) | **Tomoyuki Shishido** 宍戸知行 | **iOS app.** Ph.D. & patent attorney, now a Ph.D. student at Institute of Science Tokyo; learned Swift to build bFaaaP. Took up piano at 45. |
| ![Hiroyuki Narusawa](members/narusawa-hiroyuki.jpg) | **Hiroyuki Narusawa** 成澤博行 | **Pedal device & firmware.** Runs Naru Science Soft; designs and builds the hardware that does the pressing. |
| ![Kyoko Yamaguchi](members/yamaguchi-kyoko.jpg) | **Kyoko Yamaguchi** 山口恭子 | **Piano & pedagogy.** ~15 years teaching; champions a new, IT‑era pedal technique. |
| ![Daisuke Tokushige](members/tokushige-daisuke.jpg) | **Daisuke Tokushige** 徳重大輔 | **Intellectual property.** Patent engineer supporting bFaaaP's patents. |
| ![kana](members/kana.png) | **kana** | **Piano tuner.** Sees the pedal + finger technique as one phrase — and bFaaaP as that ideal made real. |
| ![Fehmiju Fati](members/member2020.png) | **Fehmiju Fati** | **Composer / computer music.** International awards; studied computer music in Japan; joined KORG sound development. |
| ![Midori](members/midori.png) | **Midori** | **Music & healthcare.** *"bFaaaP may switch on the heart, too."* |
| ![Hiroyoshi Kawaguchi](members/kawaguchi.jpg) | **Hiroyoshi Kawaguchi** 川口洋慶 | **Keyboards & engineering.** Tokyo Tech (System & Control); programming + deep‑learning; piano since age 3. |
| ![Haruto Tanaka](members/tanaka.jpg) | **Haruto Tanaka** 田中遥斗 | **Electrical engineering.** Tokyo Tech; wants to extend Switch beyond the piano. |
| ![Taguchi](members/taguchi.jpg) | **Taguchi** 田口 | **Software engineering.** Deepening bFaaaP know‑how to improve it from user feedback. |

→ Full bios: [`docs/members/`](members/).

## 5. See it — and hear it 🎬

The best way to understand bFaaaP is to watch real performances. Everything is on the
**[YouTube channel](https://www.youtube.com/channel/UCcAvTy1k8rHs2WrEKPx1amg)**; here are the
highlights by category (newest first).

### 🏆 Start here — two marquee performances
- **▶ [2025 Platanus Suzukake Concert with bFaaaP](https://www.youtube.com/watch?v=V3cXeNW9jXY)** · 72:20
  A full concert on a **grand piano (Pro)** — *and* it includes a **device setup
  walkthrough at 25:01–28:32**. The single best video to understand the Pro line.
- **▶ [Platanus with bFaaaP, 2024 Kodai festival (Institute of Science Tokyo)](https://www.youtube.com/watch?v=Im4jsed1tJQ)** · 55:29
  System intro + members + three pieces on an **electric piano (Switch)**, then a hands‑on
  **workshop** (39:21–54:18).

![Platanus with bFaaaP — concert poster](media/poster_concert_pro_2025.jpg)

### 🎹 More concerts & recitals
- **▶ [Suzukake Science Day 2024](https://www.youtube.com/watch?v=B820ctNblJE)** · 35:02
- **▶ [工大祭2023 — bFaaaP Pro](https://www.youtube.com/watch?v=9Sc8G1ESa-g)** · 02:40
- **▶ [bFaaaP Pro at MUSICASA, 2023‑07‑23](https://www.youtube.com/watch?v=S45xN5yFaRo)** · 03:45
- **▶ [Piano recital, 2022‑04‑02 (Pro)](https://www.youtube.com/watch?v=O8X2gEqEU6k)** · 06:55
- **▶ [bFaaaP Performance, MusicFair 2020](https://www.youtube.com/watch?v=6_y9MI1IdTQ)** · 16:06
- **▶ [New bFaaaP6, MusicFair 2020](https://www.youtube.com/watch?v=j1ZIJ53j7NE)** · 06:39
- **▶ [bFaaaP Piano Recital, 23 Mar 2019](https://www.youtube.com/watch?v=EK8Tx5uUcM4)** · 05:16

### 🛠️ Setup & adjustment
- **▶ [bFaaaP Pro setup procedure (2025‑07‑24)](https://www.youtube.com/watch?v=_9YopbCYTmI)** · 06:50 — step‑by‑step **Pro installation**.
- **▶ [Sensor adjustment](https://www.youtube.com/watch?v=t7jpf-Yb7Bw)** · **▶ [Actuator adjustment](https://www.youtube.com/watch?v=V22nsIJJGxI)** · **▶ [Recital preparation](https://www.youtube.com/watch?v=wqaxhvOI-yE)** (2019, early system)

### 📖 Manual
- **▶ [How to use bFaaaP Switch](https://youtu.be/XOVENtBsOp4)** · 03:18 — the official **operating manual** video (connect, channel, on/off, angle threshold).

### 📣 Overview & promotion
- **▶ [A user's voice — Ayano](https://www.youtube.com/watch?v=pYSLIV4H5dg)** · 00:16
- **▶ [bFaaaP Switch at HCR 2021 (Int'l Home Care & Rehab Exhibition)](https://www.youtube.com/watch?v=jYLC7Hreovc)** · 23:17
- **▶ [bFaaaP Switch Promotion](https://www.youtube.com/watch?v=09QJAuZT2us)** · 07:09
- **▶ [bFaaaP Overview, MusicFair 2020](https://www.youtube.com/watch?v=iyRqPa8TLgE)** · 26:43 — a longer how‑it‑works overview.
- **▶ [Earliest demonstration (2018‑11‑16)](https://www.youtube.com/watch?v=5-roDvbRe5c)** · 01:38

### 📢 Announcements
- **▶ [bFaaaP lessons now at two Tokyo piano schools (2026‑01)](https://www.youtube.com/watch?v=xx_nsxWR6J0)** · 04:02
- **▶ [2024 bFaaaP recital](https://www.youtube.com/watch?v=8sVPmwiU-cY)** · 03:37

### 🎼 Related
- **▶ [Piano tuning of a Steinway K132](https://www.youtube.com/watch?v=k60HT7zp5pg)** · 30:27
- **▶ [Sarabande (Handel) — a piece playable *without* bFaaaP](https://www.youtube.com/watch?v=PEsBBFNyKBM)** · 03:21 — a period‑style piece needing no sustain, showing by contrast what bFaaaP adds.

→ Full annotated list: [`docs/videos/`](videos/).

## 6. The mission: music for everyone 💛

![Hands holding a piano with a growing sprout, surrounded by a community](media/illustrations/intl-support.png)

bFaaaP exists so that **anyone** — people with limb disabilities, small children, the
elderly, a player with a tracheostomy — can enjoy the expressive power of the pedal. Today
it's used in concerts and lessons; its benefit has even been measured in a clinical‑style
evaluation.

And now it's **open source**: the app, the firmware, the 3D‑printable parts, and these docs
are all published so others can study, build, and improve it.

- 🔧 **Build your own:** [Build it yourself](build/) — iOS app · Pro · Switch
- 🤖 **Get help building:** [AI‑assisted Support](ai-support.md) — ask in GitHub Discussions
- 💛 **Support the project:** [SUPPORT](../SUPPORT.md)

*Illustrations by Saki Shiokawa and by the bFaaaP project (AI‑assisted). See also the
[project history](HISTORY.md).*
