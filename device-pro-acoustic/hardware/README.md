# Hardware — bFaaaP Pro (acoustic)

The mechanical assembly that holds the motor over the piano's pedals, drives the
sustain pedal, and anchors itself against the reaction force.

```
hardware/
├── cad/               FreeCAD source files (.FCStd) — editable design
├── 3d-print/          Ready-to-print meshes (.stl) and slicer projects (.3mf)
├── airback/           Anchoring mechanism (air bag + pump + hand controller)
├── schematic/         Circuit schematic + block/power diagrams (by Taguchi)
├── reference-design/  AI-draft adaptable architecture + mechanical layout (simplified)
├── photos/            Real build photos (airback + drive unit; by Taguchi)
└── enclosure-labels/  Product / enclosure label artwork (review before publishing)
```

> 🧭 **New to the Pro?** Start with the **[`reference-design/`](reference-design/)** —
> an AI-draft, *adaptable* system architecture + mechanical layout that explains how the
> whole device fits together (and what you can simplify or swap).

> 📷 **Build photos** of the airback and drive unit are in
> [`photos/`](photos/) (from the team Discord).

> 📐 **Wiring:** a **single‑sheet KiCad schematic** of the whole Pro device (IQ /
> v039B reference generation) is in [`schematic/`](schematic/), together with the
> system block diagram and the power‑supply options. It gives the authoritative
> **Pico pin map** (BLE UART GP0/GP1; HX711 GP2/GP3; IQ‑motor serial GP4/GP5;
> air‑pump MOSFET GP12; slider potentiometer on **ADC0/GP26**) and the **two power
> rails (+5 V logic, +24 V motor)**.

## Major components

| Component | What it does | Where |
|-----------|--------------|-------|
| **Controller board** | Raspberry Pi Pico (RP2040) + BLE (Nordic UART). Receives `iNN`/`N`/`F` and commands the motor. | [`../firmware/`](../firmware/) |
| **Motor** | **IQ‑FORTIQ‑M42BLS‑100** (100 W) — **current reference (v039B)**; EOL → successor is a **closed‑loop stepper with a DRV8825‑compatible interface** (DRV8825 itself = old standard module, early tests only). | [`../motor/`](../motor/) |
| **Drivetrain** | Motor → **GT-2‑262 timing belt** + **T60 pulleys** → **T10 lead screw** (~150 mm) → push‑rod. Bearings: flanged + thrust + collar. | `cad/`, BOM in [`../assembly/`](../assembly/) |
| **Frame** | **Aluminium extrusion** (4040 / 2040 / 2080) + T‑slot/2020 brackets, with 3D‑printed parts (PLA+). | `cad/`, `3d-print/` |
| **Hand controller** | A small box with a **travel‑limit slide potentiometer ("slide volume")** + pump on/off + switch. The [schematic](schematic/) wires it as a potentiometer (wiper → **ADC0/GP26**) plus a push switch. *(Per the device co‑author: the slide volume is correct; the **RJ45/LAN socket on the body is currently unused** — legacy.)* | [`airback/`](airback/), [`schematic/`](schematic/) |
| **Airback** | A stock **WINBAG air jack** (160 × 150 mm, ≤50 mm, 135 kg) under a neighbouring pedal; inflated by its **manual bulb** or an electric **air pump on GP12** (2SK4017 MOSFET); keeps the unit from moving under the motor's reaction force. | [`airback/`](airback/) |

## Workflow

- Edit the design in **FreeCAD** using the `cad/` sources.
- Export / slice to the meshes in `3d-print/` for printing.
- The `.3mf` files include slicer settings used for reference prints.

## Notes / TODO

- Print material/orientation/supports: document recommended settings.
- Wiring (motor ↔ Pico) and the airback pump/controller schematic: to be added.
- Reconcile CAD ↔ STL revisions and add a per‑part index before publishing.

---
**License (adopted):** the hardware designs (CAD, 3D‑print files, schematic) are released under **CERN‑OHL‑W‑2.0**. Imported schematic/CAD/photos by Taguchi are included **with consent (2026‑06‑18)**. See [`../../LICENSE`](../../LICENSE).
