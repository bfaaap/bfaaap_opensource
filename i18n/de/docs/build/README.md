# 🔧 Selbst bauen

> 🌐 [English](../../../../docs/build/README.md) · [日本語](../../../ja/docs/build/README.md) · **Deutsch**

bFaaaP ist Open Source — du kannst die **iOS‑App** und beide Geräte bauen. Dieser Hub führt zu jeder
Spur. Begriffe unklar? Zuerst [Glossar](../GLOSSARY.md) und [Funktionsweise](../how-it-works.md). Die
Quelldatei zu jedem Teil/Bild/Code findest du in der [Quellenübersicht](../../../../docs/SOURCE-MAP.md).
Hängengeblieben? Frag im [KI‑gestützten Support](../ai-support.md).

![Pro für akustische, Switch für digitale Klaviere](../../../../docs/media/illustrations/intl-pro-switch.png)

## Wähle deine Spur

| Spur | Du brauchst | Schritt‑für‑Schritt | Detail‑Referenz |
|------|-------------|---------------------|-----------------|
| 📱 **iOS‑App** (für beide Geräte nötig) | Mac + Xcode + iPhone/iPad mit Face ID | **[→ iOS‑App bauen](ios.md)** | [`ios-app/`](../../../../ios-app/) |
| 🎹 **Pro** (akustisches Klavier) | 3D‑Drucker, Löten, Motor + Boards | **[→ Pro bauen](pro.md)** | [`device-pro-acoustic/`](../../../../device-pro-acoustic/) |
| 🎛️ **Switch** (Digitalklavier) | die Boards + ein Pedalbuchsen‑Anschluss | **[→ Switch bauen](switch.md)** | [`device-switch-electronic/`](../../../../device-switch-electronic/) |

## Das große Ganze
```
[ iOS‑App bauen & installieren ]  ──┐
                                    ├─▶ per Bluetooth koppeln ──▶ freihändig spielen
[ Gerät bauen: Pro oder Switch ] ───┘
```

1. **App bauen** (alle) — eigenes Signing‑Team & Bundle‑ID setzen, auf dem eigenen Gerät installieren.
2. **Gerät bauen** — Pro (Motor + Airback für akustisch) oder Switch (elektronisch für digital).
3. **Firmware flashen** — [`docs/toolchain/`](../../../../docs/toolchain/).
4. **Koppeln, kalibrieren, spielen** — [`docs/operation/`](../../../../docs/operation/) und [`docs/user-manual/`](../../../../docs/user-manual/).

> 🚧 **Entwurf:** die obigen Schritt‑für‑Schritt‑Anleitungen sind erste Entwürfe — einige genaue
> Pin‑Belegungen und mechanische Maße werden noch von den Bauenden (Narusawa / Taguchi) ergänzt. Die
> Videos — besonders der **[Pro‑Einrichtungs‑Walkthrough](https://www.youtube.com/watch?v=_9YopbCYTmI)**
> — zeigen den echten Ablauf. Vollständige Liste: [Videoführer](../../../../docs/videos/).
