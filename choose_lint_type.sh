#!/bin/bash

# 変更ファイルを抽出する
flist=`git diff --name-only --diff-filter=ACM origin/master...HEAD`
echo ${flist}

# 変更ファイルが0の時は終了
if [ "${flist}" = "" ]; then
    echo There is no file in this commint.
    exit 0
fi

function exec-lint () {
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
        * ) echo ${fpath:?}: There is no matching lint test for this file type. ;;
    esac
}

# lint 実行
for i in ${flist:?}
do
    exec-lint ${i}
done
