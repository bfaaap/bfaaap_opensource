# Pro — reference design (AI draft, adaptable)

> ⚠️ **AI DRAFT.** This is a **simplified, adaptable reference architecture** drawn by
> the bFaaaP project from the device's known internals — a clean starting point, **not**
> the exact shipped build. For the real, verified one-working-example see the
> [`../schematic/`](../schematic/) (KiCad), [`../PARTS-REFERENCE.md`](../PARTS-REFERENCE.md)
> (BOM), and [`../photos/`](../photos/). Use this to understand the system and to design
> your own variant.

## System architecture

![bFaaaP Pro reference system architecture](pro-architecture.png)

The Pro is six cooperating subsystems:

1. **Control (iOS)** — the iPhone/iPad reads the player's **head angle** (Face ID / ARKit)
   and applies the **control law** (per-user **offset × multiplier** preset) to produce a
   single **0–99** target. → Bluetooth.
2. **Comms bridge** — an **nRF52840 BLE board** (Akizuki **AE-NRF52840**) receives the
   value over the Nordic UART Service and forwards **one byte** to the main board over a
   wired **UART (GP0/GP1)**.
3. **Controller** — a **Raspberry Pi Pico (RP2040)** runs the **position + force loop**:
   target in, **upper-limit slider** on **ADC0/GP26**, motor out, **force feedback** from
   the motor's own power/current.
4. **Actuation** — a **motor + driver** turns a **lead screw** (via a **2GT belt** +
   pulleys); the screw's **nut/carriage** drives a **push-rod** that **presses the sustain
   pedal**.
5. **Anchoring (airback)** — a **WINBAG air jack** under a *neighbouring* pedal is inflated
   (electric pump on **GP12**, or its **manual bulb**) and **holds the reaction force** so
   the unit doesn't slide. See [`../airback/`](../airback/).
6. **Power** — a single SMPS gives **5 V (logic)** + **24 V (motor)**; **SW1 → VSYS**.

## Mechanical layout

![bFaaaP Pro reference mechanical layout](pro-mechanical-layout.png)

The drive unit sits on an **aluminium-extrusion frame** on a **non-slip mat** in front of
the pedals: motor → belt → **lead screw (T10)** → carriage → **push-rod** → sustain pedal,
with the **electronics box** (Pico + BLE + PSU) on the frame and the **WINBAG airback**
tucked under a neighbouring pedal.

## What's adaptable (the point of this draft)

| Choice | Simple / adaptable option |
|--------|---------------------------|
| **Motor** | the reference **IQ Fortiq M42BLS** (serial, now EOL) **or** any **closed-loop stepper** with a DRV8825-style **STEP/DIR** interface — the Pico loop is the same |
| **Airback inflation** | the WINBAG's **manual bulb** (simplest, no electronics) **or** an electric **air pump on GP12** for one-button inflate |
| **Air-pressure sensor** | **optional** (HX711 on GP2/GP3) — nice for closed-loop airback, not required |
| **Frame** | any rigid base that holds the screw axis and resists the push reaction (extrusion is convenient) |
| **Pedal coupling** | a push-rod onto the sustain pedal; shape it to your piano |

**Minimum build:** iPhone + AE-NRF52840 + Pico + a motor & driver + lead-screw actuator +
a WINBAG (hand-inflated) + a 5 V/24 V supply. Everything else is an enhancement.

## Enclosure / housing

The Pro "housing" is **not** one printed box (unlike the [Switch](../../../device-switch-electronic/assembly/)).
It's the **extrusion frame** (buy + cut) plus a few **3D-printed parts**: a **motor mount**,
**lead-screw bearing blocks**, a **push-rod guide**, and an **electronics box** (Pico + BLE +
PSU). The electronics box is motor-independent and can be drafted like the Switch case; the
**mounts are motor-dependent**, so they are best finalised once you pick the motor
(IQ vs stepper). Ask in [Discussions](https://github.com/TomoShishido/bfaaap_opensource/discussions)
and we can draft the printable parts for your choice.

---
**Credits:** original drawings by the **bFaaaP project** (AI-assisted draft, CC BY 4.0);
hardware layer **CERN-OHL-W-2.0**. Generators kept in the project's private tooling.
