# 📱 iOSアプリを作る

> 🌐 [English](../../../../docs/build/ios.md) · **日本語** · [Deutsch](../../../de/docs/build/ios.md)

アプリは**両方の装置（Pro・Switch）に必須**です。Face ID の顔トラッキングで頭の角度を読み取り、Bluetooth で
ペダルのコマンドを送ります。App Store から**ダウンロード**するだけでも使えます —— ソースからのビルドは、
カスタマイズや貢献をしたい開発者向けです。

> 参考：[`ios-app/BUILD.md`](../../../../ios-app/BUILD.md) · [`ios-app/CODE-STRUCTURE.md`](../../../../ios-app/CODE-STRUCTURE.md) · [`ios-app/DESIGN-HIGHLIGHTS.md`](../../../../ios-app/DESIGN-HIGHLIGHTS.md)

```
 1. 前提 ─▶ 2. プロジェクトを開く ─▶ 3. 署名を設定 ─▶ 4. 実機にビルド ─▶ 5. 権限許可 ─▶ 6. ペアリング・調整
```

## ステップ0 —— 必要なもの
- **Xcode 15+** が入った **Mac**
- **TrueDepth（Face ID）カメラ付きの iPhone/iPad** —— 頭部トラッキングに必須（シミュレータでは不可）
- 自分の端末へのインストールは無料の **Apple ID** で可（配布には有料の Apple Developer アカウントが必要）

## ステップ1 —— ソースを取得
リポジトリをクローンして Xcode プロジェクトを開きます：
```sh
git clone https://github.com/TomoShishido/bfaaap_opensource.git
open bfaaap_opensource/ios-app/src/bFaaaPSwitch1.xcodeproj
```

## ステップ2 —— 署名を設定
Xcode で：プロジェクトを選択 → **Signing & Capabilities** → **自分の Team** を選び、**Bundle Identifier** を
一意のものに変更（公開版は `com.example.bfaaap` にサニタイズ済み）。

## ステップ3 —— 実機でビルド＆実行
iPhone/iPad を USB 接続し、実行先に選んで **Run（▶）**。初回起動時に **カメラ（顔トラッキング）** と
**Bluetooth** の許可を与えます。

## ステップ4 —— ペアリング・調整
bFaaaP 装置の電源を入れ、アプリから接続。**しきい値**（どれだけ傾けるか）と**応答速度**を設定します。
BLE の流れは [`ios-app/BLE-CONNECTION-FLOW.md`](../../../../ios-app/BLE-CONNECTION-FLOW.md)、操作は
[`docs/operation/`](../../../../docs/operation/) を参照。

> ビルドしない場合は **App Store** から：<https://apps.apple.com/jp/app/bfaaapswitch/id1545866059>

---
→ [ビルドハブ](README.md) · [Pro を作る](pro.md) · [Switch を作る](switch.md)
