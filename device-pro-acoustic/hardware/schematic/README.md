# Pro device — circuit schematic & diagrams

> **Source / attribution.** These diagrams are by **Reo Taguchi** (GitHub
> [`reodon`](https://github.com/reodon)), imported from the repository
> [`reodon/copy_bfaaap_pro`](https://github.com/reodon/copy_bfaaap_pro)
> (`kicad/` and `original/`). They correspond to the **IQ‑motor reference
> generation (firmware v039B)**.
>
> ⚠️ **License/consent pending.** The source repository has no license file.
> Confirm Taguchi's consent and a license before public release (tracked in
> [`../../../PUBLISHING-CHECKLIST.md`](../../../PUBLISHING-CHECKLIST.md)).

## Files

| File | What it is |
|------|-----------|
| [`schematic_2025-03-05_kicad.png`](schematic_2025-03-05_kicad.png) | **Single‑sheet KiCad schematic** (KiCad 9.0.0, A4, dated 2025‑03‑05). The formal wiring of the whole Pro device. |
| [`block-diagram.png`](block-diagram.png) | Hand‑drawn system block diagram (iPhone → BLE → BLE board → Pico → motor → pedal; 5 V & 12–48 V rails). |
| [`power-supply-options.png`](power-supply-options.png) | Hand‑drawn **power‑supply options** (AC 100 V → 5 V logic + 24 V / 12–48 V motor rail; three alternative PSU configurations). |

Only a **PNG export** of the schematic is in the source repo (the `kicad/`
folder has no `.kicad_sch`/`.kicad_pro` source). See the open questions below.

## What the schematic confirms (analysis)

The KiCad sheet is the **single‑sheet system schematic** the project needed. It
matches the **IQ (v039B) reference** firmware. Key facts read directly from it:

### Boards & main parts
- **BLE board** — drawn as an **Adafruit Feather (generic)** symbol; the actual
  board is the **Akizuki `AE-NRF52840` (g117484)** (confirmed by the co‑author —
  cheaper, same BLE module, same board ID; the Feather symbol is a stand‑in, and
  the Adafruit Feather nRF52840 is a compatible alternative).
- **Main board** — **Raspberry Pi Pico (RP2040)**.
- **Motor** — **M1 = M42BLS** (the IQ‑FORTIQ‑M42BLS), powered from **+24 V**,
  controlled over a **serial** pair (`H1_RX` / `H2_TX`).
- **Air‑pressure sensor** — **HX711** (`A4`).
- **Air pump** — **M2 AirPump** on **+5 V**, switched by **Q1 (N‑MOSFET)** with a
  push switch **SW2**.
- **Upper‑limit input** — **RV1, a 3‑terminal potentiometer** (3V3 / wiper / GND),
  wiper read by a Pico **ADC**.
- **Power** — **two rails: +5 V (logic)** and **+24 V (motor)**; main power switch
  **SW1** feeds the Pico `VSYS`. (See `power-supply-options.png`: AC 100 V → a
  commercial SMPS giving 5 V + 24 V.)

### Authoritative Pico pin map (from the schematic)
| Net | Pico pin | Connects to |
|-----|----------|-------------|
| `BLE_RX` / `BLE_TX` | **GP0 / GP1** (pins 1/2) | UART to the BLE board (Serial1) |
| `AP_SCK` / `AP_OUT` | **GP2 / GP3** (pins 4/5) | **HX711** clock / data (air pressure) |
| `PDL_RX` / `PDL_TX` | **GP4 / GP5** (pins 6/7) | **IQ motor** serial (`H1_RX` / `H2_TX`) (Serial2) |
| `AP_FET` | **GP12** (pin 16) | gate of **Q1** (air‑pump MOSFET) |
| `PDL_RV` | **GP26 / ADC0** (pin 31) | **RV1 potentiometer** wiper (upper‑limit slider) |
| `VSYS` | pin 39 | +5 V via **SW1** power switch |
| `3V3` / `GND` | pins 36 / 3,33 | logic 3.3 V / ground |

**Notably, the slider is on `ADC0` (GP26)** — a real analog input — **not** on
`A3`/GP29 (which on a stock Pico is the VSYS divider). The firmware that reads
`A3` should therefore be aligned to the schematic's **ADC0 / GP26** (this resolves
the earlier "ADC pin" caveat in
[`../../HARDWARE-AVAILABILITY.md`](../../HARDWARE-AVAILABILITY.md)).

This pin map agrees with the firmware notes: BLE↔Pico UART on GP0/GP1, IQ motor on
GP4/GP5 (Serial2), the air‑pump MOSFET on GP12.

## Firmware in the source repo
Taguchi's repo also contains the matching **v039B Pico** sketch and the **BLE**
sketch, dated **2025‑01‑05**. The repository's
[`../../firmware/pico/`](../../firmware/pico/) holds the **later (2025‑07‑25)**
v039B versions, which are the reference here; the BLE sketch differs slightly
between the two dates.

## Notes from the device co-author (Narusawa, 2026-06-14)
- **Hand controller — resolved:** the upper-limit input **is a slide potentiometer
  ("slide volume")**, confirmed. The **RJ45 socket on the body is currently
  *unused***. So the schematic's direct `RV1` + `SW2` wiring is the live design;
  the RJ45/LAN in the BOM is legacy/unused.
- **Schematic source location:** the original files are **in the team's Discord
  (`bFaaaP`)** — see open question 2 (asking Taguchi to share them for the repo).

## Open questions for Taguchi (see CLAUDE.md §43, §45, §48)
1. ~~Exact BLE board~~ — **resolved:** the board is the **Akizuki `AE-NRF52840`
   (g117484)** (co‑author, 2026‑06‑14); the Feather symbol is a stand‑in.
2. The **KiCad source** is reportedly in the team's Discord — can the
   `.kicad_sch`/`.kicad_pro` (and any **PCB/Gerbers**) be shared for the repo
   (only a PNG export is here)?
3. **License/consent** to include these in the public OSS repo, and under what license?
4. Confirm the slider belongs on **ADC0 / GP26** (so the firmware's `A3` read is corrected to match).
5. Is there a **stepper‑version** schematic (this one is the IQ/v039B version)?
