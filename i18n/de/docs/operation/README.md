# bFaaaP bedienen

> 🌐 [English](../../../../docs/operation/README.md) · [日本語](../../../ja/docs/operation/README.md) · **Deutsch**

Eine kurze Anleitung zur täglichen Nutzung. (Pro‑/akustische Linie; die Switch‑Linie wird von der
App‑Seite gleich bedient.)

> **Die echte Einrichtung ansehen**: Der Entwickler zeigt die Installation bei **25:01–28:32** in
> <https://www.youtube.com/watch?v=V3cXeNW9jXY>. Die Schritte unten folgen dieser Vorführung.

## Einrichtung (wie vorgeführt, Pro)

1. Platziere das (leichte) Gerät so, dass seine **Antriebsachse mit dem Haltepedal (Dämpferpedal)
   fluchtet**.
2. Lege den **Airback** unter ein **Nachbarpedal** und **pumpe ihn mit der Pumpe auf** — er drückt
   dieses Pedal von unten herunter und **nimmt die Reaktionskraft auf**, sodass der Antrieb des
   Haltepedals das Gerät nicht zurückschieben kann. **Prüfe, dass sich die Einheit nicht mehr bewegt.**
3. Dann wird der Antriebsweg gesetzt: das **untere Ende wird automatisch gefunden**, das **obere Ende
   mit dem Schieber** an der Handsteuerung.
4. Montiere das iPhone zum Spieler gerichtet und starte die App (unten). Kopf senken hält den Ton;
   zurückkehren löst.

## Einmalig / pro Sitzung

1. **Gerät an den Pedalen platzieren & fixieren.** Im Referenzaufbau steht die Pro‑Einheit auf einem
   **Holzbrett** vor der **Pedallyra** des Flügels, mit ihrem Aktuator über dem **Haltepedal (rechts)**;
   der **Airback** (blauer Luftsack) liegt daneben. Pumpe den Airback mit der Handpumpe auf, bis die
   Einheit fest geklemmt ist und sich nicht bewegen kann. Siehe
   [`../../device-pro-acoustic/hardware/airback/`](../../../../device-pro-acoustic/hardware/airback/).
2. **Montiere das iPhone/iPad** auf dem Notenpult (oder einem Ständer) **zum Gesicht des Spielers
   gerichtet**, damit die vordere TrueDepth‑Kamera den Kopf verfolgen kann.
3. Stelle mit dem **Schieber** der Handsteuerung die **obere Position / den Weganschlag** des
   Antriebsteils ein, damit das Pedal richtig weit gedrückt wird.
4. **Schalte das Gerät ein.** Es bewirbt sich über BLE als `bFaaaPSwitch_1` (oder `_2`…`_4` bei
   anderem Kanal).

## In der App

1. Öffne die App und erteile **Kamera**‑ und **Bluetooth**‑Berechtigungen.
2. **Wähle den Kanal** passend zu deinem Gerät (1–4). Die App verbindet sich nur mit einem
   `bFaaaPSwitch_n`‑Gerät.
3. Halte iPhone/iPad so, dass die **vordere (TrueDepth‑)Kamera dein Gesicht sieht**.
4. **Individuelle Voreinstellung (einmal pro Spieler — wichtig).** Stelle in der App den
   **Schwellen‑Startpunkt (Offset)** so ein, dass eine normale Kopfhaltung „Pedal oben“ bedeutet, und
   den **Faktor** dafür, wie viel Kopfneigung das volle Pedal erreicht. **Jeder Spieler stellt dies auf
   seinen eigenen bequemen Bereich und seine Kopfbewegungsgeschwindigkeit ein**, und die App speichert
   es. Das macht die Steuerung **individuell**: dasselbe Gerät dient einem fußfähigen Erwachsenen,
   einem Kind und einem Spieler mit eingeschränkter Kopfbewegung — z. B. wählt jemand mit begrenzter
   Halsbewegung einen **kleinen Offset und einen großen Faktor**. Wiederhole die Voreinstellung für
   jeden neuen Spieler oder jede Sitzposition.
5. **Neige den Kopf**, um das Sustain einzugreifen; in die Neutralstellung zurückkehren löst. Der
   Bildschirm ist **in Ruhe weiß und wird bei Eingriff rot**, sodass du den Zustand auf einen Blick
   siehst. (Gleiche App und Verhalten für Pro und Switch.)

## Tipps

- Lass den Bildschirm an — die App deaktiviert die Auto‑Sperre während des Spiels.
- Bei Verbindungsabbruch sucht und verbindet die App automatisch neu.
- Die On‑Typ‑/Off‑Typ‑Einstellung kehrt um, ob eine Neigung „Sustain ein“ oder „aus“ bedeutet; wähle,
  was sich natürlich anfühlt.

## Signal‑Referenz

| App sendet | Ergebnis |
|------------|----------|
| `iNN` (alle 100 ms) | Ziel‑Pedalmenge `00`–`99` |
| `N` / `F` | Eingriff / Lösen |
| Kanal‑/Typ‑Befehle | das Gerät konfigurieren |

Vollständiges Protokoll: [`../architecture/`](../architecture/).
