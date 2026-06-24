# 🎛️ Build the **Switch** (digital piano / keyboard)

> 🌐 **English** · [日本語](../../i18n/ja/docs/build/switch.md) · [Deutsch](../../i18n/de/docs/build/switch.md)

The Switch is the small, inexpensive version for **digital** pianos and keyboards. Instead of a
motor, it switches the sustain **electronically** through the instrument's **sustain‑pedal jack** —
no motor, no airback. It uses the **same iOS app** and BLE board as the Pro.

> 🚧 **Draft.** Most Switch hardware is now confirmed (board = ItsyBitsy nRF52840; a **MOSFET** on
> `GP13` switches the sustain line, **no series resistor**); the remaining detail is the exact MOSFET
> part + its wiring — see [`device-switch-electronic/firmware/`](../../device-switch-electronic/firmware/).
> The **[Switch user‑manual video](https://youtu.be/XOVENtBsOp4)** shows it in use.

```
 1. Get the BLE board ─▶ 2. Add the sustain switch ─▶ 3. Wire to the pedal jack ─▶ 4. Flash ─▶ 5. Pair & use
```

## Before you start
- An **Adafruit ItsyBitsy nRF52840** BLE board (the Switch's board; has the onboard DotStar)
- A **MOSFET** to switch the sustain line (**no series resistor**) *(exact part TBD)*
- **2× AA batteries** for power (no USB charging)
- A connector for the instrument's **sustain‑pedal jack** (commonly a 6.3 mm / TS jack)
- An iPhone/iPad with **Face ID** + the [iOS app](ios.md)

## Step 1 — Flash the BLE board
Flash the **standalone Switch firmware**
([`device-switch-electronic/firmware/`](../../device-switch-electronic/firmware/)) to the nRF52840
(double‑tap RESET → UF2 bootloader → upload). Full steps: [`docs/toolchain/`](../toolchain/).
Confirm it advertises (`bFaaaPSwitch_1…4`) in a BLE scanner.

## Step 2 — Add the sustain switch
Drive a **MOSFET** from the BLE board's `GP13` so it opens/closes the sustain contact (no series
resistor). *(Exact MOSFET part + gate/drain/source wiring being finalised.)*

## Step 3 — Wire to the pedal jack
Wire the MOSFET across the instrument's **sustain‑pedal jack** (TS tip/sleeve). Match the **polarity /
normally‑open vs normally‑closed** behaviour of your instrument with the app's **on‑type / off‑type**
toggle (`n` / `f`).

## Step 4 — Pair & use
Build/install the [iOS app](ios.md), connect over Bluetooth, set your **threshold** and **speed**,
and play. See the [Switch user manual](../user-manual/).

---
→ [Build hub](README.md) · [Pro build](pro.md) · [iOS build](ios.md)
