# ドキュメント（共通）

両方のハードウェアラインと iOS アプリの両方に関わる、横断的なドキュメントです。

- [`architecture/`](architecture/) —— システムが端から端までどう動くか：信号、
  BLE / Nordic UART プロトコル、AR→BLE のタイミングモデル。
- [`operation/`](operation/) —— システムの設置と日々の運用のしかた。
- [`toolchain/`](toolchain/) —— **ボードの書き込み**（nRF52 + RP2040）、テスト・実行、
  **3Dプリントのスライス**を扱う、VSCode 中心のガイド。
- [`user-manual/`](user-manual/) —— 公開マニュアルをもとにしたエンドユーザー向けマニュアル
  （接続、チャンネル、on/off タイプ、角度しきい値）。
- [`HISTORY.md`](HISTORY.md) —— bFaaaP がどう始まり（2018年）、どう発展してきたか。
- [`members/`](members/) —— bFaaaP を支える人々（似顔絵つき）。
- [`videos/`](videos/) —— すべての YouTube 動画のガイド。カテゴリ別（演奏会、設置、
  マニュアル、紹介）、新しい順。
- [`../bfaaap_patent_info/`](../../../bfaaap_patent_info/) —— **特許**：英語 PCT、
  登録済みの日本特許2件、先行技術の引用、そして平易な言葉の
  [特許ガイド](../../../bfaaap_patent_info/general_description/README.md)（手続図、
  日付つきの審査経過、学術的な要点）。

ライン固有のビルド／組立は各デバイス側にあります。例：
[`../device-pro-acoustic/assembly/`](../../../device-pro-acoustic/assembly/)。

iOS のコードドキュメントは [`../ios-app/`](../../../ios-app/) にあります
（`CODE-STRUCTURE.md`、`DESIGN-HIGHLIGHTS.md`、`BUILD.md`）。

> ローカライズ：まず英語版。日本語版・ドイツ語版は別の `i18n/` サブフォルダで
> 提供予定です。

---
**ライセンス（採用）：** ドキュメントは **CC‑BY‑4.0** で公開されています。[`../LICENSE`](../../../LICENSE) を参照。
