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
