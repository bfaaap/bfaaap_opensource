# iOS app — code structure

> 日本語・ドイツ語版は後日 `i18n/` 配下に追加予定（English first）.

The controller is a small SwiftUI app. Only **11 Swift files** are actually
compiled into the shipping target; the rest (`*Test*.swift`, `Test/…`) are
experiments left in the tree and are **not** in the build phase.

## Data flow (one picture)

```
   TrueDepth camera
        │
        ▼
ARKitAngleDetection  ──(updates @Binding leftY, ~60 fps)──┐
   │  (ARSessionDelegate)                                  │
   │  on threshold crossing → send "N"/"F" (10 ms throttle)│
   ▼                                                       ▼
BLEManager.sendString ◀── PlayView.startTimer() samples leftY every 100 ms
   │                       → "i00".."i99" (angle × multiplier, clamped)
   ▼
CoreBluetooth writeValue(.withoutResponse)  ──BLE/NUS──▶  pedal driver device
```

The key idea: **ARKit produces head angles far faster than BLE should send
them.** `ARKitAngleDetection` only writes the latest angle into a shared
`leftY`; the actual radio traffic is paced by a 100 ms timer in `PlayView`
(continuous value) and a 10 ms throttle in the AR delegate (on/off events).
See [`DESIGN-HIGHLIGHTS.md`](DESIGN-HIGHLIGHTS.md) #1.

## Files and responsibilities

| File | Role |
|------|------|
| `bFaaaPSwitch1App.swift` | `@main` entry. `AppDelegate` keeps the screen awake (`isIdleTimerDisabled = true`) so the camera never sleeps mid‑play. Hosts `ContentView`. |
| `ContentView.swift` | Thin wrapper that shows `PlayView`. |
| `PlayView.swift` | **Central hub.** Owns `GlobalManager`, drives the UI state machine (`ViewID`: connect_ble / start_play / show_support / edit_channel), runs the **100 ms send timer** (`startTimer`), starts/stops AR, owns the sensitivity slider (multiplier), and the channel‑selection UI. |
| `GlobalManager.swift` | `ObservableObject` holding the `BLEManager`, `AppSetting`, and the list of `SwitchDevice` (`bFaaaPSwitch_1…4`). |
| `AppSetting.swift` | Defines `ViewID`. Persists settings to `UserDefaults` (`BLEName`, `selectedIndex`, `isSwitchOnType`) and holds `connectToLocalName` (the device to connect to). |
| `BLEManager.swift` | CoreBluetooth central. Scans, **filters by known names** (`bFaaaPSwitch_1…4`), connects to `connectToLocalName`, discovers the Nordic UART service, and writes with `writeValue(.withoutResponse)`. Helpers: `changeChannel` (W/X/Y/Z), `changeSwitchType` (n/f). |
| `ARKit/ARKitAngleDetection.swift` | `ARSessionDelegate`. Reads head pitch into `leftY` every frame; emits `N`/`F` engage/release signals with hysteresis + a 10 ms throttle. |
| `DeviceCache.swift` | `SwitchDevice` model + registry/selection of the four channels. |
| `SupportPageView.swift` | In‑app help / support page. |
| `DebugFunctions/Debug.swift` | `debugLog` helper. |
| `PlayViewTest.swift` | Experimental view (compiled but effectively unused). |

### Not compiled into the target

`bfaaapSwitchNameTest*.swift`, `Test/SupportPageViewTest.swift`, and the
`SettingView`/`SelectPDF`/`QRReader`/`PDFView`/`AudioManager` files are present in
the folder but are **not** in the Xcode "Compile Sources" build phase of this
"Pro" target. They are kept for reference only.

## State machine (`ViewID`)

```
connect_ble  ──(device found / channel chosen)──▶  start_play
   ▲                                                   │
   └───────────────(disconnect / change channel)───────┘
start_play  ──(help)──▶  show_support
start_play  ──(edit)──▶  edit_channel
```

## BLE protocol (app → device)

| Bytes | Meaning |
|-------|---------|
| `iNN` | target value `00`–`99` (angle × multiplier, clamped) — sent every 100 ms |
| `N` | engage (pedal down) — edge event |
| `F` | release (pedal up) — edge event |
| `W` `X` `Y` `Z` | rename device to `bFaaaPSwitch_1…4` (channel) |
| `n` `f` | switch device to on‑type / off‑type behavior |

See [`../docs/architecture/`](../docs/architecture/) for the full BLE/GATT detail,
and [`BLE-CONNECTION-FLOW.md`](BLE-CONNECTION-FLOW.md) for flowcharts of name
recognition (4 channels), connection, and the sync→async handoff.
