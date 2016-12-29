#!/usr/bin/env bash

# GET_ID_RSA環境変数
#   id_rsaファイルを取得するならTRUE, そうでないならFALSEの文字列を設定
# HOST_TYPE環境変数
#   実行するホストのタイプ。会社PCならwork, 個人PCならpersonalと指定
# DROPBOX_ACCESS_TOKEN環境変数
#   id_rsaファイルを取得するならDropboxのアクセストークンを設定してください

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

if [ "$GET_ID_RSA" = 'TRUE' ]
then
    sudo apt-get update
    sudo apt-get install -y curl
    KEY_PATH="$SSH_DIR/id_rsa"
    # access tokenが露出しないようにコマンド表示を一時的に無効化
    set +x
    curl -X POST https://content.dropboxapi.com/2/files/download \
        --header "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
        --header 'Dropbox-API-Arg: {"path":"/'$HOST_TYPE'/id_rsa"}' > $KEY_PATH
    set -x
    chmod 600 $KEY_PATH
fi
