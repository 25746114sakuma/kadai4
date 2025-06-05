#!/bin/bash

# 全体テストの成功/失敗を保持する変数 (0: 成功, 1: 失敗)
_test_overall_status=0

# 正常系テスト関数（GCDが正しく計算されるか）
test_gcd_success() {
    local a="$1"
    local b="$2"
    local expected="$3"
    local current_test_status="OK" # このテストケースの結果

    output=$(./GCD_Calculation.sh "$a" "$b" 2>&1)

    if [[ "$output" == "最大公約数: $expected" ]]; then
        echo "OK: gcd($a, $b) == $expected"
    else
        echo "NG: gcd($a, $b) != $expected (出力: $output)"
        current_test_status="NG"
    fi

    # もしこのテストケースがNGなら、全体のステータスをNGにする
    if [[ "$current_test_status" == "NG" ]]; then
        _test_overall_status=1
    fi
}

# 異常系テスト関数（不正な入力に対してエラーを返すか）
test_gcd_error() {
    local current_test_status="OK" # このテストケースの結果

    output=$(./GCD_Calculation.sh "$@" 2>&1)

    if [[ "$output" =~ エラー ]]; then
        echo "OK: gcd($*) => エラー出力を確認 (出力: $output)"
    else
        echo "NG: gcd($*) => エラーが出力されなかった (出力: $output)"
        current_test_status="NG"
    fi

    # もしこのテストケースがNGなら、全体のステータスをNGにする
    if [[ "$current_test_status" == "NG" ]]; then
        _test_overall_status=1
    fi
}

# ========== 正常系テスト ==========
test_gcd_success 48 18 6
test_gcd_success 101 103 1
test_gcd_success 56 98 14
test_gcd_success 2 4 2
test_gcd_success 2 4 3

# ========== 異常系テスト ==========
test_gcd_error 0 4                 # 0 は許可されない
test_gcd_error -3 9                # 負の数
test_gcd_error 4.5 6               # 小数
test_gcd_error abc 5               # 文字列
test_gcd_error 1                   # 引数1つだけ
test_gcd_error                     # 引数なし
test_gcd_error "" ""               # 両方空欄
test_gcd_error 1000000000000001 5   # 第1引数が上限超過
test_gcd_error 5 1000000000000001   # 第2引数が上限超過

echo "---"

# 全てのテストが完了した後に、全体のテスト結果を判定
if [[ $_test_overall_status -eq 0 ]]; then
    echo "すべてのテストが成功しました"
    exit 0 # スクリプトを正常終了
else
    echo "一部のテストが失敗しました"
    exit 1 # スクリプトを異常終了
fi
