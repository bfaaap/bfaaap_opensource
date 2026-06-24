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
It's the **extrusion frame** (buy + cut) plus a few **3D-printed parts**.

**Electronics box (provided — AI draft):** a simple, adaptable 2-part case for the Pico +
nRF52840 BLE board + MOSFET/terminals, with cable U-notches (power, motor, hand controller),
two USB slots for flashing, four board standoffs and a screw-down lid:

- [`pro-ebox.scad`](pro-ebox.scad) — **parametric source** (edit the sizes, export STL)
- [`pro-ebox-base.stl`](pro-ebox-base.stl) · [`pro-ebox-lid.stl`](pro-ebox-lid.stl) — watertight, ready to slice (≈100 × 78 × 38 mm)

**Motor-dependent parts (not here):** the **motor mount**, **lead-screw bearing blocks** and
**push-rod guide** depend on the motor/screw you choose, so they're best finalised once you
pick the motor (IQ vs stepper). Ask in
[Discussions](https://github.com/TomoShishido/bfaaap_opensource/discussions) and we can draft
them for your build.

## Suggested parts — examples only (AI-suggested, not endorsed)

> ⚠️ **Read this first.** The links below are **examples the AI lists as *possibilities*** so
> you can open them and **check the spec / size / form factor** yourself. They are **NOT
> recommendations, endorsements, or guarantees** — neither the bFaaaP project nor the AI
> verifies the sellers, prices, quality, or that any item actually fits your build. **You are
> responsible for confirming voltage, current, dimensions and compatibility before buying.**
> Most are **search links** (so they keep showing current options); availability varies by region.

| Subsystem | What to look for | Example links (examples only) |
|-----------|------------------|-------------------------------|
| Controller | **Raspberry Pi Pico** (RP2040) | [raspberrypi.com](https://www.raspberrypi.com/products/raspberry-pi-pico/) · [Amazon search](https://www.amazon.com/s?k=raspberry+pi+pico) |
| BLE board | **Akizuki AE-NRF52840** / Adafruit Feather nRF52840 | [akizukidenshi](https://akizukidenshi.com/catalog/g/g117484/) · [adafruit 4062](https://www.adafruit.com/product/4062) |
| Motor (option A) | IQ Fortiq M42BLS (serial) — **EOL** | [Crowd Supply](https://www.crowdsupply.com/iq-motion-control/iq-fortiq-bls42) |
| Motor (option B) | **closed-loop stepper**, STEP/DIR (e.g. NEMA17 + driver, or MKS SERVO42) | [AliExpress search](https://www.aliexpress.com/wholesale?SearchText=nema17+closed+loop+stepper) · [Amazon search](https://www.amazon.com/s?k=closed+loop+stepper+nema17) |
| Lead screw + nut | **T10** lead screw (~150–300 mm) + brass nut | [Amazon search](https://www.amazon.com/s?k=T10+lead+screw+8mm) · [AliExpress search](https://www.aliexpress.com/wholesale?SearchText=T10+lead+screw) |
| Belt + pulleys | **GT2 (2GT)** belt + 20T / 60T pulleys | [Amazon search](https://www.amazon.com/s?k=GT2+belt+pulley+kit) |
| Bearings | flanged + thrust + collar for the screw | [Amazon search](https://www.amazon.com/s?k=lead+screw+bearing+set) |
| Frame | aluminium extrusion **4040 / 2040** + brackets | [Amazon search](https://www.amazon.com/s?k=aluminium+extrusion+4040) |
| Airback | **WINBAG** air jack (full buy links + specs) | [see `../airback/`](../airback/) |
| Air pump (optional) | small **5 V** diaphragm air pump | [Amazon search](https://www.amazon.com/s?k=5V+mini+air+pump+diaphragm) |
| Switching MOSFET | logic-level N-MOSFET (2SK4017 / RU1J002YN) | [Akizuki search](https://akizukidenshi.com/catalog/goods/search.aspx?search=x&keyword=2SK4017) · [ROHM RU1J002YN](https://www.rohm.com/products/transistors/mosfets/standard/ru1j002yn-product) |
| Power | SMPS giving **5 V + 24 V** | [Amazon search](https://www.amazon.com/s?k=24V+5V+dual+output+power+supply) |

> Again: these are **starting points to compare specs**, not a vetted BOM. Cross-check every
> item against the architecture above and the confirmed [`../PARTS-REFERENCE.md`](../PARTS-REFERENCE.md).

---
**Credits:** original drawings by the **bFaaaP project** (AI-assisted draft, CC BY 4.0);
hardware layer **CERN-OHL-W-2.0**. Generators kept in the project's private tooling.
