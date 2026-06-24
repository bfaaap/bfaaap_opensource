# 🎛️ Den Switch bauen (Digitalklavier / Keyboard)

> 🌐 [English](../../../../docs/build/switch.md) · [日本語](../../../ja/docs/build/switch.md) · **Deutsch**

Der Switch ist die kleine, günstige Version für **digitale** Klaviere und Keyboards. Statt eines
Motors schaltet er das Sustain **elektronisch** über die **Pedalbuchse** des Instruments — kein
Motor, kein Airback. Er nutzt **dieselbe iOS‑App und dasselbe BLE‑Board** wie der Pro.

> 🚧 **Entwurf:** die Switch‑Hardware wird finalisiert; einige Details (das Schaltelement und die
> Polarität der Sustain‑Buchse) stehen noch von den Bauenden aus — siehe die zurückgestellten Punkte
> in [`DISCORD-FINDINGS.md`](../../../../device-pro-acoustic/DISCORD-FINDINGS.md). Das
> **[Switch‑Handbuch‑Video](https://youtu.be/XOVENtBsOp4)** zeigt die Anwendung.

```
 1. BLE‑Board holen ─▶ 2. Sustain‑Schalter ergänzen ─▶ 3. an Pedalbuchse verdrahten ─▶ 4. flashen ─▶ 5. koppeln & nutzen
```

## Bevor du beginnst
- Ein **nRF52840**‑BLE‑Board (gleiche Familie wie beim Pro)
- Ein **Schaltelement** für die Sustain‑Leitung — z. B. ein kleines **Relais oder Optokoppler** *(genaues Teil noch offen)*
- Ein Stecker für die **Sustain‑Pedalbuchse** des Instruments (meist 6,3‑mm‑/TS‑Klinke)
- Ein iPhone/iPad mit Face ID + die [iOS‑App](ios.md)

## Schritt 1 — BLE‑Board flashen
Flashe die **eigenständige Switch‑Firmware**
([`device-switch-electronic/firmware/`](../../../../device-switch-electronic/firmware/)) auf das
nRF52840 (RESET zweimal tippen → UF2‑Bootloader → hochladen). Alle Schritte:
[`docs/toolchain/`](../../../../docs/toolchain/). Prüfe, dass es (`bFaaaPSwitch_1…4`) in einem
BLE‑Scanner erscheint.

## Schritt 2 — Sustain‑Schalter ergänzen
Verbinde das Schaltelement (Relais/Optokoppler) so, dass die Ausgangsleitung des BLE‑Boards den
Sustain‑Kontakt öffnet/schließt. *(Referenzschaltung wird finalisiert.)*

## Schritt 3 — An die Pedalbuchse verdrahten
Verdrahte den Schalter über die **Sustain‑Pedalbuchse** des Instruments. Achte auf die **Polarität /
Öffner‑ vs. Schließer‑Verhalten** deines Instruments *(wird bestätigt)*.

## Schritt 4 — Koppeln & nutzen
Baue/installiere die [iOS‑App](ios.md), verbinde dich per Bluetooth, stelle deine **Schwelle** und
**Geschwindigkeit** ein und spiele. Siehe das [Switch‑Handbuch](../../../../docs/user-manual/).

---
→ [Build‑Hub](README.md) · [Pro bauen](pro.md) · [iOS bauen](ios.md)
