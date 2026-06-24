# 🎛️ Switch を作る（デジタルピアノ／キーボード）

> 🌐 [English](../../../../docs/build/switch.md) · **日本語** · [Deutsch](../../../de/docs/build/switch.md)

Switch は**デジタル**ピアノ/キーボード向けの小型・低コスト版です。モーターの代わりに、楽器の
**サステインペダル端子**を通じてサステインを**電子的に**切り替えます —— モーターもエアバックも不要。
Pro と**同じ iOS アプリと BLE ボード**を使います。

> 🚧 **ドラフト**：Switch のハードウェアの大部分が確定しました（ボード＝ItsyBitsy nRF52840、`GP13` の
> **MOSFET** がサステイン線を開閉、**直列抵抗なし**）。残る詳細は MOSFET の正確な部品と配線です —— 
> [`device-switch-electronic/firmware/`](../../../../device-switch-electronic/firmware/) を参照。
> **[Switch 取扱説明動画](https://youtu.be/XOVENtBsOp4)** で使用例が見られます。

```
 1. BLEボード入手 ─▶ 2. サステインスイッチを追加 ─▶ 3. ペダル端子へ配線 ─▶ 4. 書き込み ─▶ 5. ペアリング・使用
```

## はじめる前に
- **Adafruit ItsyBitsy nRF52840** BLEボード（Switch 用ボード。オンボード DotStar 搭載）
- サステイン線を切り替える **ROHM `RU1J002YN`** N チャネル ロジックレベル **MOSFET**（**直列抵抗なし**）
- 電源用の **単3電池 2本**（USB充電なし）
- 楽器の**サステインペダル端子**用コネクタ（一般に 6.3mm / TS ジャック）
- Face ID 付き iPhone/iPad ＋ [iOSアプリ](ios.md)

## ステップ1 —— BLEボードに書き込み
**スタンドアロン Switch ファームウェア**
（[`device-switch-electronic/firmware/`](../../../../device-switch-electronic/firmware/)）を nRF52840
に書き込みます（RESET 2回押し → UF2 ブートローダ → アップロード）。手順は
[`docs/toolchain/`](../../../../docs/toolchain/)。BLE スキャナで広告（`bFaaaPSwitch_1…4`）が見えることを確認。

## ステップ2 —— サステインスイッチを追加
BLEボードの `GP13` で **MOSFET** を駆動し、サステイン接点を開閉します（直列抵抗なし）。
*（MOSFET の正確な部品とゲート/ドレイン/ソース配線は確定作業中。）*

## ステップ3 —— ペダル端子へ配線
楽器の**サステインペダル端子**（TS チップ/スリーブ）に MOSFET を配線します。楽器ごとの**極性／ノーマル
オープン・ノーマルクローズ**は、アプリの **on-type / off-type**（`n` / `f`）で合わせます。

## ステップ4 —— ペアリング・使用
[iOSアプリ](ios.md)をビルド/インストールし、Bluetooth で接続、**しきい値**と**速さ**を設定して演奏します。
[Switch 取扱説明](../../../../docs/user-manual/)を参照。

---
→ [ビルドハブ](README.md) · [Pro を作る](pro.md) · [iOS を作る](ios.md)
