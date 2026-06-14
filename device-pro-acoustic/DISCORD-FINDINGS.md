# Pro device — findings from the team Discord & co-author Q&A (2025–2026)

> **Source.** The team's private **Discord** (`bFaaaP`: `#ハード` and `#ソフト`
> channels, 2025-02 → 2025-07) plus the device co-author's written answers
> (2026-06). This is a **cleaned engineering summary** for reproducibility.
> Personal/build photos and videos are **not** published (kept private); CAD/code
> imported here need author **consent + license** before public release
> (see [`../PUBLISHING-CHECKLIST.md`](../PUBLISHING-CHECKLIST.md)).
> Contributors referenced: H. Narusawa (device/firmware), R. Taguchi (schematic,
> build), M. Ootaki, H. Tanaka, T. Shishido.

## 1. Confirmed parts & wiring (IQ / v039B reference)

See [`hardware/PARTS-REFERENCE.md`](hardware/PARTS-REFERENCE.md) for vendor links
and [`hardware/schematic/`](hardware/schematic/) for the schematic + pin map.

- **Boards:** Raspberry Pi **Pico** (main) + **nRF52840 BLE board** = the
  **Akizuki `AE-NRF52840` (g117484)** (confirmed by the co-author: cheaper, same
  BLE module, same board ID; re-stocked at Akizuki 2025-03). The **Adafruit
  Feather nRF52840 Express (4062)** is a compatible alternative. *Not* the
  ItsyBitsy: the ItsyBitsy/DotStar is the **Switch**'s LED variant; the **Pro**
  BLE firmware = the Switch BLE code **minus the LED and sleep routines**.
- **Motor:** IQ **Fortiq BLS42** (M42BLS, 100 W), **+24 V**, serial via
  `H1_RX`/`H2_TX` ↔ Pico GP4/GP5. Connectors: TBL009-254-07GY-2GY (signal),
  TBLH10-350-02BK (power), 3-pin Dupont header.
- **Sensors / IO:** **HX711** = air-pressure (GP2/GP3); air-pump on **+5 V** via
  **Q1 N-MOSFET (GP12)** + push switch; upper-limit = **variable resistor /
  slide volume** on **ADC0/GP26**; a **DIP switch** sets calibration force and lift.
- **Power:** **24 V** (IQ motor); 12 V batteries in series / portable power
  stations usable for venues; an **M15-type** connector was used on the prototype
  (not critical; high current matters).

## 2. Self-calibration force threshold (firmware v039B, lines ~125–138)

The lower limit is found by driving down until the **motor power** rises at the
hard stop. Per the firmware comments and the co-author:
- Threshold is on **power (W)**, **piano-dependent** (reaction force differs).
- Originally 30 W; lowered to **20 W** (too-strong pressing makes it slip), but
  20 W alone proved **too weak** (triggers before the stop).
- **2025-07-22:** a **DIP switch** now sets the pressing power = **base 20 W + DIP,
  in 1 W steps → 20–35 W**, and also sets the **lift above the hard stop = 5–20 mm**.
- Safety: driving **> 50 mm** would push the rod out, so travel is capped.
- On the IQ motor the power is **read by command from the motor** (telemetry); for
  a stepper successor the measurement method is **undecided**.

## 3. Software / dev environment (from `#ソフト`)

- Build with **Arduino IDE v2** on **Ubuntu 24.04**; **Adafruit nRF52 BSP 1.6.1**
  for the BLE board (DFU flash over `/dev/ttyACM0`); on the **Pico** enable the
  **"IP/Bluetooth Stack"** option and reserve part of program flash as a
  filesystem (LittleFS / `InternalFileSystem`).
- **BLE protocol confirmed:** the iPhone/iPad sends `i` + a 2-digit value
  (`i00`–`i99`). The BLE board registers the channel and **converts `iNN` to a
  single byte** forwarded to the Pico (IQ-motor control), plus LED/sleep handling
  (LED routine removed on Pro).
- **Electronic-piano (Switch-like) output on Pro:** add **one FET**; to use it,
  the **IQ-motor control must be stopped** and a **switch to cut Pico + IQ-motor
  power** is needed.
- Project notes/source also live in the **`bfaaap-project` Scrapbox**
  (block diagram, BLE/Pico source, dev-env, Arduino IDE setup) and the
  **`TomoShishido/bfaaapteam`** GitHub repo (`docs/hardware.md`).

## 4. 3D printing (from `#ハード`)

- Printed on **Bambu Lab A1 mini** (Taguchi); larger parts (~**240 mm**, e.g.
  `CC`, `DD`) exceed the A1 mini bed → use **Bambu A1** / **Raise3D Pro3**
  (Tanaka's lab has one). Workflow: `.FCStd` source untouched, print the `.stl`;
  tolerances ~0.1–0.2 mm; **holes have no support**; mixed supported/unsupported
  regions — mind orientation. New **2025-05 housing** has **heat-countermeasure**
  changes to parts **A and B**.
- Imported CAD/STL: [`hardware/cad/from-discord-2025/`](hardware/cad/from-discord-2025/)
  and [`hardware/3d-print/from-discord-2025/`](hardware/3d-print/from-discord-2025/).

## 5. Next-generation design ideas (co-author, not yet implemented)

These are explicitly **future-device tasks**:
- **Power:** move to a **single 24 V supply**, generating **5 V internally**, if
  the motor drive current does not disturb the 5 V rail.
- **Air sensing:** possibly **drop the pressure sensor** and detect an air leak
  from the **air-pump motor current** instead (experiment-dependent).
- **Air control:** because the pump capacity is small (max inflation won't
  over-pressure the pedal), **timing-based pressurization** may replace the
  pressure threshold.
- **Air-release:** rethink — keep the jack **always closed** with only a **release
  mechanism**, simplifying setup and removing the "forgot to close" failure.
- **Mechanical BOM:** no suitable ready data found; will likely need to be
  **measured from the parts** (still pending).

## 6. Status of open items (co-author Q&A)
- ✅ **BLE board resolved:** Akizuki **AE-NRF52840 (g117484)** (cheaper, same BLE
  module, same board ID).
- ✅ **Consent (Narusawa, 2026-06-14):** agreed to **co-authorship**, **GitHub name
  credit**, and **including the Discord CAD** in the (eventually public) repo.
- ⏳ **Deferred until after the co-author's hospital discharge:** mechanical BOM
  (screws/bearings, part↔STL map, print orientation); Switch relay/optocoupler
  part + sustain-jack wiring (n/f polarity).
- ⏳ **Undecided:** stepper successor motor model + power/load measurement method.
- ⏳ **Taguchi:** schematic KiCad source (in Discord), and consent/license for the
  imported schematic + `bfaaapteam` content.
