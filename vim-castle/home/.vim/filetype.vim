" markdown filetype file
" for previm
if exists("did\_load\_filetypes")
    finish
endif
augroup markdown
    au! BufRead,BufNewFile *.mkd,*.md,*.markdown,*.Markdown setfiletype Markdown
augroup END

au BufRead,BufNewFile *.hocon set filetype=hocon
au BufRead,BufNewFile *.cap set filetype=ruby
au BufRead,BufNewFile .gitconfig* set filetype=gitconfig
au BufRead,BufNewFile .tmux.conf* set filetype=tmux
