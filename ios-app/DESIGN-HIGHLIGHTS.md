# iOS app — design highlights (the clever bits)

> 日本語・ドイツ語版は後日 `i18n/` 配下に追加予定（English first）.

This file explains the non‑obvious engineering decisions that make bFaaaP feel
responsive and reliable. They are the parts worth understanding before changing
the code.

---

## 1. Decoupling AR sampling rate from BLE send rate  ★ most important

**Problem.** ARKit face tracking delivers a new head angle on every camera
frame (~60 fps, every ~16 ms). Bluetooth LE on this link cannot reliably absorb
60 writes per second — pushing every frame floods the channel and causes
stalls, lag, and dropped/garbled messages on the device side.

**Solution — sample, don't stream.** The AR delegate never sends the continuous
value directly. It only writes the latest angle into a shared variable:

```swift
// ARKitAngleDetection.session(_:didUpdate:)
self.leftY = leftYRadian.radiansToDegrees     // just store it, ~60 fps
```

The radio traffic is paced separately by a **100 ms timer** in `PlayView`,
which samples whatever the latest angle is and sends one message:

```swift
// PlayView.startTimer()  — fires every 0.10 s (10 Hz)
let v = min(99, Int(max(0, (-leftY) - Float(globalOffset)) * multiplier))
bleManager.sendString(sendText: String(format: "i%02d", v))   // "i00".."i99"
```

So AR runs fast, BLE runs slow, and they meet through one shared variable. The
sender is rate‑limited to a comfortable 10 Hz regardless of camera speed.

**History / tuning.** The interval was originally as low as **5 ms** and was
deliberately raised to **100 ms** after real‑device testing, because the faster
cadence produced communication bugs. In other words: *the AR extraction is
faster than BLE can transmit, so a delay is inserted to keep the iOS↔device
communication bug‑free.* This single decision is the backbone of the system's
stability.

The discrete on/off events use the same principle with a tighter guard
(`> 0.01 s`, i.e. 10 ms) so a press/release is never sent more than ~once per
10 ms.

## 2. Hysteresis on pedal engage/release (no chatter)

A pedal that toggles every time the angle wobbles across the threshold would
buzz. The engage and release thresholds are intentionally **different**:

```swift
if (-Int(leftY) >= globalOffset)      && pedalState == .off { send "N"; .on }
if (-Int(leftY) <  globalOffset - 1)  && pedalState == .on  { send "F"; .off }
```

The `- 1` creates a small **dead band**, and the `pedalState` guard makes the
events **edge‑triggered** (exactly one `N` per press, one `F` per release).
Together they eliminate chatter around the threshold.

## 3. Angle → value mapping with user multiplier and clamping

```
value = clamp( (−headAngle − offset) × multiplier , 0 … 99 )
```

- `offset` is the calibrated "zero" (neutral head position).
- `multiplier` (slider, 0–20) tunes sensitivity for each user / mounting.
- Clamping to `0–99` keeps the compact 2‑digit `iNN` wire format.

> **Patented method.** Generating the pedal signal from these **two presets —
> the angular offset (dead‑zone) and the multiplier**, which together fix a secondary
> **response speed** — is the project's patented technique (JP **特許第6726319号 / 第7004771号**).
> If you reuse it, see the licensing note in the publishing checklist.

## 4. Fire‑and‑forget BLE writes (`.withoutResponse`)

```swift
peripheral.writeValue(sendData, for: characteristic, type: .withoutResponse)
```

No per‑write acknowledgement round‑trip → minimal latency, which matters for a
real‑time pedal. This is only safe because the app already rate‑limits itself
(see #1); the two decisions are designed together.

## 5. Name‑filtered discovery + multi‑channel

The central connects **only** to peripherals advertising a known name
(`bFaaaPSwitch_1…4`) that matches the selected channel, so it never mis‑connects
to unrelated BLE devices nearby (verified on‑device: ResMed/Yamaha/etc. are
ignored). Up to **4 channels** let several devices/users coexist; a channel is
renamed by sending a single byte `W`/`X`/`Y`/`Z`.

## 6. On‑type / Off‑type behavior switch (`n` / `f`)

The device supports two pedal logics (sustain‑on‑tilt vs. sustain‑off‑tilt),
toggled from the app by sending `n` or `f`, to suit different pianos/use cases.

## 7. Screen always‑on during play

```swift
UIApplication.shared.isIdleTimerDisabled = true
```

For a foot‑free assistive instrument the display and camera must never sleep
mid‑performance; the flag is set on launch and on scene activation, and cleared
when backgrounded.

## 8. Simple UI with hidden setup gestures

The target users benefit from a minimal interface, so advanced actions hide
behind gestures — e.g. a **5‑tap** gesture jumps straight to play
(`.onTapGesture(count: 5)`), keeping the normal screen uncluttered.

## 9. Persisted calibration & channel

The selected channel, device name, and on/off‑type are stored in `UserDefaults`
so the setup survives app restarts.

## 10. Robust auto‑reconnect

On disconnect the central immediately resumes scanning
(`scanForPeripherals()`), so a brief BLE drop during a performance recovers
without user action.

## 11. Clear engage feedback (white → red)

The play screen is **white at rest and turns red the moment the head passes the
threshold** (pedal engaged), giving the player immediate, glanceable
confirmation; head up → back to white. This is the **same app for both Pro and
Switch** — only the device on the other end of the BLE link differs (a motor for
Pro, an electronic switch for Switch).

---

### If you change one thing, read this first

Items **#1 and #4 are a pair**: the fire‑and‑forget writes are only safe
because the app paces itself. If you lower the timer interval or remove the
throttle, restore an acknowledgement/backpressure mechanism or you will
reintroduce the communication bugs that motivated the 5 ms → 100 ms change.
