#!/bin/bash

# 引数チェック：2つの引数が必要かつ、いずれも空でないこと
if [[ $# -ne 2 ]] || [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "エラー: 引数が2つ必要です（空欄は不可）" >&2
    exit 1
fi

# 引数のチェック（2つの自然数のみ許可）
if [[ $# -ne 2 ]] || ! [[ "$1" =~ ^[1-9][0-9]*$ ]] || ! [[ "$2" =~ ^[1-9][0-9]*$ ]]; then
    echo "エラー: 正の整数2つを入力してください" >&2
    exit 1
fi

# 極端に大きい数のチェック
MAX_LIMIT=1000000000000000
if [[ "$1" -gt $MAX_LIMIT ]] || [[ "$2" -gt $MAX_LIMIT ]]; then
    echo "エラー: 数値が極端に大きすぎます" >&2
    exit 1
fi

# 最大公約数の計算（ユークリッドの互除法）
gcd() {
    local a=$1
    local b=$2
    while [[ $b -ne 0 ]]; do
        local temp=$b
        b=$((a % b))
        a=$temp
    done
    echo "$a"
}

# 計算と出力
result=$(gcd "$1" "$2")
echo "最大公約数: $result"
