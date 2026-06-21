# Toolchain — Flashen, Testen & Ausführen (VSCode‑zentriert)

> 🌐 [English](../../../../docs/toolchain/README.md) · [日本語](../../../ja/docs/toolchain/README.md) · **Deutsch**

Dieses Projekt hat **drei verschiedene Build‑Ziele**, jedes mit eigenem Werkzeug:

| Ziel | Was du „schreibst/flashst“ | Werkzeug |
|------|----------------------------|----------|
| **iOS‑App** | eine signierte App auf iPhone/iPad | **Xcode auf einem Mac** → [`../../ios-app/BUILD.md`](../../../../ios-app/BUILD.md) (hier nicht behandelt) |
| **BLE‑Board** (nRF52 / Bluefruit) | Firmware (`.uf2`/DFU) | VSCode + PlatformIO **oder** Arduino‑Erweiterung |
| **Hauptplatine** (RP2040 / Pico) | Firmware (`.uf2`) | VSCode + PlatformIO **oder** Arduino‑Erweiterung |
| **Mechanische Teile** | **G‑Code** an einen 3D‑Drucker | ein **Slicer** (PrusaSlicer / Cura / OrcaSlicer / Bambu Studio) — *kein* Code‑Editor |

Die Boards führen **Arduino‑`.ino`**‑Sketches aus, also funktioniert jede Arduino‑kompatible Toolchain.
Unten ein VSCode‑basiertes Setup.

---

## 0. VSCode + eine Embedded‑Erweiterung installieren

Wähle **eines**:

- **PlatformIO IDE** (VSCode‑Erweiterung) — Toolchains, Board‑Manager, Serial Monitor und Debugger in
  einem. Am reproduzierbarsten. Bevorzugt ein `platformio.ini`‑Projekt (Beispiele unten).
- **Arduino‑Erweiterung für VSCode** (umhüllt die Arduino CLI) — am nächsten am ursprünglichen
  `.ino`‑Workflow; nutzt dieselben Board‑Pakete wie die Arduino IDE. Gut, um die `.ino` direkt zu öffnen.

(Für den einfachsten Weg funktioniert auch die **Arduino IDE** selbst mit denselben Board‑Paketen — VSCode ist optional.)

---

## 1. Board‑Support‑Pakete (einmalig)

| Board | Arduino‑Board‑Paket | PlatformIO |
|-------|---------------------|------------|
| Adafruit Feather/ItsyBitsy **nRF52840** | „**Adafruit nRF52**“ BSP (Boards Manager) | `platform = nordicnrf52`, `board = adafruit_feather_nrf52840` |
| Raspberry Pi **Pico / Pico 2** | „**Raspberry Pi Pico/RP2040** (arduino‑pico, by Earle Philhower)“ | `board_build.core = earlephilhower` (siehe Hinweis) |

> Die Sketches setzen den **arduino‑pico‑(Philhower‑)Core** voraus (sie nutzen `Serial1`, `Serial2`,
> `analogReadResolution` usw.) — *nicht* den Arduino‑„Mbed“‑Core.

---

## 2. nRF52‑BLE‑Board — flashen & testen

**Flashen (USB).** Die Adafruit‑nRF52‑Boards haben einen UF2‑Bootloader:

1. Board per USB verbinden.
2. **RESET‑Taste zweimal tippen** → ein USB‑Laufwerk wie `FTHR840BOOT` erscheint.
3. **PlatformIO:** `PlatformIO: Upload` (baut und flasht via `adafruit-nrfutil` über den Bootloader).
   **Arduino‑Erweiterung/IDE:** Board + Port wählen, **Upload** klicken. (Manuell: die gebaute `.uf2` aufs Boot‑Laufwerk ziehen.)

Beispiel `platformio.ini`:

```ini
[env:feather_nrf52840]
platform = nordicnrf52
board = adafruit_feather_nrf52840
framework = arduino
monitor_speed = 115200
upload_protocol = nrfutil
; Bluefruit (BLEUart, BLEDfu, …) gehört zum Adafruit-nRF52-Framework — kein lib_deps nötig
```

**Testen / Ausführen:**

- **Serial Monitor @ 115200** (PlatformIO: `PlatformIO: Monitor`; Arduino‑Erw.: Serial Monitor) für Debug‑Ausgaben.
- **BLE prüfen** mit einem BLE‑Scanner (**nRF Connect** oder **LightBlue**): es sollte als `bFaaaPSwitch_1`
  beworben werden und den Nordic‑UART‑Service `6E400001‑…` zeigen. Oder einfach mit der **bFaaaP‑iOS‑App** verbinden.
- **OTA‑Updates:** die Firmware enthält `BLEDfu`, sodass du nach dem ersten USB‑Flash auch drahtlos (DFU) aktualisieren kannst.

---

## 3. RP2040 / Pico Hauptplatine — flashen & testen

**Flashen (USB / BOOTSEL).**

1. **BOOTSEL** gedrückt halten und USB einstecken → ein Laufwerk `RPI‑RP2` erscheint.
2. **PlatformIO:** `PlatformIO: Upload`. **Arduino‑Erw./IDE:** Pico‑Board + Port → **Upload**.
   (Manuell: die `.uf2` auf `RPI‑RP2` ziehen.)
3. Nach dem ersten Flash kann der arduino‑pico‑Core ohne Taste über USB neu flashen.

Beispiel `platformio.ini` (arduino‑pico / Philhower‑Core):

```ini
[env:pico]
; Community-Plattform, die den Philhower-Core bündelt:
platform = https://github.com/maxgerhardt/platform-raspberrypi.git
board = pico            ; 'pico2' für Pico 2 / RP2350
framework = arduino
board_build.core = earlephilhower
monitor_speed = 115200
lib_deps =
    bogde/HX711         ; für die Load-Cell-Version
    ; (IQ-Motor-Version braucht zusätzlich die iq-module-communication-Bibliothek, siehe firmware/libraries)
```

**Testen / Ausführen:**

- **Serial Monitor @ 115200** zeigt die Ausgaben der Firmware (Sensorströme, Positionen, Kalibriermeldungen).
- **Ohne App betreiben:** die Hauptplatine empfängt normalerweise Bytes vom BLE‑Board über das kabelgebundene
  **UART (`Serial1`)**. Zum Bench‑Test entweder (a) das BLE‑Board verdrahten und `iNN` aus der iOS‑App/BLE‑Scanner
  senden, oder (b) Testbytes von einem USB‑UART‑Adapter in `Serial1` einspeisen.
- ⚠ Der neueste Schrittmotor‑Sketch (`v052B`) ist ein Entwicklungs‑Snapshot und kompiliert nicht unverändert —
  siehe die Hinweise in [`../../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md`](../../../../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md).

### Die `.ino`‑Dateien mit PlatformIO nutzen

PlatformIO erwartet normalerweise `src/main.cpp`. Um die Arduino‑Sketches zu nutzen, behalte den Sketch als
`src/<name>.ino` (PlatformIO akzeptiert `.ino` mit dem `arduino`‑Framework) **oder** benenne ihn in `.cpp` um und
füge `#include <Arduino.h>` hinzu. Die Arduino‑VSCode‑Erweiterung nutzt die `.ino`‑Dateien ohne Änderungen.

---

## 4. Bibliotheken‑Übersicht

| Firmware | Benötigt |
|----------|----------|
| BLE‑Board | **Bluefruit** (im Adafruit‑nRF52‑Framework enthalten) |
| Hauptplatine, IQ‑Version (v039B) | **HX711** + **iq‑module‑communication** (siehe `device-pro-acoustic/firmware/libraries/`) |
| Hauptplatine, Schrittmotor‑Version (v052B) | **HX711**; STEP/DIR braucht keine Motor‑Bibliothek (reines GPIO) oder die eigene Bibliothek eines Closed‑Loop‑Treibers |

---

## 5. 3D‑Drucker — slicen, nicht „Code flashen“

Ein 3D‑Drucker wird nicht wie ein Mikrocontroller programmiert. Du **slicest** ein Modell zu **G‑Code** und sendest diesen:

1. Öffne eine `.stl` aus [`../../device-pro-acoustic/hardware/3d-print/`](../../../../device-pro-acoustic/hardware/3d-print/)
   in einem **Slicer** (PrusaSlicer, Cura, OrcaSlicer oder Bambu Studio). Die `.3mf`‑Dateien tragen auch Referenz‑Druckeinstellungen.
2. Material, Schichthöhe, Infill, Stützen, Ausrichtung wählen; **slicen**.
3. **G‑Code senden** per SD‑Karte/USB‑Stick, USB‑Seriell oder über das Netzwerk (OctoPrint / Klipper / Bambu / Drucker‑UI).

VSCodes Rolle ist hier optional (es gibt G‑Code‑Vorschau‑Erweiterungen), aber das Slicen selbst geschieht in der Slicer‑GUI.

---

## 6. End‑to‑End‑Inbetriebnahme (Kurz‑Checkliste)

1. **BLE‑Board** (nRF52) flashen; in einem BLE‑Scanner `bFaaaPSwitch_1` bestätigen.
2. **Hauptplatine** (Pico) flashen; ihren Serial Monitor beobachten.
3. **BLE‑Board ↔ Pico** (UART) und gemeinsame Masse verdrahten; Motor/Treiber mit Strom versorgen.
4. Die **iOS‑App** bauen & ausführen (Xcode, eigenes Team); mit dem Gerät verbinden.
5. Kopf neigen → `iNN`/`N`/`F` im Monitor des BLE‑Boards sehen und den Motor bewegen.

## Referenzlinks

- PlatformIO — <https://platformio.org/>
- Arduino‑Erweiterung für VSCode — <https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.vscode-arduino>
- Adafruit‑nRF52‑Arduino‑BSP — <https://github.com/adafruit/Adafruit_nRF52_Arduino>
- arduino‑pico‑(Philhower‑)Core — <https://github.com/earlephilhower/arduino-pico>
- PlatformIO‑RP2040‑(Philhower‑)Plattform — <https://github.com/maxgerhardt/platform-raspberrypi>
- PrusaSlicer — <https://www.prusa3d.com/prusaslicer/> · OrcaSlicer — <https://github.com/SoftFever/OrcaSlicer> · Cura — <https://ultimaker.com/software/ultimaker-cura/>
