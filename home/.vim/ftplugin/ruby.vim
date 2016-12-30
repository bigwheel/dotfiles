set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
"au BufNewFile,BufRead *.erb set tabstop=4 shiftwidth=4 softtabstop=4
"au BufNewFile,BufRead *.cap set tabstop=4 shiftwidth=4 softtabstop=4
set autoindent
source $VIMRUNTIME/macros/matchit.vim

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
