# Building the iOS app

> 日本語・ドイツ語版は後日 `i18n/` 配下に追加予定（English first）.

The full Xcode project is in [`src/`](src/). It has been sanitized for public
use: **signing team is blank** and the **bundle identifier is a placeholder**.
Another Apple Developer can build it by adding their own team and ID.

## Requirements

- macOS with a recent **Xcode**.
- An **Apple Developer account** (free account is enough to run on your own device).
- A test device with a **TrueDepth front camera** (Face ID class). The iOS
  **Simulator cannot run face tracking**, so on‑device is required to actually use it.

## Steps

1. Open `src/bFaaaPSwitch1.xcodeproj` in Xcode.
2. Select the **bFaaaPSwitch1** target → **Signing & Capabilities**:
   - Set **Team** to your own (it is intentionally empty in this repo).
   - Change **Bundle Identifier** from the placeholder `com.example.bfaaap`
     to one you own, e.g. `com.yourname.bfaaap`.
   - Signing is **Automatic**; Xcode will create a development profile for you.
3. Connect a TrueDepth device, select it as the run destination.
4. **Build & Run** (⌘R). Grant the **Camera** and **Bluetooth** permissions when prompted.
5. Pair with a powered‑on bFaaaP device (advertised as `bFaaaPSwitch_1`) and play.

## What was changed for publication

| Setting | In this repo | Original (private) |
|---------|--------------|--------------------|
| `DEVELOPMENT_TEAM` | empty (`""`) | a specific team ID |
| `PRODUCT_BUNDLE_IDENTIFIER` | `com.example.bfaaap` | the author's reverse‑DNS ID |
| `xcuserdata`, signing certs, profiles, API keys | removed / never included | — |

Author attribution in source headers is intentionally kept.

## Notes

- Deployment target is **iOS 14.5**; the project builds cleanly against current
  iOS SDKs (verified on Xcode 26 / iOS 26 SDK).
- iCloud and Push capabilities were removed (the app does not use them); only
  Camera and Bluetooth permissions are required (declared in `Info.plist`).
- See [`CODE-STRUCTURE.md`](CODE-STRUCTURE.md) and
  [`DESIGN-HIGHLIGHTS.md`](DESIGN-HIGHLIGHTS.md) to understand the code.
