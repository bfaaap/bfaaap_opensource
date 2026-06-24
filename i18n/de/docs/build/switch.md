# 🎛️ Den Switch bauen (Digitalklavier / Keyboard)

> 🌐 [English](../../../../docs/build/switch.md) · [日本語](../../../ja/docs/build/switch.md) · **Deutsch**

Der Switch ist die kleine, günstige Version für **digitale** Klaviere und Keyboards. Statt eines
Motors schaltet er das Sustain **elektronisch** über die **Pedalbuchse** des Instruments — kein
Motor, kein Airback. Er nutzt **dieselbe iOS‑App und dasselbe BLE‑Board** wie der Pro.

> 🚧 **Entwurf:** der Großteil der Switch‑Hardware ist nun bestätigt (Board = ItsyBitsy nRF52840; ein
> **MOSFET** an `GP13` schaltet die Sustain‑Leitung, **kein Serienwiderstand**). Offen bleibt nur das
> genaue MOSFET‑Bauteil und seine Verdrahtung — siehe
> [`device-switch-electronic/firmware/`](../../../../device-switch-electronic/firmware/). Das
> **[Switch‑Handbuch‑Video](https://youtu.be/XOVENtBsOp4)** zeigt die Anwendung.

```
 1. BLE‑Board holen ─▶ 2. Sustain‑Schalter ergänzen ─▶ 3. an Pedalbuchse verdrahten ─▶ 4. flashen ─▶ 5. koppeln & nutzen
```

## Bevor du beginnst
- Ein **Adafruit ItsyBitsy nRF52840**‑BLE‑Board (das Board des Switch; mit der onboard‑DotStar)
- Ein **ROHM `RU1J002YN`** N‑Kanal‑Logiklevel‑**MOSFET** zum Schalten der Sustain‑Leitung (**kein Serienwiderstand**)
- **2× AA‑Batterien** zur Stromversorgung (kein USB‑Laden)
- Ein Stecker für die **Sustain‑Pedalbuchse** des Instruments (meist 6,3‑mm‑/TS‑Klinke)
- Ein iPhone/iPad mit Face ID + die [iOS‑App](ios.md)

## Schritt 1 — BLE‑Board flashen
Flashe die **eigenständige Switch‑Firmware**
([`device-switch-electronic/firmware/`](../../../../device-switch-electronic/firmware/)) auf das
nRF52840 (RESET zweimal tippen → UF2‑Bootloader → hochladen). Alle Schritte:
[`docs/toolchain/`](../../../../docs/toolchain/). Prüfe, dass es (`bFaaaPSwitch_1…4`) in einem
BLE‑Scanner erscheint.

## Schritt 2 — Sustain‑Schalter ergänzen
Steuere über `GP13` des BLE‑Boards einen **MOSFET** an, der den Sustain‑Kontakt öffnet/schließt (kein
Serienwiderstand). Bauteil = **ROHM `RU1J002YN`**; vollständige Referenzschaltung in
[`device-switch-electronic/hardware/`](../../../../device-switch-electronic/hardware/).

## Schritt 3 — An die Pedalbuchse verdrahten
Verdrahte den MOSFET über die **Sustain‑Pedalbuchse** des Instruments (TS Spitze/Schaft). Passe die
**Polarität / Öffner‑ vs. Schließer‑Verhalten** mit dem **On‑Typ / Off‑Typ**‑Schalter der App
(`n` / `f`) an.

## Schritt 4 — Koppeln & nutzen
Baue/installiere die [iOS‑App](ios.md), verbinde dich per Bluetooth, stelle deine **Schwelle** und
**Geschwindigkeit** ein und spiele. Siehe das [Switch‑Handbuch](../../../../docs/user-manual/).

---
→ [Build‑Hub](README.md) · [Pro bauen](pro.md) · [iOS bauen](ios.md)
