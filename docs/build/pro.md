# 🎹 Build the **Pro** (acoustic piano)

> 🌐 **English** · [日本語](../../i18n/ja/docs/build/pro.md) · [Deutsch](../../i18n/de/docs/build/pro.md)

Step‑by‑step guide to build the Pro device — a small motor that presses an acoustic piano's
sustain pedal, anchored by an *airback* air‑cushion (nothing is screwed to the piano). New to
the terms? see the [glossary](../GLOSSARY.md). Stuck? [ask in AI‑assisted Support](../ai-support.md).

![A pianist plays a grand piano foot‑free: a phone on the music stand reads their head tilt while a small device and air cushion press the sustain pedal](../media/illustrations/pro-play-hero.png)
<sub>What you're building toward: foot‑free pedalling on an unmodified grand. Illustration: AI‑generated (Saki Shiokawa style) © Shishido &amp; Associates.</sub>

> 🚧 **Draft.** The **electrical schematic** (Taguchi) and the **mechanical layout** (H. Narusawa's
> build sketch) are now confirmed and reflected below; what's still being finalised is the exact
> **stepper successor's buildable firmware** (the planned motor is a same‑size **NEMA17**, STEP/DIR; the original is EOL) and the **final printed‑part variant**.
> Watch the **[Pro setup walkthrough video](https://www.youtube.com/watch?v=_9YopbCYTmI)** to see it for real.

```
 1. Print parts ─▶ 2. Get electronics ─▶ 3. Assemble the drive ─▶ 4. Wire the boards
       ─▶ 5. Flash firmware ─▶ 6. Mount + airback ─▶ 7. Set force & calibrate ─▶ 8. Pair & play
```

![Pro build steps and the repository files each step uses](../media/diagrams/pro-build-flow.png)
<sub>Every step maps to specific repo files — full index in the [source map](../SOURCE-MAP.md).</sub>

![Pro drive mechanism](../media/diagrams/pro-mechanism.png)

The drive is a **vertical column**: a motor sits **beside** the screw and the **push‑rod presses
straight down** on the sustain pedal. For the full picture see the **[reference design](../../device-pro-acoustic/hardware/reference-design/)**
— a [system‑architecture diagram](../../device-pro-acoustic/hardware/reference-design/pro-architecture.png)
and a [mechanical‑layout diagram](../../device-pro-acoustic/hardware/reference-design/pro-mechanical-layout.png)
drawn after the working unit.

## Before you start — what you need
- A **3D printer** (≥240 mm bed helps) + **PLA+** filament
- Soldering iron, hookup wire, basic hand tools
- The **electronics** (see [`PARTS-REFERENCE.md`](../../device-pro-acoustic/hardware/PARTS-REFERENCE.md)):
  Raspberry Pi **Pico**, **nRF52840** BLE board, **IQ‑Fortiq** motor *(or the NEMA17 stepper successor)*,
  a **+5 V cooling fan**, **HX711**, **2SK4017** MOSFET, travel‑limit slider, **24 V PSU**
- Frame stock: **2040 + 2080 + 4040 aluminium extrusion**, a **GT-2‑262 belt** + **T60/T60 pulleys**,
  a **T10 lead screw** (**lead 16 mm/rev, 150 mm**), push‑rod
- The **airback** kit: a **WINBAG** air jack + a small **electric air pump** (housed in the box, driven
  from **GP12** via the **2SK4017** MOSFET and a panel **PUMP SW**) — the built device does **not** use the hand bulb
- An iPhone/iPad with **Face ID** + the [iOS app](ios.md)

## Step 1 — Print the mechanical parts
1. Open the `.stl` / `.3mf` files in [`hardware/3d-print/`](../../device-pro-acoustic/hardware/3d-print/) in a slicer (Bambu Studio, PrusaSlicer, OrcaSlicer…).
2. Use **PLA+**, **0.1–0.2 mm** tolerance; mind orientation (holes unsupported). See the [3D‑print notes](../../device-pro-acoustic/hardware/3d-print/README.md).
3. Print the frame parts, PCB mount, power box, push‑rod, and covers.

## Step 2 — Get the electronics
Order the parts from [`PARTS-REFERENCE.md`](../../device-pro-acoustic/hardware/PARTS-REFERENCE.md).
**Note:** the original IQ/Fortiq motor is **EOL** — the planned successor is a **NEMA17 ("17‑type") stepper of the same size** (so it reuses the frame), driven **STEP/DIR**. See [`HARDWARE-AVAILABILITY.md`](../../device-pro-acoustic/HARDWARE-AVAILABILITY.md).

## Step 3 — Assemble the drive unit
The drive is a **vertical column** (see the [reference design](../../device-pro-acoustic/hardware/reference-design/)):
1. Build the frame — a **vertical 2040 post** (L ≈ 200 mm) standing on a **2080 base** (L ≈ 200 mm).
2. Mount the **motor beside the screw** near the top and couple it with the **GT-2‑262 belt** over **two
   T60 pulleys (1:1)** — the belt only *offsets* the motor next to the screw, it is **not** a reduction.
3. Fit the **vertical T10 lead screw** (lead **16 mm/rev**) **down the left side of the 2040 post**; its
   **nut/carriage** runs down the frame and carries a **push‑rod** — a **2040 L=75 mm** piece with a
   **15 mm PLA** nut‑holder on top and a **PLA + hard‑rubber tip** below (~**115 mm**) — that presses
   **straight down** on the sustain pedal. Add the **+5 V cooling fan** on the motor.
4. House the boards in the printed **electronics box** (BLE + Pico) and the supply in the **power box (PW)**.

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
2. Anchor with the **airback**: run the **air tube** from the box's **electric pump** to the WINBAG and
   inflate it against a neighbouring pedal with the panel **PUMP SW**
   to absorb the reaction force — nothing touches the piano's finish. See
   [`hardware/airback/`](../../device-pro-acoustic/hardware/airback/).

![Airback air valve](../../device-pro-acoustic/hardware/photos/airback_air_valve.jpg)

## Step 7 — Set the pressing force & calibrate
- Set the **DIP switch** for pressing force **20–35 W** (1 W steps) and lift distance **5–20 mm**. Start in the low‑20s W and raise until the note sounds reliably (force is **power‑based**, piano‑dependent).
- Run the self‑calibration; watch the **Serial Monitor @ 115200**. A safety cap stops travel beyond ~50 mm.

## Step 8 — Pair the app & play
Build/install the [iOS app](ios.md), pair over Bluetooth, preset your **offset (threshold)** & **multiplier**
(together they fix how fast the pedal follows your head — see [how it works](../how-it-works.md)), calibrate
the head‑angle zero — and play. See [`docs/operation/`](../operation/).

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

Off‑the‑shelf mechanical parts (IQ motor → **NEMA17** successor, **T10 lead screw** lead **16 mm/rev** / 150 mm,
**GT-2‑262 belt**, **T60 pulleys** 5/10 mm bore, bearings, **2040 + 2080 + 4040** aluminium extrusion,
**WINBAG air jack** 160×150 mm / ≤50 mm / 135 kg + the box's **electric pump**): see the [assembly BOM](../../device-pro-acoustic/assembly/README.md).
For the full file ↔ topic index, see the [**source map**](../SOURCE-MAP.md).

---
→ [Build hub](README.md) · [iOS build](ios.md) · [Switch build](switch.md) · [How it works](../how-it-works.md) · [Source map](../SOURCE-MAP.md)
