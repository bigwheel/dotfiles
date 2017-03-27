set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8
set fileencoding=utf-8
set ambiwidth=double " □や○文字が崩れる問題を解決

" https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'sudo.vim'
Plug 'altercation/vim-colors-solarized'

" 言語支援・シンタックスハイライト系
Plug 'vim-ruby/vim-ruby'

Plug 'JavaScript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/syntastic'
Plug 'walm/jshint.vim'

Plug 'vim-coffee-script'

Plug 'derekwyatt/vim-scala'
Plug 'derekwyatt/vim-sbt'

Plug 'everzet/phpfolding.vim'

Plug 'plasticboy/vim-markdown'
Plug 'kannokanno/previm'

Plug 'elzr/vim-json'
" コピペでダブルクォートないことに気づかず貼り付ける事案が
" 多く発生したのでquote concealingは無効化
let g:vim_json_syntax_conceal = 0

Plug 'stephpy/vim-yaml'

Plug 'Matt-Deacalion/vim-systemd-syntax'

Plug 'tmux-plugins/vim-tmux'

" 以下はしばらく使ってないので一旦無効化中
" Plug 'stonean/slim'
" Plug 'bbommarito/vim-slim'
" Plug 'GEverding/vim-hocon'

" 一度入れたけど活用できていない系
" Plug 'quickrun'
" Plug 'unite.vim'
" Plug 'mru.vim'
" Plug 'Shougo/vimfiler'
" Plug 'Shougo/vimproc'
" Plug 'Shougo/vimshell'
" Plug 'Shougo/neocomplcache'
" Plug 'scrooloose/nerdtree'
" Plug 'bufexplorer.zip'
" Plug 'Smooth-Scroll' " バグることが多かったので無効化

" 他人とリポジトリを共有しているときに毎回勝手に改行文字が入って
" 変な差分になるのが嫌で入れたが、最近そんな行儀の悪いエディタを
" 使う人と一緒に仕事をしていないので無効化
" Plug 'PreserveNoEOL'

call plug#end()


" タブがスペース2個で入るように拡張子で指定
"au BufNewFile,BufRead *.yml set tabstop=2 shiftwidth=2 expandtab smarttab
"au BufNewFile,BufRead *.erb set tabstop=2 shiftwidth=2 expandtab smarttab
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set autoindent


set mouse=a

set incsearch
set hlsearch
" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

"set autochdir



"nnoremap b :VimFiler -split -simple -winwidth=35 -no-quit<Return>


" theme desert
"colorscheme desert
" theme solarized
syntax enable
set background=dark
colorscheme solarized
" end

set t_Co=16
set number
"highlight LineNr ctermfg=yellow
"let g:solarized_termcolors=16
set wrap

set ignorecase
set smartcase

set hidden
set scrolloff=5
set showmatch
set laststatus=2
set cmdheight=2

set wildmenu
set wildmode=list:longest,full

set history=1000

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif







""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインの色を変更
"""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=red cterm=none'

if has('syntax')
	augroup InsertHook
		autocmd!
		autocmd InsertEnter * call s:StatusLine('Enter')
		autocmd InsertLeave * call s:StatusLine('Leave')
	augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
	if a:mode == 'Enter'
		silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
		silent exec g:hi_insert
	else
		highlight clear StatusLine
		silent exec s:slhlcmd
	endif
endfunction

function! s:GetHighlight(hi)
	redir => hl
	exec 'highlight '.a:hi
	redir END
	let hl = substitute(hl, '[\r\n]', '', 'g')
	let hl = substitute(hl, 'xxx', '', '')
	return hl
endfunction

if has('unix') && !has('gui_running')
	" ESC後にすぐ反映されない対策
	inoremap <silent> <ESC> <ESC>
endif
""""""""""""""""""""""""""""""
"ここまで
"""""""""""""""""""""""""""""""
":inoremap <silent> <Esc> <Esc>:<C-u>call ibus#disable()<CR>
":inoremap <silent> <C-c> <C-c>:<C-u>call ibus#disable()<CR>
":inoremap <silent> <C-j> <C-\><C-o>:<C-u>call ibus#toggle()<CR>
":set statusline=[%{ibus#is_enabled()?'あ':'aA'}]

nmap <F9> :NERDTreeToggle<CR>

if has('path_extra')
    set tags+=tags;
endif

:let g:PreserveNoEOL = 1

let g:previm_open_cmd = 'vim '

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set clipboard+=unnamed
