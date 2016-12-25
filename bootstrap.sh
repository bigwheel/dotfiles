#!/bin/bash

# provisioner: shell でkitchen testするとchefが入らない
# https://github.com/test-kitchen/test-kitchen/pull/632
# 問題の根が深いのでまだtest-kitchen側で解決していない
#
# よって先人に習い、bootstrap.shでrubyを入れることによりとりあえず解決する
# http://qiita.com/sawanoboly/items/2874018f385dbe8562b1
sudo apt-get -y install ruby

/tmp/kitchen/data/install-linux.sh
