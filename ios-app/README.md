# iOS controller app (bFaaaP Pro & Switch)

The SwiftUI app that reads the user's head angle (ARKit / TrueDepth) and streams
it over Bluetooth LE to the pedal device.

**One app, both hardware lines.** The same iOS app drives **bFaaaP Pro** (for
acoustic pianos) and **bFaaaP Switch** (for electric pianos / keyboards). The
BLE protocol is identical; only the device hardware differs.

## Contents

| File / folder | What |
|---------------|------|
| [`CODE-STRUCTURE.md`](CODE-STRUCTURE.md) | How the Swift files fit together + data flow |
| [`DESIGN-HIGHLIGHTS.md`](DESIGN-HIGHLIGHTS.md) | The clever bits (AR↔BLE timing, hysteresis, …) |
| [`BLE-CONNECTION-FLOW.md`](BLE-CONNECTION-FLOW.md) | Flowcharts: recognize device by name (4 channels), connect, and the sync→async handoff |
| [`BUILD.md`](BUILD.md) | How to build it yourself (set your own team & bundle ID) |
| [`src/`](src/) | The Xcode project (sanitized: blank team, placeholder bundle ID) |
| [`app-store/`](app-store/) | App Store listing info, icon & screenshots ([on the App Store](https://apps.apple.com/jp/app/bfaaapswitch/id1545866059)) |

## App facts

| Item | Value |
|------|-------|
| Display name | **bFaaaP Pro & Switch** (on‑device + App Store; Xcode target stays `bFaaaPSwitch1`) |
| Bundle ID (in repo) | `com.example.bfaaap` (placeholder — set your own) |
| Min iOS | 14.5 |
| Language / UI | Swift 5, SwiftUI |
| Key frameworks | ARKit (face tracking), CoreBluetooth (BLE) |
| Requires | Device with a TrueDepth front camera |

Start with [`CODE-STRUCTURE.md`](CODE-STRUCTURE.md), then
[`DESIGN-HIGHLIGHTS.md`](DESIGN-HIGHLIGHTS.md), then build via [`BUILD.md`](BUILD.md).

---
**License (adopted):** the iOS app source is released under the **Apache License 2.0** (explicit patent grant). See [`../LICENSE`](../LICENSE).
