## 2022/11

> Everything is a Widget

Flutter はあくまで Dart 言語の上で動く SDK。

宣言的なプログラミングの特徴として、**UI が構築されるプロセスについてはフレームワークに任せる仕組み**になっている。  
つまり、フレームワークのことを知る必要がある！

Widget は宣言的 UI そのもの

公式  
[`UI = f(state)`](https://docs.flutter.dev/development/data-and-backend/state-mgmt/declarative)

- UI: レイアウト（スクリーン上）
- f: ビルドメソッド
  - Widget をどのように組み合わせるかの定義
- state: アプリケーションの状態

## 2022/12

ユーザーの操作によって受けた効果を**状態**として表現する！

SafeArea: スマホのノッチ部分など、単純な長方形ではない画面領域を避ける。  
Expanded: 利用可能な領域を自動的に確保してくれる Widget。

State の役割は、**状態を保持して際ビルドをさせること**

再ビルドの依頼は、再ビルド待ちのキューへの登録によって行われる。  
State オブジェクトにおいて、setState メソッドにて実装されている。
