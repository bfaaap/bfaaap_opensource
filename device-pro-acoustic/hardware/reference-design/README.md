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
4. **Actuation** — a **motor + driver** (with a small **+5 V cooling fan**) sits **beside** a
   **vertical lead screw** and drives it through a **GT-2-262 belt** over **two T60 pulleys**
   (**1:1** — the belt only *offsets* the motor next to the screw, it is not a reduction). The
   screw (**T10**, **lead 16 mm/rev**, 150 mm) runs down the **left side of the 2040 post**; its
   **nut/carriage** drives a **push-rod** that **presses straight down on the sustain pedal**.
5. **Anchoring (airback)** — a **WINBAG air jack** under a *neighbouring* pedal is inflated by a
   small **electric air pump inside the electronics box** (driven from **GP12** via the **2SK4017**
   MOSFET, switched by the panel **PUMP SW**) through an **air tube**, and **holds the reaction
   force** so the unit doesn't slide. (The built device uses the electric pump — **not** the
   WINBAG's hand bulb.) See [`../airback/`](../airback/).
6. **Power** — a single SMPS gives **5 V (logic)** + **24 V (motor)**; **SW1 → VSYS**.

The user controls are a small **panel** with the **upper-limit slide volume** (→ ADC0/GP26) and the
**PUMP SW** (→ the airback pump).

## Mechanical layout

![bFaaaP Pro reference mechanical layout](pro-mechanical-layout.png)

> This layout follows the **device co-author's (H. Narusawa) sketch of the working unit**,
> so it is closer to the real build than a generic guess (the rest of this page stays an
> adaptable reference).

The drive is a **vertical column** on an **aluminium-extrusion frame** standing on a
**non-slip mat** in front of the pedals:

- A **motor + driver** (with a **+5 V cooling fan**) is mounted **beside** the screw near the **top**
  and drives it through a **GT-2-262 belt** over **two T60 pulleys** (**1:1**).
- The **vertical lead screw** (**T10**, **lead 16 mm/rev**, 150 mm) runs down the **left side of the
  2040 post** and carries a **nut/carriage** that travels **down** the frame.
- The **push-rod** is a **2040 extrusion (L = 75 mm)** with a **15 mm PLA** part on top (holds the
  screw **nut**) and a **PLA** part below holding a **hard-rubber tip** (total **115 mm**); it
  **presses straight down on the sustain pedal**.
- A **WINBAG airback** sits at the **base**; the box's **electric pump** inflates it through an
  **air tube** under a neighbouring pedal to **anchor the reaction force**.
- The frame is two extrusions — a **vertical 2040 post (L = 200 mm)** and a **2080 base
  (L = 200 mm)** — plus a **4040** rail (see the [BOM](../../assembly/)).
- Two side enclosures plus a control panel: a **power box (PW)** (5 V + 24 V); an **electronics box**
  holding the **BLE board + Pico + the air-jack pump**; and a **SLIDE VOLUME & PUMP SW** panel.

## What's adaptable (the point of this draft)

| Choice | Simple / adaptable option |
|--------|---------------------------|
| **Motor** | the reference **IQ Fortiq M42BLS** (serial, now EOL) **→ chosen successor (2026-06-26): a closed-loop NEMA17** — MKS SERVO42C/D + a NEMA17, or an integrated closed-loop NEMA17 — **STEP/DIR + serial**, reads load for the force step (see [`HARDWARE-AVAILABILITY.md`](../../HARDWARE-AVAILABILITY.md)) |
| **Airback inflation** | the reference unit uses an **electric pump in the box** (GP12 / 2SK4017, panel PUMP SW) → air tube → WINBAG; the WINBAG's **manual bulb** is a simpler no-electronics alternative |
| **Air-pressure sensor** | **the stepper successor drops it** (Narusawa, 2026-06-26): **no HX711** — the pump simply runs a **fixed 40 s**, and the air **valve is normally closed** (released only when the unit is removed from the piano). HX711 was the IQ-generation option. |
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
| Lead screw + nut | **T10** lead screw, **lead 16 mm/rev**, **150 mm**, vertical + brass nut | [Amazon search](https://www.amazon.com/s?k=T10+lead+screw+8mm) · [AliExpress search](https://www.aliexpress.com/wholesale?SearchText=T10+lead+screw) |
| Belt + pulleys | **GT-2-262** belt + **T60 / T60** pulleys (1:1; 5 mm bore on the motor, 10 mm on the screw) | [Amazon search](https://www.amazon.com/s?k=GT2+belt+pulley+kit) |
| Bearings | flanged + thrust + collar for the screw | [Amazon search](https://www.amazon.com/s?k=lead+screw+bearing+set) |
| Frame | aluminium extrusion **2040 (vertical, L=200) + 2080 (base, L=200) + 4040** + brackets | [Amazon search](https://www.amazon.com/s?k=aluminium+extrusion+2040) |
| Airback | **WINBAG** air jack (full buy links + specs) | [see `../airback/`](../airback/) |
| Air pump (optional) | small **5 V** diaphragm air pump | [Amazon search](https://www.amazon.com/s?k=5V+mini+air+pump+diaphragm) |
| Switching MOSFET | logic-level N-MOSFET (2SK4017 / RU1J002YN) | [Akizuki search](https://akizukidenshi.com/catalog/goods/search.aspx?search=x&keyword=2SK4017) · [ROHM RU1J002YN](https://www.rohm.com/products/transistors/mosfets/standard/ru1j002yn-product) |
| Power | SMPS giving **5 V + 24 V** | [Amazon search](https://www.amazon.com/s?k=24V+5V+dual+output+power+supply) |

> Again: these are **starting points to compare specs**, not a vetted BOM. Cross-check every
> item against the architecture above and the confirmed [`../PARTS-REFERENCE.md`](../PARTS-REFERENCE.md).

---
**Credits:** original drawings by the **bFaaaP project** (AI-assisted draft, CC BY 4.0);
hardware layer **CERN-OHL-W-2.0**. Generators kept in the project's private tooling.
