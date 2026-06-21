# 📱 Die iOS‑App bauen

> 🌐 [English](../../../../docs/build/ios.md) · [日本語](../../../ja/docs/build/ios.md) · **Deutsch**

Die App wird für **beide Geräte (Pro und Switch)** benötigt. Sie liest den Kopfwinkel per
Face‑ID‑Gesichts‑Tracking und sendet Pedalbefehle per Bluetooth. Du kannst sie auch einfach aus dem
App Store **herunterladen** — das Bauen aus dem Quellcode ist für Entwickler, die anpassen oder
beitragen möchten.

> Referenz: [`ios-app/BUILD.md`](../../../../ios-app/BUILD.md) · [`ios-app/CODE-STRUCTURE.md`](../../../../ios-app/CODE-STRUCTURE.md) · [`ios-app/DESIGN-HIGHLIGHTS.md`](../../../../ios-app/DESIGN-HIGHLIGHTS.md)

```
 1. Voraussetzungen ─▶ 2. Projekt öffnen ─▶ 3. Signing setzen ─▶ 4. aufs Gerät bauen ─▶ 5. Berechtigungen ─▶ 6. Koppeln & einstellen
```

## Schritt 0 — Was du brauchst
- Einen **Mac** mit **Xcode 15+**
- Ein **iPhone/iPad mit TrueDepth‑(Face‑ID‑)Kamera** — nötig für das Kopf‑Tracking (der Simulator kann das nicht)
- Eine kostenlose **Apple‑ID** genügt zur Installation auf dem eigenen Gerät (ein bezahlter Apple‑Developer‑Account ist nur zum Verteilen nötig)

## Schritt 1 — Quellcode holen
Klone das Repository und öffne das Xcode‑Projekt:
```sh
git clone https://github.com/TomoShishido/bfaaap_opensource.git
open bfaaap_opensource/ios-app/src/bFaaaPSwitch1.xcodeproj
```

## Schritt 2 — Dein Signing setzen
In Xcode: Projekt auswählen → **Signing & Capabilities** → **dein Team** wählen und die
**Bundle‑Identifier** auf etwas Eindeutiges ändern (die veröffentlichte ist zu `com.example.bfaaap`
bereinigt).

## Schritt 3 — Auf dem Gerät bauen & starten
Verbinde iPhone/iPad per USB, wähle es als Ziel und drücke **Run (▶)**. Erlaube beim ersten Start
**Kamera (Gesichts‑Tracking)** und **Bluetooth**.

## Schritt 4 — Koppeln & einstellen
Schalte das bFaaaP‑Gerät ein und verbinde dich aus der App. Stelle deine **Schwelle** (wie weit
neigen) und **Reaktionsgeschwindigkeit** ein. Den BLE‑Ablauf siehe
[`ios-app/BLE-CONNECTION-FLOW.md`](../../../../ios-app/BLE-CONNECTION-FLOW.md), den Betrieb in
[`docs/operation/`](../../../../docs/operation/).

> Lieber nicht selbst bauen? Hol sie aus dem **App Store**: <https://apps.apple.com/jp/app/bfaaapswitch/id1545866059>

---
→ [Build‑Hub](README.md) · [Pro bauen](pro.md) · [Switch bauen](switch.md)
