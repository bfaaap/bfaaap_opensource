# Architecture

## Signal chain

1. **Head tracking (iOS).** The controller app uses ARKit `ARFaceTrackingConfiguration`
   (TrueDepth camera) to read the user's head pitch angle.
2. **Mapping.** The angle is multiplied by a user "multiplier" (slider, 0–20) and
   clamped to `0–99`.
3. **Transmission (BLE).** The value is sent as an ASCII string `i00`–`i99` over a
   **Nordic UART Service (NUS)**. Engage/release transitions also send marker
   bytes `N` (on) and `F` (off).
4. **Actuation (device).** The Pico firmware parses the value and commands the
   **IQ / Fortiq** motor to press the sustain pedal proportionally.

## BLE details (observed)

| Item | Value |
|------|-------|
| Service (NUS) | `6E400001-B5A3-F393-E0A9-E50E24DCCA9E` |
| Write (RX, app→device) | `6E400002-B5A3-F393-E0A9-E50E24DCCA9E` |
| Notify (TX, device→app) | `6E400003-B5A3-F393-E0A9-E50E24DCCA9E` |
| Also present | DFU `00001530-…`, Device Information `180A`, Battery `180F` |
| Advertised name | `bFaaaPSwitch_1` (renameable `_1`..`_4` for multiple devices/channels) |

The app filters on the advertised local name so it connects only to a
`bFaaaPSwitch_n` device and ignores other nearby peripherals.

## Payload format

- `iNN` — target value, `NN` = `00`..`99` (angle × multiplier, clamped).
- `N` — engage signal (pedal active).
- `F` — release signal (pedal returns to neutral).
- Values are streamed on a timer (~100 ms cadence in current firmware/app).
