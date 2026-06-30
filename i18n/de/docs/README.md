# Dokumentation (gemeinsam)

Übergreifende Dokumente, die für beide Hardware‑Linien und die iOS‑App gelten.

- [`architecture/`](architecture/) — wie das System von Anfang bis Ende funktioniert:
  Signale, BLE / Nordic‑UART‑Protokoll, das AR→BLE‑Timing‑Modell.
- [`operation/`](operation/) — wie man das System einrichtet und im Alltag betreibt.
- [`toolchain/`](toolchain/) — VSCode‑zentrierte Anleitung zum **Flashen der Boards**
  (nRF52 + RP2040), zum Testen/Ausführen und zum **3D‑Druck‑Slicing**.
- [`user-manual/`](user-manual/) — Endbenutzer‑Handbuch (Verbinden, Kanal, On/Off‑Typ,
  Winkelschwelle), angepasst aus dem öffentlichen Handbuch.
- [`HISTORY.md`](HISTORY.md) — wie bFaaaP begann (2018) und sich entwickelte.
- [`members/`](members/) — die Menschen hinter bFaaaP (mit Karikaturen).
- [`videos/`](videos/) — Leitfaden zu allen YouTube‑Videos, nach Kategorie (Konzerte,
  Einrichtung, Handbuch, Promotion), neueste zuerst.
- [`../bfaaap_patent_info/`](../../../bfaaap_patent_info/) — die **Patente**: das englische
  PCT, die zwei erteilten japanischen Patente, Zitate zum Stand der Technik und ein
  allgemein verständlicher [Patent‑Leitfaden](../../../bfaaap_patent_info/general_description/README.md)
  (Ablaufdiagramme, datierte Erteilungsakten, akademische Erkenntnisse).

Gerätespezifischer Aufbau/Montage liegt beim jeweiligen Gerät, z. B.
[`../device-pro-acoustic/assembly/`](../../../device-pro-acoustic/assembly/).

Die iOS‑Code‑Dokumentation befindet sich in [`../ios-app/`](../../../ios-app/)
(`CODE-STRUCTURE.md`, `DESIGN-HIGHLIGHTS.md`, `BUILD.md`).

> Lokalisierung: zuerst Englisch; japanische und deutsche Versionen sind in separaten
> `i18n/`‑Unterordnern geplant.

---
**Lizenz (übernommen):** Die Dokumentation wird unter **CC‑BY‑4.0** veröffentlicht. Siehe [`../LICENSE`](../../../LICENSE).
