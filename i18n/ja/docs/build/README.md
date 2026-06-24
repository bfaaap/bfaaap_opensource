# 🔧 自分で作る

> 🌐 [English](../../../../docs/build/README.md) · **日本語** · [Deutsch](../../../de/docs/build/README.md)

bFaaaP はオープンソースです。**iOSアプリ**とどちらの装置も作れます。このハブから各トラックへ進みます。
用語が不安なら、まず[用語集](../GLOSSARY.md)と[仕組み](../how-it-works.md)を。部品/図/コードの元ファイルは
[ソースマップ](../../../../docs/SOURCE-MAP.md)へ。詰まったら[AI支援サポート](../ai-support.md)で質問を。

![Pro はアコースティック、Switch はデジタル](../../../../docs/media/illustrations/intl-pro-switch.png)

## トラックを選ぶ

| トラック | 必要なもの | ステップ手順 | 詳細リファレンス |
|---------|-----------|-------------|-----------------|
| 📱 **iOSアプリ**（両装置に必須） | Mac＋Xcode＋Face ID付き iPhone/iPad | **[→ iOSアプリを作る](ios.md)** | [`ios-app/`](../../../../ios-app/) |
| 🎹 **Pro**（アコースティック） | 3Dプリンタ、はんだ付け、モーター＋ボード | **[→ Pro を作る](pro.md)** | [`device-pro-acoustic/`](../../../../device-pro-acoustic/) |
| 🎛️ **Switch**（デジタル） | ボード＋ペダル端子の接続 | **[→ Switch を作る](switch.md)** | [`device-switch-electronic/`](../../../../device-switch-electronic/) |

## 全体像
```
[ iOSアプリをビルド＆インストール ]  ──┐
                                      ├─▶ Bluetoothでペアリング ──▶ フットフリーで演奏
[ 装置をビルド：Pro または Switch ] ──┘
```

1. **アプリをビルド**（全員）—— 自分の署名チーム＆バンドルIDを設定し、自分の端末にインストール。
2. **装置をビルド** —— Pro（アコースティック向けモーター＋エアバック）または Switch（デジタル向け電子式）。
3. **ファームウェアを書き込み** —— [`docs/toolchain/`](../../../../docs/toolchain/)。
4. **ペアリング・校正・演奏** —— [`docs/operation/`](../../../../docs/operation/) と [`docs/user-manual/`](../../../../docs/user-manual/)。

> 🚧 **ドラフト**：上のステップ手順は初版です —— 一部の正確なピン配や機構寸法は、作り手（成澤・田口）から
> まだ反映中です。動画 —— 特に **[Pro 設置ウォークスルー](https://www.youtube.com/watch?v=_9YopbCYTmI)** ——
> で実際の流れが見られます。動画一覧は[ビデオガイド](../../../../docs/videos/)へ。
