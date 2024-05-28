#!/usr/bin/env bats

@test 'vim config files exist' {
  [ -e $HOME/.vimrc ]
  [ -e $HOME/.vim ]
}
