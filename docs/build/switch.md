# 🎛️ Build the **Switch** (digital piano / keyboard)

> 🌐 **English** · [日本語](../../i18n/ja/docs/build/switch.md) · [Deutsch](../../i18n/de/docs/build/switch.md)

The Switch is the small, inexpensive version for **digital** pianos and keyboards. Instead of a
motor, it switches the sustain **electronically** through the instrument's **sustain‑pedal jack** —
no motor, no airback. It uses the **same iOS app** and BLE board as the Pro.

> 🚧 **Draft.** The Switch hardware is being finalised; a couple of details (the switching
> element and the sustain‑jack polarity) are pending from the maker — see the deferred items in
> [`DISCORD-FINDINGS.md`](../../device-pro-acoustic/DISCORD-FINDINGS.md). The
> **[Switch user‑manual video](https://youtu.be/XOVENtBsOp4)** shows it in use.

```
 1. Get the BLE board ─▶ 2. Add the sustain switch ─▶ 3. Wire to the pedal jack ─▶ 4. Flash ─▶ 5. Pair & use
```

## Before you start
- An **nRF52840** BLE board (same family as the Pro's)
- A **switching element** for the sustain line — e.g. a small **relay or optocoupler** *(exact part TBD)*
- A connector for the instrument's **sustain‑pedal jack** (commonly a 6.3 mm / TS jack)
- An iPhone/iPad with **Face ID** + the [iOS app](ios.md)

## Step 1 — Flash the BLE board
Flash the **standalone Switch firmware**
([`device-switch-electronic/firmware/`](../../device-switch-electronic/firmware/)) to the nRF52840
(double‑tap RESET → UF2 bootloader → upload). Full steps: [`docs/toolchain/`](../toolchain/).
Confirm it advertises (`bFaaaPSwitch_1…4`) in a BLE scanner.

## Step 2 — Add the sustain switch
Connect the switching element (relay/optocoupler) so the BLE board's output line opens/closes the
sustain contact. *(Reference circuit being finalised.)*

## Step 3 — Wire to the pedal jack
Wire the switch across the instrument's **sustain‑pedal jack**. Mind the **polarity / normally‑open
vs normally‑closed** behaviour of your instrument *(being confirmed)*.

## Step 4 — Pair & use
Build/install the [iOS app](ios.md), connect over Bluetooth, set your **threshold** and **speed**,
and play. See the [Switch user manual](../user-manual/).

---
→ [Build hub](README.md) · [Pro build](pro.md) · [iOS build](ios.md)
