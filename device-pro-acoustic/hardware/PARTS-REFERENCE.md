# Pro device — parts reference (boards, motor, connectors)

> **Source / attribution.** Adapted from the team's `bfaaapteam` repository
> (`docs/hardware.md`, by Taguchi & H. Narusawa) and the team Discord.
> Reference images are in [`reference/`](reference/).

This is the **authoritative parts list with vendor links** for the IQ (v039B)
reference generation. It supersedes earlier guesses about the BLE board.

## Microcontrollers

| Role | Part | Vendor / link |
|------|------|---------------|
| **Main board (pedal/motor control)** | **Raspberry Pi Pico** (RP2040) | [raspberrypi.com](https://www.raspberrypi.com/products/raspberry-pi-pico/) · [datasheet](https://datasheets.raspberrypi.com/pico/pico-datasheet.pdf) · pinout in [`reference/rpi_pico_pinout.svg`](reference/rpi_pico_pinout.svg) |
| **BLE board (receiver)** — **confirmed** | **nRF52840 BLE board (Akizuki `AE-NRF52840`, `g117484`)** ✅ | [akizukidenshi g117484](https://akizukidenshi.com/catalog/g/g117484/) · [datasheet](https://akizukidenshi.com/goodsaffix/AE-NRF52840.pdf) |
| **BLE board (receiver)** — alternative | **Adafruit Feather nRF52840 Express** (ID 4062) | [adafruit.com/product/4062](https://www.adafruit.com/product/4062) · [guide](https://learn.adafruit.com/introducing-the-adafruit-nrf52840-feather) |

> **BLE board (confirmed by the device co‑author, 2026‑06‑14):** the shipping board
> is the **Akizuki `AE-NRF52840` (g117484)** — chosen because it is **cheaper**,
> uses the **same BLE module**, and reports the **same board ID** (the Adafruit
> Feather nRF52840 is a compatible alternative). It is **not** the ItsyBitsy: the
> ItsyBitsy/DotStar appears in the **Switch** firmware's colour‑LED routine, while
> the **Pro** BLE firmware is "the Switch BLE code minus the LED and sleep
> routines," so the Pro board needs no DotStar.

## Drive motor

| Item | Detail |
|------|--------|
| **Motor** | **IQ Fortiq BLS42** (a.k.a. M42BLS / `IQ-FORTIQ-M42BLS-100`, 100 W) — [Crowd Supply](https://www.crowdsupply.com/iq-motion-control/iq-fortiq-bls42) · [Vertiq docs](https://iqmotion.readthedocs.io/en/latest/modules/fortiq_42XX.html) · [datasheet](https://iqmotion.readthedocs.io/en/latest/_downloads/c01d03f5e3ec159b4621b16c13126158/fortiq_datasheet.pdf) |
| **Electrical interface** | CANL, CANH, ADC, GPIO1‑3, HPO (7‑pin signal) + V‑/V+; the `H1_RX` / `H2_TX` pair is used as **serial** (also supports PWM/Dir, Step). See [`reference/fortiq42_electrical-interface.png`](reference/fortiq42_electrical-interface.png). |
| **Signal terminal** | Same Sky (CUI) **TBL009-254-07GY-2GY** (7‑pos, 2.54 mm, screwless, 26–18 AWG) |
| **Power terminal** | Same Sky (CUI) **TBLH10-350-02BK** (2‑pos, 3.5 mm, 24–16 AWG) |
| **3‑pin header** | generic ("Dupont") 3P housing ([akizuki g112152](https://akizukidenshi.com/catalog/g/g112152/)) |
| **Status (per device co‑author)** | **EOL** → successor = closed‑loop stepper (DRV8825‑compatible interface), **specific model undecided**. |

## Power & other parts (confirmed in Discord)

- **Supply:** **24 V** for the IQ motor (within the motor's spec); 12 V batteries
  in series are usable for venues without AC; portable power stations work for
  outdoor concerts. *(Next‑gen idea: a single 24 V supply, generating 5 V
  internally if the motor current doesn't disturb the 5 V rail.)*
- **Power connector (prototype):** an **M15‑type** connector (the kind used for
  radio‑transceiver microphone jacks); not critical — other connectors are fine,
  but the **high current** matters.
- **Air pump:** the **rubber‑visible side of the metal valve is the air input**.
- **Pressing‑force calibration:** by **motor power**; threshold **20–35 W**, set by
  a **DIP switch** (base 20 W + DIP, 1 W steps), **piano‑dependent**; a **50 mm**
  travel cap prevents the push‑rod from being driven out (firmware v039B comment).
- **Upper‑limit input:** a **variable resistor / slide volume** read on the Pico
  **ADC0 (GP26)**.
