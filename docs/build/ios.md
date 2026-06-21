# 📱 Build the **iOS app**

The app is required for **both** devices (Pro and Switch). It reads your head angle with Face‑ID
face tracking and sends pedal commands over Bluetooth. You can also just **download it** from the
App Store — building from source is for developers who want to customise or contribute.

> Reference: [`ios-app/BUILD.md`](../../ios-app/BUILD.md) · [`ios-app/CODE-STRUCTURE.md`](../../ios-app/CODE-STRUCTURE.md) · [`ios-app/DESIGN-HIGHLIGHTS.md`](../../ios-app/DESIGN-HIGHLIGHTS.md)

```
 1. Prereqs ─▶ 2. Open the project ─▶ 3. Set your signing ─▶ 4. Build to a device ─▶ 5. Permissions ─▶ 6. Pair & tune
```

## Step 0 — What you need
- A **Mac** with **Xcode 15+**
- An **iPhone/iPad with a TrueDepth (Face ID) camera** — required for head tracking (the Simulator can't do it)
- A free **Apple ID** is enough to install on your own device (a paid Apple Developer account is only needed to distribute)

## Step 1 — Get the source
Clone the repo and open the Xcode project:
```sh
git clone https://github.com/TomoShishido/bfaaap_opensource.git
open bfaaap_opensource/ios-app/src/bFaaaPSwitch1.xcodeproj
```

## Step 2 — Set your signing
In Xcode: select the project → **Signing & Capabilities** → choose **your Team** and change the
**Bundle Identifier** to something unique (the published one is sanitised to `com.example.bfaaap`).

## Step 3 — Build & run on your device
Connect the iPhone/iPad by USB, select it as the run destination, and press **Run** (▶). On
first launch, **allow Camera (face tracking)** and **Bluetooth** when prompted.

## Step 4 — Pair & tune
Turn on the bFaaaP device, connect from the app, and set your **threshold** (how far to tilt) and
**response speed**. See the BLE flow in [`ios-app/BLE-CONNECTION-FLOW.md`](../../ios-app/BLE-CONNECTION-FLOW.md)
and operation in [`docs/operation/`](../operation/).

> Prefer not to build? Get it on the **App Store**: <https://apps.apple.com/jp/app/bfaaapswitch/id1545866059>

---
→ [Build hub](README.md) · [Pro build](pro.md) · [Switch build](switch.md)
