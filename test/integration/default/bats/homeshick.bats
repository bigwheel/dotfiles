#!/usr/bin/env bats

@test 'homeshick function exists' {
  source $HOME/.zandbashrc
  type homeshick | grep 'a function'
}
