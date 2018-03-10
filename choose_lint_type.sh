#!/bin/bash

# 引数にファイルを受け取る
fpath=${1:?}

# 拡張子を抽出
ftype="${fpath##*.}"

# 拡張子が無い場合は空にする
if [ "${fpath}" = "${ftype}" ]; then
    ftype=""
fi

# 拡張子ごとに lint を実行する
case "$ftype" in
    "yml" | "yaml" ) ansible-lint -c lint-rules/rules/ansible/.ansible-lint ${fpath}  ;;
    * ) echo ${ftype:?}: There is no matching lint test for this file type. ;;
esac
