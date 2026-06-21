# 🎹 Build the **Pro** (acoustic piano)

> 🌐 **English** · [日本語](../../i18n/ja/docs/build/pro.md) · [Deutsch](../../i18n/de/docs/build/pro.md)

Step‑by‑step guide to build the Pro device — a small motor that presses an acoustic piano's
sustain pedal, anchored by an *airback* air‑cushion (nothing is screwed to the piano). New to
the terms? see the [glossary](../GLOSSARY.md). Stuck? [ask in AI‑assisted Support](../ai-support.md).

> 🚧 **Draft.** The structure is in place; some exact pinouts and mechanical dimensions are
> being filled in from the makers (Narusawa / Taguchi). Watch the
> **[Pro setup walkthrough video](https://www.youtube.com/watch?v=_9YopbCYTmI)** to see it for real.

```
 1. Print parts ─▶ 2. Get electronics ─▶ 3. Assemble the drive ─▶ 4. Wire the boards
       ─▶ 5. Flash firmware ─▶ 6. Mount + airback ─▶ 7. Set force & calibrate ─▶ 8. Pair & play
```

![Pro build steps and the repository files each step uses](../media/diagrams/pro-build-flow.png)
<sub>Every step maps to specific repo files — full index in the [source map](../SOURCE-MAP.md).</sub>

![Pro drive mechanism](../media/diagrams/pro-mechanism.png)

## Before you start — what you need
- A **3D printer** (≥240 mm bed helps) + **PLA+** filament
- Soldering iron, hookup wire, basic hand tools
- The **electronics** (see [`PARTS-REFERENCE.md`](../../device-pro-acoustic/hardware/PARTS-REFERENCE.md)):
  Raspberry Pi **Pico**, **nRF52840** BLE board, **IQ‑Fortiq** motor *(or the stepper successor)*,
  **HX711**, **2SK4017** MOSFET, travel‑limit slider, **24 V PSU**
- Frame stock: **aluminium extrusion**, **2GT belt**, **T10 lead screw**, push‑rod
- The **airback** kit (air jack + pump + hand controller)
- An iPhone/iPad with **Face ID** + the [iOS app](ios.md)

## Step 1 — Print the mechanical parts
1. Open the `.stl` / `.3mf` files in [`hardware/3d-print/`](../../device-pro-acoustic/hardware/3d-print/) in a slicer (Bambu Studio, PrusaSlicer, OrcaSlicer…).
2. Use **PLA+**, **0.1–0.2 mm** tolerance; mind orientation (holes unsupported). See the [3D‑print notes](../../device-pro-acoustic/hardware/3d-print/README.md).
3. Print the frame parts, PCB mount, power box, push‑rod, and covers.

## Step 2 — Get the electronics
Order the parts from [`PARTS-REFERENCE.md`](../../device-pro-acoustic/hardware/PARTS-REFERENCE.md).
**Note:** the original IQ/Fortiq motor is **EOL** — check [`HARDWARE-AVAILABILITY.md`](../../device-pro-acoustic/HARDWARE-AVAILABILITY.md) for the closed‑loop‑stepper successor (DRV8825‑compatible).

## Step 3 — Assemble the drive unit
1. Build the frame from the extrusion.
2. Fit the **motor → 2GT belt → T10 lead‑screw → push‑rod** so the rod travels onto the pedal.
3. Mount the boards on the printed PCB holder.

![Drive unit + airback components](../../device-pro-acoustic/hardware/photos/pro_components_airback_and_drive.jpg)

## Step 4 — Wire the boards
Follow the schematic in [`hardware/schematic/`](../../device-pro-acoustic/hardware/schematic/).
Key connections (reference v039B):
- Motor serial → Pico **GP4 / GP5**
- **HX711** air‑pressure → **GP2 / GP3**; air pump on +5 V via **MOSFET → GP12**
- Travel‑limit slider → **ADC0 / GP26**; **DIP switch** for force/lift
- BLE board ↔ Pico over **UART (`Serial1`)**, common ground; **24 V** to the motor

![I/O panel](../../device-pro-acoustic/hardware/photos/pro_io_panel.jpg)
![Power connector](../../device-pro-acoustic/hardware/photos/pro_power_connector.jpg)

> 🚧 *Exact pin/connector table is being confirmed with the makers — see
> [`DISCORD-FINDINGS.md`](../../device-pro-acoustic/DISCORD-FINDINGS.md) for confirmed details.*

## Step 5 — Flash the firmware
Flash **two boards** (full steps in [`docs/toolchain/`](../toolchain/)):
- **BLE board (nRF52):** install the Adafruit nRF52 support, double‑tap RESET, upload the BLE sketch.
- **Main board (Pico):** install the **arduino‑pico (Philhower)** core + HX711 + IQ library, hold **BOOTSEL**, upload **`bFaaaP_autopro_pico_v039B_…ino`** *(do **not** use the `v052B` stepper snapshot)*.

## Step 6 — Mount on the piano + airback
1. Place the drive so the push‑rod sits over the sustain pedal.
2. Anchor with the **airback**: inflate the air jack against a neighbouring pedal to absorb the reaction force — nothing touches the piano's finish. See [`hardware/airback/`](../../device-pro-acoustic/hardware/airback/).

![Airback air valve](../../device-pro-acoustic/hardware/photos/airback_air_valve.jpg)

## Step 7 — Set the pressing force & calibrate
- Set the **DIP switch** for pressing force **20–35 W** (1 W steps) and lift distance **5–20 mm**. Start in the low‑20s W and raise until the note sounds reliably (force is **power‑based**, piano‑dependent).
- Run the self‑calibration; watch the **Serial Monitor @ 115200**. A safety cap stops travel beyond ~50 mm.

## Step 8 — Pair the app & play
Build/install the [iOS app](ios.md), pair over Bluetooth, set your **threshold** & **speed**, calibrate the head‑angle zero — and play. See [`docs/operation/`](../operation/).

## Mechanical BOM & CAD reference

The full reconstructed BOM (with prices, off‑the‑shelf parts) is in
[`assembly/README.md`](../../device-pro-acoustic/assembly/README.md). Below are the **3D‑printed
parts** with dimensions **measured from the CAD (BREP)** and the **editable source file** for each,
so you can print or modify any part.

> 🚧 The **final variant** of each part and the **fastener list** are being confirmed with the
> hardware author (H. Narusawa); the files below are the latest from the Discord CAD set.

| Printed part | Size (mm, L×W×H) | Editable CAD — `device-pro-acoustic/hardware/cad/from-discord-2025/` |
|---|---|---|
| New housing **AA** | 135×120×62 | `bFaaaP_AA.FCStd` (STL: `3d-print/from-discord-2025/bFaaaP_AA-A.stl`) |
| New housing **CC / DD** | 250×100×60 / 250×100×10 | STL `bFaaaP_CC-CC.stl` / `bFaaaP_DD-DD.stl` *(needs a large printer)* |
| Base + airjack | 292×124×50 | `bfaaap_base_plus_airjack2.FCStd` |
| Base + holder (osae) | 260×121×55 | `bfaaap_base_plus_osae_d.FCStd` |
| Air box | 200×125×35 | `bfaaap_airbox_a_2.FCStd` *(variants a/a‑1/a‑2/c exist)* |
| Slider (travel limit) | 243×132×25 | `bfaaap_slide2_20241028.FCStd` |
| DIP‑switch box | 60×30×6 | `bfaaap_dipsw_box_top_bot.FCStd` |
| Hand‑controller knobs | 50×50×10 / 50×50×20 | `bfaaap_nob_a.FCStd` / `bfaaap_nob_b.FCStd` |
| Push‑rod | (see CAD) | `bfaaap_push_poll.FCStd` |
| **Drive assembly (reference layout)** | 530×290×216 | `bfaaap_belt_gotai14.FCStd` |

Off‑the‑shelf mechanical parts (IQ motor, **T10 lead screw ~150 mm**, **2GT‑262 belt**, **T60
pulleys** 5/10 mm bore, bearings, **4040 / 2040 / 20100** aluminium extrusion, **air jack 119×11 cm**,
φ3 pump): see the [assembly BOM](../../device-pro-acoustic/assembly/README.md). For the full
file ↔ topic index, see the [**source map**](../SOURCE-MAP.md).

---
→ [Build hub](README.md) · [iOS build](ios.md) · [Switch build](switch.md) · [How it works](../how-it-works.md) · [Source map](../SOURCE-MAP.md)
