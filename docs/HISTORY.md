# bFaaaP — project history

![Platanus with bFaaaP poster](media/poster_concert_pro_2025.jpg)

*bFaaaP = **b**arrier-**F**ree **a**ssist **a**s **a** **P**edal — an AI assistive
piano‑pedal system. Project site: <https://bfaaap.com>*

## Origin (2018)

bFaaaP started in **January 2018**. A **wheelchair user** — a client of architect
**Masahiro Ootaki** — asked: *"I'd like to motorize the piano's pedal so I can
press it."* Seated at the piano in a wheelchair they could play the keys, but
could not reach the pedals, so the playing lacked expression. That request became
bFaaaP.

The very first prototype, **"bFaaap‑1"** (piano‑pedal trial #1, **2018‑02‑10**),
was a white box weighted with concrete, full of electronics and wiring — "first,
build *something* that moves."

## Early design (bFaaaP1–4)

The early system had two parts, controlled by a microcontroller (Arduino IDE,
M5Stack / ESP32 era; wooden enclosure for bFaaaP4):

- a **head‑mounted motion sensor** — a 9‑axis IMU on an **eyeglass frame**,
  reading the head's fore/aft motion, and
- an **actuator** placed in front of the pedal.

A **PCT international patent** was filed in 2018; the method was later granted in
Japan as **特許第6726319号 / 第7004771号** (the head‑angle **threshold** + press
**speed** scheme).

Public debut: ~2019, at a piano recital of Kyoko Yamaguchi's class "Fleur"
(MUSICASA, Yoyogi‑Uehara).

## Evolution to today

The head‑mounted IMU was replaced by **smartphone AR face tracking** (iOS AI),
sending the head angle over **BLE** to the pedal device (now a Raspberry Pi Pico
+ Adafruit ItsyBitsy nRF52840). Two product lines emerged:

- **Switch** — for electric pianos & keyboards (electronic sustain‑jack switch),
- **Pro** — for acoustic pianos (a motor presses the sustain pedal).

Recent demonstrations:

- **2024** — Kodai festival, Institute of Science Tokyo
  (<https://www.youtube.com/watch?v=Im4jsed1tJQ>)
- **2025** — Platanus Suzukake Concert with bFaaaP
  (<https://www.youtube.com/watch?v=V3cXeNW9jXY>)

## People

Developed by the bFaaaP / **Platanus** members:

- **Tomoyuki Shishido** — iOS app
- **Hiroyuki Narusawa** — pedal device / firmware
- **Masahiro Ootaki** — architect; design & overall coordination
- **Kyoko Yamaguchi**, **Daisuke Tokushige**, and others

> The goal: an **inclusive** design so anyone — people with limb disabilities,
> small children, the elderly — can enjoy playing the piano with a pedal.
