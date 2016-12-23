#!/usr/bin/env bats

@test "ssh files exist in $HOME/.ssh" {
  [ -f $HOME/.ssh/id_rsa ]
  [ -f $HOME/.ssh/id_rsa.pub ]
  [ -f $HOME/.ssh/config ]
  [ -f $HOME/.ssh/authorized_keys ]
}
