#!/usr/bin/env bash

set -eux

# http://qiita.com/yudoufu/items/48cb6fb71e5b498b2532
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

echo 'DropboxのPrivate AppのOauth tokenを入力してください'
echo 'https://www.dropbox.com/developers/apps'
echo 'からPrivate Appを選択してGenerate access token'
echo 'が最も楽でしょう'
echo -n 'Access token: '

read -s dropbox_access_token
echo ''

SSH_DIR=$HOME/.ssh
mkdir -p $SSH_DIR
chmod 700 $SSH_DIR
KEY_PATH="$SSH_DIR/id_rsa"
apt-get update
apt-get install -y curl
# access tokenが露出しないようにコマンド表示を一時的に無効化
set +x
curl -X POST https://content.dropboxapi.com/2/files/download \
    --header "Authorization: Bearer $dropbox_access_token" \
    --header 'Dropbox-API-Arg: {"path":"/id_rsa"}' > $KEY_PATH
set -x
chmod 600 $KEY_PATH

cp $script_dir/id_rsa.pub $SSH_DIR/id_rsa.pub
chmod 644 $SSH_DIR/id_rsa.pub
cp $script_dir/config $SSH_DIR/config
chmod 644 $SSH_DIR/config
cat $script_dir/id_rsa.pub >> $SSH_DIR/authorized_keys
chmod 644 $SSH_DIR/authorized_keys
