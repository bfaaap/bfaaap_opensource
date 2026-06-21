# 🎹 Build the **Pro** (acoustic piano)

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

---
→ [Build hub](README.md) · [iOS build](ios.md) · [Switch build](switch.md) · [How it works](../how-it-works.md)
