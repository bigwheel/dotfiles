#!/usr/bin/env bash

# DROPBOX_ACCESS_TOKEN環境変数
#   id_rsaファイルを取得するならDropboxのアクセストークンを設定してください
#   しないのであればno_needと設定してください
set -eux

# http://qiita.com/yudoufu/items/48cb6fb71e5b498b2532
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

SSH_DIR=$HOME/.ssh
mkdir -p $SSH_DIR
chmod 700 $SSH_DIR
cp $script_dir/id_rsa.pub $SSH_DIR/id_rsa.pub
chmod 644 $SSH_DIR/id_rsa.pub
cp $script_dir/config $SSH_DIR/config
chmod 644 $SSH_DIR/config
cat $script_dir/id_rsa.pub >> $SSH_DIR/authorized_keys
chmod 644 $SSH_DIR/authorized_keys

set +ux
if [ -z "$DROPBOX_ACCESS_TOKEN" ]
then
    echo 'DROPBOX_ACCESS_TOKEN環境変数が設定されていません' >&2
    exit 1
elif [ "$DROPBOX_ACCESS_TOKEN" = 'no_need' ]
then
    : # 何もしない
else
    sudo apt-get update
    sudo apt-get install -y curl
    # access tokenが露出しないようにコマンド表示を一時的に無効化
    KEY_PATH="$SSH_DIR/id_rsa"
    curl -X POST https://content.dropboxapi.com/2/files/download \
        --header "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
        --header 'Dropbox-API-Arg: {"path":"/id_rsa"}' > $KEY_PATH
    chmod 600 $KEY_PATH
fi
set -ux
