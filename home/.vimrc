" 以下を参考にして記述
" http://qiita.com/ahiruman5/items/4f3c845500c172a02935
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

" https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/sudo.vim'

" 見た目
Plug 'altercation/vim-colors-solarized'

" 言語支援・シンタックスハイライト系
Plug 'editorconfig/editorconfig-vim'

Plug 'vim-ruby/vim-ruby'

Plug 'vim-scripts/JavaScript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/syntastic' " こいつpythonなどにも作用しているので注意
Plug 'walm/jshint.vim'

Plug 'vim-scripts/vim-coffee-script'
Plug 'leafgarland/typescript-vim'

Plug 'derekwyatt/vim-scala'
Plug 'derekwyatt/vim-sbt'

Plug 'everzet/phpfolding.vim'

Plug 'plasticboy/vim-markdown'
Plug 'kannokanno/previm'

" pyenv と相性が悪い。一時無効化
" Plug 'python-mode/python-mode'
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'elzr/vim-json'
" コピペでダブルクォートないことに気づかず貼り付ける事案が
" 多く発生したのでquote concealingは無効化
let g:vim_json_syntax_conceal = 0

Plug 'stephpy/vim-yaml'

Plug 'Matt-Deacalion/vim-systemd-syntax'

Plug 'tmux-plugins/vim-tmux'

Plug 'vim-scripts/nginx.vim'

Plug 'mechatroner/rainbow_csv'

Plug 'b4b4r07/vim-hcl'

Plug 'posva/vim-vue'

Plug 'ekalinin/Dockerfile.vim'

Plug 'hashivim/vim-terraform'

Plug 'aklt/plantuml-syntax'

Plug 'dag/vim2hs'

" 以下はしばらく使ってないので一旦無効化中
" Plug 'stonean/slim'
" Plug 'bbommarito/vim-slim'
" Plug 'GEverding/vim-hocon'

" 一度入れたけど活用できていない系
" Plug 'quickrun'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
" Plug 'Shougo/vimfiler'
" Plug 'Shougo/vimproc'
" Plug 'Shougo/vimshell'
" Plug 'Shougo/neocomplcache'
Plug 'scrooloose/nerdtree'
" Plug 'bufexplorer.zip'
" Plug 'Smooth-Scroll' " バグることが多かったので無効化
Plug 'LeafCage/yankround.vim'

" 他人とリポジトリを共有しているときに毎回勝手に改行文字が入って
" 変な差分になるのが嫌で入れたが、最近そんな行儀の悪いエディタを
" 使う人と一緒に仕事をしていないので無効化
" Plug 'PreserveNoEOL'

Plug 'farmergreg/vim-lastplace'

call plug#end()

" 見た目
syntax enable
set background=dark
colorscheme solarized

" タブがスペース2個で入るように拡張子で指定
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=2 " 画面上でタブ文字が占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2 " smartindentで増減する幅

set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

" ESCキー2度押しでハイライトの切り替え
"nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

set number
set cursorline

set showmatch

set wildmenu
set wildmode=list:longest,full
set history=1000

set mouse=a

" 不便に感じるシーンが増えてきたので一旦切る
" set autochdir

set t_Co=16
set wrap

set hidden
set scrolloff=5
set laststatus=2
set cmdheight=2

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif

" https://stackoverflow.com/a/7912621/4006322
set splitright
set splitbelow





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

if has('path_extra')
    set tags+=tags;
endif

:let g:PreserveNoEOL = 1

let g:previm_open_cmd = 'vim '

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
if has('macunix')
  set clipboard+=unnamed
  " 下ではmacではvim内でのyankが反映されなくなってしまったので、macの場合はこっちにした
else
  " https://sekisuiseien.com/computer/11064/
  " set clipboard+=unnamedplus
  " +=ではデフォルト値が最も左のままなので駄目と書いてある
  set clipboard&
  set clipboard^=unnamedplus
endif



" https://qiita.com/hide/items/77b9c1b0f29577d60397
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" directoryのd
nnoremap <silent> ,ud :<C-u>Unite file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

" https://qiita.com/zwirky/items/0209579a635b4f9c95ee
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" https://vim.fandom.com/wiki/Ignore_white_space_in_vimdiff
set diffopt+=iwhite
