# kadai4_GCD
## 最大公約数（GCD）計算スクリプト

## 概要
このリポジトリには、2つの正の整数の最大公約数（GCD）を計算するシェルスクリプトが含まれています。  
また、異常入力に対応するテストスクリプトも用意されており、正常動作を保証するための自動テストが可能です。

## ファイル構成
.
├── GCD_Calculation.sh              # 最大公約数を計算するメインスクリプト
├── GCD_Calculation_Test.sh         # テストスクリプト
├── README.md                       # プロジェクトの説明
├── LICENSE                         # ライセンス情報（MITなど）
└── .github/
    └── workflows/
        └── test.yml                # GitHub Actions の自動テスト設定ファイル

## インストール方法
本スクリプトを使用するには、以下の手順でリポジトリをクローンしてください。

git clone https://github.com/25746114sakuma/kadai4_GCD.git
cd kadai4_GCD
chmod +x GCD_Calculation.sh GCD_Calculation_Test.sh  # 実行権限の付与


## 使い方
2つの正の整数を入力すると、最大公約数を計算します。

# 入力例:
./GCD_Calculation.sh 48 18

# 出力例:
最大公約数: 6


異常入力の処理
以下のような場合、エラーメッセージが表示されます：

- 負の数や小数
- 文字列を入力
- 0 を含む入力
- 非常に大きな数（例: 10の15乗以上）は、処理に時間がかかる可能性があります

# 入力例:
./GCD_Calculation.sh abc 5

# 出力例:
エラー: 正の整数2つを入力してください

## テスト方法
テストスクリプトを実行すると、正常・異常ケースの検証を行います。

./GCD_Calculation_Test.sh

# 実行結果例:
OK: gcd(48, 18) == 6
OK: gcd(101, 103) == 1
OK: gcd(0, 4) => エラー出力を確認 (出力: エラー: 正の整数2つを入力してください)
...
すべてのテストが成功しました

## GitHub Actions での自動テスト
このリポジトリでは、GitHub Actions を利用して GCD_Calculation_Test.sh の自動テストを実行できます。
これにより、コードの変更時に自動でテストが走り、バグの混入を防ぐことができます。

.github/workflows/test.yml の内容：

name: Shell Script Test

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: リポジトリをチェックアウト
        uses: actions/checkout@v3

      - name: テストスクリプトを実行
        run: ./GCD_Calculation_Test.sh

## 動作概要
- main ブランチへの push や pull request が行われると、自動でテストスクリプトが実行されます。
- ubuntu-latest 環境で動作します。
- 全てのテストが成功すれば Success、失敗すれば Failed になります。

## 貢献方法
コードの修正や改善は Pull Request を送ってください。

## ライセンス
このプロジェクトは MITライセンス のもとで公開されています。

