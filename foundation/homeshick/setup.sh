#!/usr/bin/env bash

set -eux

# http://qiita.com/yudoufu/items/48cb6fb71e5b498b2532
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

install() {
    if which brew
    then
        sudo brew -y install $1
    elif which yum
    then
        sudo yum -y install $1
    elif which apt-get
    then
        sudo apt-get update
        sudo apt-get install -y $1
    else
        echo 'unknown OS' >&2
        exit 1
    fi
}

install git

git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

echo '
SHARED_RC_PATH="$HOME/.zandbashrc"
if [ -e "$SHARED_RC_PATH" ]
then
    source "$SHARED_RC_PATH"
fi' >> $HOME/.bashrc

echo 'source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"' >> $HOME/.zandbashrc
