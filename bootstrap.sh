#!/usr/bin/env sh

mkdir -p ~/.local/share/fish
ln -s ~/Dropbox/linux/dotfiles/fish_history ~/.local/share/fish/fish_history

fisher install 'jorgebucaran/fisher' '2m/fish-history-merge' 'jethrokuan/z' 'PatrickF1/fzf.fish' 'b4b4r07/enhancd' 'bigwheel/fish-gitpath'
