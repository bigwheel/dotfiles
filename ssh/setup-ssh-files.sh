#!/usr/bin/env bash

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

# ここからid_rsa関連
echo -n 'id_rsaを$HOME/.sshへ置くなら
DropboxのPrivate AppのOauth tokenを入力してください
(そうでなければ何も入力せずEnterしてください)
https://www.dropbox.com/developers/apps
からPrivate Appを選択してGenerate access token
が最も楽でしょう
Access token: '

read -s dropbox_access_token
echo ''

if [ -n "$dropbox_access_token" ]
then
    sudo apt-get update
    sudo apt-get install -y curl
    # access tokenが露出しないようにコマンド表示を一時的に無効化
    KEY_PATH="$SSH_DIR/id_rsa"
    set +x
    curl -X POST https://content.dropboxapi.com/2/files/download \
        --header "Authorization: Bearer $dropbox_access_token" \
        --header 'Dropbox-API-Arg: {"path":"/id_rsa"}' > $KEY_PATH
    set -x
    chmod 600 $KEY_PATH
fi
