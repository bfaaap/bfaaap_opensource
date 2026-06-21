# Architektur

> 🌐 [English](../../../../docs/architecture/README.md) · [日本語](../../../ja/docs/architecture/README.md) · **Deutsch**

## Signalkette

1. **Kopf‑Tracking (iOS).** Die Controller‑App liest mit ARKit `ARFaceTrackingConfiguration`
   (TrueDepth‑Kamera) den Nick‑Winkel (Pitch) des Kopfes.
2. **Mapping.** Der Winkel wird mit einem Nutzer‑„Faktor“ (Schieber, 0–20) multipliziert und auf
   `0–99` begrenzt.
3. **Übertragung (BLE).** Der Wert wird als ASCII‑String `i00`–`i99` über einen **Nordic UART
   Service (NUS)** gesendet. Eingriff/Lösen‑Übergänge senden zusätzlich Marker‑Bytes `N` (an) und `F` (aus).
4. **Betätigung (Gerät).** Die Pico‑Firmware parst den Wert und weist den **IQ‑/Fortiq‑Motor** an,
   das Haltepedal proportional zu drücken.

## BLE‑Details (beobachtet)

| Element | Wert |
|---------|------|
| Service (NUS) | `6E400001-B5A3-F393-E0A9-E50E24DCCA9E` |
| Write (RX, App→Gerät) | `6E400002-B5A3-F393-E0A9-E50E24DCCA9E` |
| Notify (TX, Gerät→App) | `6E400003-B5A3-F393-E0A9-E50E24DCCA9E` |
| Außerdem vorhanden | DFU `00001530-…`, Device Information `180A`, Battery `180F` |
| Beworbener Name | `bFaaaPSwitch_1` (umbenennbar `_1`..`_4` für mehrere Geräte/Kanäle) |

Die App filtert nach dem beworbenen lokalen Namen und verbindet sich daher nur mit einem
`bFaaaPSwitch_n`‑Gerät und ignoriert andere Peripheriegeräte in der Nähe.

## Nutzlast‑Format

- `iNN` — Zielwert, `NN` = `00`..`99` (Winkel × Faktor, begrenzt).
- `N` — Eingriffssignal (Pedal aktiv).
- `F` — Lösesignal (Pedal kehrt in Neutralstellung zurück).
- Werte werden per Timer gestreamt (~100‑ms‑Takt in aktueller Firmware/App).
