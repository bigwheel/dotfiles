#!/usr/bin/env bash

set -eux

# http://qiita.com/yudoufu/items/48cb6fb71e5b498b2532
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

$script_dir/foundation/ssh/setup-ssh-files.sh
$script_dir/foundation/homeshick/install.sh
