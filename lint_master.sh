#!/bin/bash

# ファイル一覧の作成
flist=`find . -type f`

# 除外ファイル（スペース区切り）
excludes=".gitlab-ci.yml .travis.yml /.git/ /lint-rules/"

# 対象ファイルが0の時は終了
if [ "${flist}" = "" ]; then
    echo There is no file in this commint.
    exit 0
fi

# 除外ファイルを削除する
for i in ${excludes:?}
do
    flist=`echo "${flist:?}" | grep -v "${i:?}"`
done

# LINT対象ファイル一覧を出力
echo "${flist}"
echo "---------------------"

# エラーフラグを立てる
function error-detect () {
    ERROR=1
}

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
        "yml" | "yaml" )
            ansible-lint --force-color -c lint-rules/rules/ansible/.ansible-lint ${fpath} || error-detect
            ;;
        * )
            echo ${fpath:?}: There is no matching lint test for this file type.
            ;;
    esac

}

# lint 実行
ERROR=0
for i in ${flist:?}
do
    exec-lint ${i}
done

echo "---------------------"

# Error が合った場合には異常終了
if [ ${ERROR:?} != 0 ]; then
    echo Detected error when Lint checking
    exit 1
fi

# 正常終了
exit 0
