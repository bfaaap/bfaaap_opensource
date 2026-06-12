# Hardware — bFaaaP Pro (acoustic)

The mechanical assembly that holds the motor over the piano's pedals, drives the
sustain pedal, and anchors itself against the reaction force.

```
hardware/
├── cad/               FreeCAD source files (.FCStd) — editable design
├── 3d-print/          Ready-to-print meshes (.stl) and slicer projects (.3mf)
├── airback/           Anchoring mechanism (air bag + pump + hand controller)
└── enclosure-labels/  Product / enclosure label artwork (review before publishing)
```

## Major components

| Component | What it does | Where |
|-----------|--------------|-------|
| **Controller board** | Raspberry Pi Pico (RP2040) + BLE (Nordic UART). Receives `iNN`/`N`/`F` and commands the motor. | [`../firmware/`](../firmware/) |
| **Motor** | **IQ‑FORTIQ‑M42BLS‑100** (100 W; EOL → closed‑loop stepper, DRV8825 path). | [`../motor/`](../motor/) |
| **Drivetrain** | Motor → **2GT‑262 timing belt** + **T60 pulleys** → **T10 lead screw** (~150 mm) → push‑rod. Bearings: flanged + thrust + collar. | `cad/`, BOM in [`../assembly/`](../assembly/) |
| **Frame** | **Aluminium extrusion** (4040 / 2040 / 20100) + T‑slot/2020 brackets, with 3D‑printed parts (PLA+). | `cad/`, `3d-print/` |
| **Hand controller** | A small box with the **travel‑limit slide potentiometer** + pump on/off + switches, connected to the body via an **RJ45 / LAN cable**. | [`airback/`](airback/) |
| **Airback** | Inflatable **air jack (119 × 11 cm)** under a neighbouring pedal; **air pump (φ3)** via a **2SK4017 MOSFET**; keeps the unit from moving under the motor's reaction force. | [`airback/`](airback/) |

## Workflow

- Edit the design in **FreeCAD** using the `cad/` sources.
- Export / slice to the meshes in `3d-print/` for printing.
- The `.3mf` files include slicer settings used for reference prints.

## Notes / TODO

- Print material/orientation/supports: document recommended settings.
- Wiring (motor ↔ Pico) and the airback pump/controller schematic: to be added.
- Reconcile CAD ↔ STL revisions and add a per‑part index before publishing.
