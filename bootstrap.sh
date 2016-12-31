#!/bin/bash

# provisioner: shell でkitchen testするとchefが入らない
# https://github.com/test-kitchen/test-kitchen/pull/632
# 問題の根が深いのでまだtest-kitchen側で解決していない
#
# よって先人に習い、bootstrap.shでrubyを入れることによりとりあえず解決する
# http://qiita.com/sawanoboly/items/2874018f385dbe8562b1
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chefdk

GET_ID_RSA=TRUE HOST_TYPE=personal /tmp/kitchen/data/setup-linux.sh
