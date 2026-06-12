# Airback — anchoring mechanism

> 日本語・ドイツ語版は後日 `i18n/` 配下に追加予定（English first）.
> Detailed drawings and parts will be added later.

## Why it exists

When the motor presses the sustain pedal, that force pushes **back** on the
whole device (Newton's third law). Without anchoring, the unit would slide or
lift instead of pressing the pedal cleanly. The **airback** absorbs this
reaction force and locks the device in place.

## How it works

1. An inflatable **air bag (airback)** is placed **under one of the other
   pedals** (e.g. the soft / una‑corda pedal).
2. After powering the device on, the user **manually runs an air pump** to
   inflate the bag.
3. The inflating bag pushes **up against the underside of that pedal**, which in
   turn presses the device's anchor down and clamps the whole unit so it cannot
   move while the sustain pedal is being driven.

In short: the airback turns a neighbouring pedal into a fixed anchor point, so
all of the motor's force goes into the sustain pedal and none into moving the
device.

## Control

The air pump is operated by a small **hand controller** with:

- an **on/off** control for the air pump (inflate), and
- a **slider** that sets the **upper end‑stop (top position) of the driven
  part** (how far the pedal mechanism travels).

**Physical realization (from device photos):** the air jack is a **blue
inflatable bag** placed on a **non‑slip rubber mat**, connected by a tube to a
**quick‑connect air fitting** on the body's I/O panel (which also carries a
**toggle switch** and an **RJ45 jack** for the hand controller). The hand
controller is a 3D‑printed hand‑held unit (~13–15 cm) with the slide
potentiometer and a button, wired to the body through an **RJ45 / LAN cable**.

## Status

This is an overview based on the current design. **Detailed materials,
dimensions, the pump/controller schematic, and assembly photos will be added
later.** Treat this page as the concept; the specifics are TODO.
