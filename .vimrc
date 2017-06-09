" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" ここから標準の設定
syntax on
set t_Co=256
colorscheme molokai

set number
set cursorline "カーソル
set laststatus=2 "ステータスバー
set cmdheight=2 "メッセージ2行
set showmatch " 括弧表示
set whichwrap=b,s,h,l,<,>,[,] "カーソル折り返す
set scrolloff=8 "8行上にスペース
set nobackup " バックアップファイルを作らない
set noswapfile " スワップファイルを作らない

" タブをスペースに
set expandtab
set shiftwidth=2
set tabstop=2

set autoindent
" set noexpandtab
" set softtabstop=0

set list "見えない文字を表示
set listchars=tab:»-,trail:-,nbsp:%,eol:↲

" ESC -> Ctrl+j
imap <c-j> <esc>
vmap <c-j> <esc>

" Ctrl-e で実行
autocmd BufRead,BufNewFile *.py nnoremap <C-e> :!python %
autocmd BufRead,BufNewFile *.rb nnoremap <C-e> :!ruby %

" ファイルごとのタブ設定
augroup fileTypeIndent
	autocmd!
	autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" Clipboard
set clipboard+=unnamed 
set clipboard+=autoselect

