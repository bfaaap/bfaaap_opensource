# 🔧 Build it yourself

bFaaaP is open source — you can build the **iOS app** and either device. This hub points to
each build track. New to the terms? See the [glossary](../GLOSSARY.md) and
[how it works](../how-it-works.md) first. Stuck? ask in [AI‑assisted Support](../ai-support.md).

![Pro for acoustic pianos, Switch for digital pianos](../media/illustrations/intl-pro-switch.png)

## Choose your track

| Track | You need | Step‑by‑step guide | Detailed reference |
|-------|----------|--------------------|--------------------|
| 📱 **iOS app** (required for both devices) | a Mac + Xcode + an iPhone/iPad with Face ID | **[→ Build the iOS app](ios.md)** | [`../../ios-app/`](../../ios-app/) |
| 🎹 **Pro** (acoustic piano) | 3D printer, soldering, the motor + boards | **[→ Build the Pro](pro.md)** | [`../../device-pro-acoustic/`](../../device-pro-acoustic/) |
| 🎛️ **Switch** (digital piano) | the boards + a pedal‑jack connection | **[→ Build the Switch](switch.md)** | [`../../device-switch-electronic/`](../../device-switch-electronic/) |

## The big picture
```
[ Build & install the iOS app ]  ──┐
                                   ├─▶  pair over Bluetooth  ──▶  play hands‑free
[ Build a device: Pro or Switch ] ─┘
```

1. **Build the app** (everyone) — set your own signing team & bundle ID, install on your device.
2. **Build a device** — Pro (motor + airback for acoustic) or Switch (electronic for digital).
3. **Flash the firmware** to the boards — see [`../toolchain/`](../toolchain/).
4. **Pair, calibrate, and play** — see [`../operation/`](../operation/) and [`../user-manual/`](../user-manual/).

> 🚧 **Draft:** the step‑by‑step guides above are first drafts — a few exact pinouts and
> mechanical dimensions are still being filled in from the makers (Narusawa / Taguchi). The
> videos — especially the **[Pro setup walkthrough](https://www.youtube.com/watch?v=_9YopbCYTmI)**
> — show the real process. See the full [video guide](../videos/).
