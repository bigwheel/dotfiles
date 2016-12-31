#!/usr/bin/env bats

@test 'homeshick command exists' {
  source $HOME/.zandbashrc
  run type homeshick
  [ "$status" -eq 0 ]
}
