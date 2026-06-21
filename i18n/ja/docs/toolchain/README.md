# ツールチェーン —— 書き込み・テスト・実行（VSCode 中心）

> 🌐 [English](../../../../docs/toolchain/README.md) · **日本語** · [Deutsch](../../../de/docs/toolchain/README.md)

本プロジェクトには **3つのビルドターゲット**があり、それぞれ専用のツールがあります：

| ターゲット | 「書く/書き込む」もの | ツール |
|--------|------------------------|------|
| **iOSアプリ** | iPhone/iPad への署名済みアプリ | **Mac の Xcode** → [`../../ios-app/BUILD.md`](../../../../ios-app/BUILD.md)（ここでは扱いません） |
| **BLEボード**（nRF52 / Bluefruit） | ファームウェア（`.uf2`/DFU） | VSCode + PlatformIO **または** Arduino拡張 |
| **メインボード**（RP2040 / Pico） | ファームウェア（`.uf2`） | VSCode + PlatformIO **または** Arduino拡張 |
| **機構部品** | 3Dプリンタへの **G‑code** | **スライサー**（PrusaSlicer / Cura / OrcaSlicer / Bambu Studio）—— コードエディタ*ではない* |

ボードは **Arduino `.ino`** スケッチを動かすので、Arduino互換のツールチェーンならどれでも使えます。以下は
VSCode ベースの構成です。

---

## 0. VSCode ＋ 組み込み拡張を1つ導入

次のどちらかを選びます：

- **PlatformIO IDE**（VSCode拡張）—— ツールチェーン・ボードマネージャ・シリアルモニタ・デバッガが一体。
  最も再現性が高い。`platformio.ini` プロジェクトを好みます（例は後述）。
- **VSCode 用 Arduino拡張**（Arduino CLI のラッパー）—— 元の `.ino` ワークフローに最も近く、Arduino IDE と
  同じボードパッケージを使う。`.ino` をそのまま開きたい場合に。

（最も簡単な経路なら、**Arduino IDE** 単体でも同じボードパッケージで動きます —— VSCode は任意。）

---

## 1. ボードサポートパッケージ（最初に1回）

| ボード | Arduino ボードパッケージ | PlatformIO |
|-------|-----------------------|------------|
| Adafruit Feather/ItsyBitsy **nRF52840** | 「**Adafruit nRF52**」BSP（Boards Manager） | `platform = nordicnrf52`, `board = adafruit_feather_nrf52840` |
| Raspberry Pi **Pico / Pico 2** | 「**Raspberry Pi Pico/RP2040**（arduino‑pico, by Earle Philhower）」 | `board_build.core = earlephilhower`（注記参照） |

> スケッチは **arduino‑pico（Philhower）コア**前提です（`Serial1`・`Serial2`・`analogReadResolution` 等を
> 使用）—— Arduino の「Mbed」コアではありません。

---

## 2. nRF52 BLEボード —— 書き込み＆テスト

**書き込み（USB）。** Adafruit nRF52 ボードは UF2 ブートローダ搭載：

1. ボードを USB 接続。
2. **RESET ボタンを2回押す** → `FTHR840BOOT` のような USB ドライブが現れる。
3. **PlatformIO:** `PlatformIO: Upload`（`adafruit-nrfutil` でブートローダ経由書込）。
   **Arduino拡張/IDE:** ボードとポートを選び **Upload**。（手動の代替：ビルド済み `.uf2` をブートドライブにドラッグ。）

`platformio.ini` 例：

```ini
[env:feather_nrf52840]
platform = nordicnrf52
board = adafruit_feather_nrf52840
framework = arduino
monitor_speed = 115200
upload_protocol = nrfutil
; Bluefruit (BLEUart, BLEDfu, …) は Adafruit nRF52 フレームワークに同梱 —— lib_deps 不要
```

**テスト/実行：**

- **シリアルモニタ @115200**（PlatformIO: `PlatformIO: Monitor` / Arduino拡張: Serial Monitor）でデバッグ出力を確認。
- **BLE 確認**：スマホの BLE スキャナ（**nRF Connect** や **LightBlue**）で `bFaaaPSwitch_1` のアドバタイズと
  Nordic UART サービス `6E400001‑…` が見えるはず。または **bFaaaP iOSアプリ**で接続。
- **OTA 更新**：ファームに `BLEDfu` を含むので、初回 USB 書込後は nRF Connect（DFU）で無線更新も可能。

---

## 3. RP2040 / Pico メインボード —— 書き込み＆テスト

**書き込み（USB / BOOTSEL）。**

1. **BOOTSEL** ボタンを押しながら USB 接続 → `RPI‑RP2` ドライブが現れる。
2. **PlatformIO:** `PlatformIO: Upload`。**Arduino拡張/IDE:** Pico ボード＋ポートを選び **Upload**。
   （手動の代替：`.uf2` を `RPI‑RP2` にドラッグ。）
3. 初回書込後は、arduino‑pico コアがボタンなしで USB 再書込できます。

`platformio.ini` 例（arduino‑pico / Philhower コア）：

```ini
[env:pico]
; Philhower コアを同梱するコミュニティプラットフォーム:
platform = https://github.com/maxgerhardt/platform-raspberrypi.git
board = pico            ; Pico 2 / RP2350 は 'pico2'
framework = arduino
board_build.core = earlephilhower
monitor_speed = 115200
lib_deps =
    bogde/HX711         ; ロードセル版用
    ; (IQモーター版は iq-module-communication ライブラリも必要。firmware/libraries 参照)
```

**テスト/実行：**

- **シリアルモニタ @115200** にファームの出力（センサー電流・位置・校正メッセージ）が出ます。
- **アプリ無しで動かす**：メインボードは通常、有線 **UART（`Serial1`）**で BLEボードからバイトを受けます。
  机上テストは (a) BLEボードを配線して iOSアプリ/BLEスキャナから `iNN` を送る、または (b) USB‑UART アダプタから
  テストバイトを `Serial1` に流す。
- ⚠ 最新のステッパスケッチ（`v052B`）は開発スナップショットで無改変ではコンパイルできません ——
  [`../../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md`](../../../../device-pro-acoustic/firmware/DESIGN-HIGHLIGHTS.md) の注意参照。

### PlatformIO で `.ino` を使う

PlatformIO は通常 `src/main.cpp` を期待します。Arduino スケッチを使うには、`src/<name>.ino` のまま置く
（`arduino` フレームワークで `.ino` 可）か、`.cpp` に改名して `#include <Arduino.h>` を追加。Arduino VSCode
拡張は `.ino` をそのまま使えます。

---

## 4. ライブラリまとめ

| ファームウェア | 必要なもの |
|----------|-------|
| BLEボード | **Bluefruit**（Adafruit nRF52 フレームワーク同梱） |
| メイン・IQ版（v039B） | **HX711** ＋ **iq‑module‑communication**（`device-pro-acoustic/firmware/libraries/` 参照） |
| メイン・ステッパ版（v052B） | **HX711**；STEP/DIR は素の GPIO（モーターライブラリ不要）、または閉ループドライバ専用ライブラリ |

---

## 5. 3Dプリンタ —— 「コード書込」ではなくスライス

3Dプリンタはマイコンのようにプログラムしません。モデルを **G‑code** に**スライス**して送ります：

1. [`../../device-pro-acoustic/hardware/3d-print/`](../../../../device-pro-acoustic/hardware/3d-print/) の `.stl` を
   **スライサー**（PrusaSlicer, Cura, OrcaSlicer, Bambu Studio）で開く。`.3mf` には参考印刷設定も入っています。
2. 材料・積層高・インフィル・サポート・向きを選び、**スライス**。
3. **G‑code を送る**：SD/USB、USB シリアル、ネットワーク（OctoPrint / Klipper / Bambu / プリンタUI）で。

VSCode の役割は任意（G‑code プレビュー拡張あり）ですが、スライス自体はスライサーGUIで行います。

---

## 6. エンドツーエンドの立ち上げ（クイックチェックリスト）

1. **BLEボード**（nRF52）を書込；BLEスキャナで `bFaaaPSwitch_1` のアドバタイズを確認。
2. **メインボード**（Pico）を書込；シリアルモニタを監視。
3. **BLEボード ↔ Pico**（UART）と共通GNDを配線；モーター/ドライバに給電。
4. **iOSアプリ**をビルド・実行（Xcode、自分のTeam）；装置に接続。
5. 頭を傾ける → BLEボードのモニタで `iNN`/`N`/`F` を確認し、モーターが動く。

## 参考リンク

- PlatformIO — <https://platformio.org/>
- VSCode 用 Arduino拡張 — <https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.vscode-arduino>
- Adafruit nRF52 Arduino BSP — <https://github.com/adafruit/Adafruit_nRF52_Arduino>
- arduino‑pico（Philhower）コア — <https://github.com/earlephilhower/arduino-pico>
- PlatformIO RP2040（Philhower）プラットフォーム — <https://github.com/maxgerhardt/platform-raspberrypi>
- PrusaSlicer — <https://www.prusa3d.com/prusaslicer/> · OrcaSlicer — <https://github.com/SoftFever/OrcaSlicer> · Cura — <https://ultimaker.com/software/ultimaker-cura/>
