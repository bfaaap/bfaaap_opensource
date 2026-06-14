# Documentation (shared)

Cross‑cutting docs that apply to both hardware lines and the iOS app.

- [`architecture/`](architecture/) — how the system works end to end: signals,
  BLE / Nordic UART protocol, the AR→BLE timing model.
- [`operation/`](operation/) — how to set up and operate the system day to day.
- [`toolchain/`](toolchain/) — VSCode‑centric guide to **flashing the boards**
  (nRF52 + RP2040), testing/running, and **3D‑print slicing**.
- [`user-manual/`](user-manual/) — end‑user manual (connect, channel, on/off‑type,
  angle threshold) adapted from the public manual.
- [`HISTORY.md`](HISTORY.md) — how bFaaaP started (2018) and evolved.
- [`members/`](members/) — the people behind bFaaaP (with caricatures).
- [`videos/`](videos/) — guide to all YouTube videos, by category (concerts,
  setup, manual, promotion), newest first.
- [`../bfaaap_patent_info/`](../bfaaap_patent_info/) — the **patents**: the English
  PCT, the two granted Japanese patents, prior‑art citations, and a plain‑language
  [patent guide](../bfaaap_patent_info/general_description/README.md) (procedure
  diagrams, dated prosecution histories, academic take‑aways).

Line‑specific build/assembly lives with each device, e.g.
[`../device-pro-acoustic/assembly/`](../device-pro-acoustic/assembly/).

iOS code documentation is in [`../ios-app/`](../ios-app/)
(`CODE-STRUCTURE.md`, `DESIGN-HIGHLIGHTS.md`, `BUILD.md`).

> Localization: English first; Japanese and German versions are planned in
> separate `i18n/` subfolders.

---
**License (proposed, pending final decision):** documentation is intended to be released under **CC‑BY‑4.0**. See [`../LICENSE`](../LICENSE).
