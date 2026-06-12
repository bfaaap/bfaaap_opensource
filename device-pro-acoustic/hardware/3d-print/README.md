# 3D-printable parts

Ready-to-print meshes (`.stl`) and slicer projects (`.3mf`) for the bFaaaP
mechanical assembly.

- `.stl` — geometry only; import into your slicer.
- `.3mf` — **QIDI Studio** projects that also carry the reference print settings
  (open directly in QIDI Studio / OrcaSlicer).

Source CAD (editable) is in [`../cad/`](../cad/). For the slicing → G‑code →
printer workflow, see [`../../../docs/toolchain/`](../../../docs/toolchain/).

---

## Printer actually used (recovered from the `.3mf` metadata)

The `.3mf` project files record the exact machine and slicer:

| Field | Value |
|-------|-------|
| **Printer** | **QIDI X‑Plus 4** — enclosed CoreXY, build volume **305 × 305 × 280 mm** |
| **Slicer** | **QIDI Studio** v02.06.00.51 (an OrcaSlicer/Bambu‑derived slicer) |
| Nozzle | 0.4 mm |
| Layer height | 0.20 mm |
| Plate | textured PEI |
| Firmware | Klipper (`PRINT_START` macro) |

Filament/material is **not** stored in these files. The QIDI's heated chamber
(65 °C) suggests an engineering material may have been used for the load‑bearing
parts — **confirm the material with the maintainer**.

Product: <https://qidi3d.com> · US store: <https://us.qidi3d.com>

---

## Required build volume

Measured from the STL bounding boxes in this folder:

| Constraint | Value |
|------------|-------|
| Largest single part (`bFaaaP_BB_b`) | **280 × 62 × 121 mm** |
| Other large parts | `CC`/`DD` ≈ 250 × 100, `G` ≈ 220 × 102 mm |
| Tallest part (`PW_BOX`) | 104 × 44 × **200 mm** |
| **Per‑axis maxima** | **X ≈ 280 · Y ≈ 102 · Z ≈ 200 mm** |

So you need a printer that can fit a **~280 mm‑long** part (along one axis, or
placed diagonally) and **~200 mm tall**. A **≥ 300 mm bed prints everything
flat** with margin; a **256 mm bed** works only if the single 280 mm part is
rotated **diagonally** (a 256 mm bed's diagonal ≈ 362 mm) or split.

---

## Usable printers (with URLs)

### The one actually used
- **QIDI X‑Plus 4** — 305 × 305 × 280 mm — <https://qidi3d.com> (US: <https://us.qidi3d.com>)

### Recommended — ≥ 300 mm bed, fits all parts flat
- **QIDI Plus 4** — 305 × 305 × 280 mm — <https://us.qidi3d.com/products/plus4-3d-printer>
- **QIDI X‑Max 3** — 325 × 325 × 315 mm — <https://qidi3d.com>
- **Creality K1 Max** — 300 × 300 × 300 mm — <https://www.creality.com/products/creality-k1-max-3d-printer>
- **Original Prusa XL** — 360 × 360 × 360 mm — <https://www.prusa3d.com/category/original-prusa-xl/>
- **Anycubic Kobra 2 Max / 3 Max** — 420 × 420 × 500 mm — <https://www.anycubic.com>
- **Creality Ender 3 Max Neo** — 300 × 300 × 320 mm (budget, open frame) — <https://www.creality.com>

### Possible on a 256 mm bed (rotate the 280 mm part diagonally, or split it)
- **Bambu Lab P1S / X1C** — 256 × 256 × 256 mm — <https://bambulab.com>
- **Bambu Lab A1** — 256 × 256 × 256 mm (open frame) — <https://bambulab.com>

> An **enclosed / heated‑chamber** printer (like the QIDI used here) is preferable
> if the parts are ABS/ASA/PA‑CF (warp‑prone engineering materials). For PLA/PETG,
> an open‑frame printer is fine. Match the printer class to the chosen material.

---

## TODO before publishing

- Recommend the **material** and per‑part **orientation / supports**.
- Add a **parts list** (which file = which part, quantity to print).
- Confirm these meshes match the latest CAD revision in [`../cad/`](../cad/).
