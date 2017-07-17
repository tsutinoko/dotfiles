" setting
" 文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する(チカチカするので不使用)
" set showcmd
" delete keyが効かない対策
set backspace=indent,eol,start

""## 挿入モードでの ESC キーを押した後の待ちを無くす
let &t_SI .= "\e[?7727h"
let &t_EI .= "\e[?7727l"
inoremap <special> <Esc>O[ <Esc> ]]

" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の列を強調表示
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch

" プラグイン関連
call plug#begin('~/.vim/plugged')
" ツリー表示
Plug 'scrooloose/nerdtree'
" 不可視ファイルを表示する
let NERDTreeShowHidden = 1

" タブ間でのツリー共有
Plug 'jistr/vim-nerdtree-tabs'
" ファイルが指定されていなければNERD treeを有効にする
if argc() == 0
  let g:nerdtree_tabs_open_on_console_startup = 1
end

" ファイル変更の際にツリーにアイコンを表示
Plug 'Xuyuanp/nerdtree-git-plugin'

" ファイル変更の際に行番号に差分を表示
Plug 'airblade/vim-gitgutter'

" ステータスバー、タブバーをカスタマイズ
Plug 'vim-airline/vim-airline'
" Powerline系フォントを利用する
let g:airline_powerline_fonts = 1
" タブバーのカスタマイズを有効にする
let g:airline#extensions#tabline#enabled = 1
" タブバーの右領域を非表示にする
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0

" カラースキーマ
Plug 'nanotech/jellybeans.vim'

" ファイル末尾の余分なスペースをハイライト表示
Plug 'bronson/vim-trailing-whitespace'
autocmd BufWritePre * :FixWhitespace

" インデントの深さを視覚的に表示
Plug 'Yggdroot/indentLine'
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'
set list listchars=tab:\¦\
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'calendar', 'thumbnail', 'tweetvim']
" 自動補完
Plug 'Shougo/neocomplete.vim'
" 自動補完機能を有効にする
let g:neocomplete#enable_at_startup = 1
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
let g:neosnippet#enable_snipmate_compatibility = 1

" カッコの自動補完
Plug 'Townk/vim-autoclose'

" emmet
Plug 'mattn/emmet-vim'
"ctrl + eで展開
let g:user_emmet_expandabbr_key ='<c-e>'
let g:user_emmet_settings ={'indentation':'  ','lang':'ja'}

" javascriptのsyntaxハイライト
Plug 'othree/yajs.vim', {'autoload':{'filetypes':['javascript']}}
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" typescriptのsyntaxハイライト
Plug 'leafgarland/typescript-vim'

" typescriptの補完
Plug 'Quramy/tsuquyomi'
autocmd BufNewFile,BufRead *.ts     set filetype=typescript
autocmd BufNewFile,BufRead *.tsx    set filetype=typescript

" 非同期処理
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

call plug#end()

" カラースキーマを宣言する
syntax enable
colorscheme jellybeans


" =====================================
" キーバインド
" =====================================

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" 端にカーソルを移動
noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>

" タブ追加
nnoremap tab :<C-u>tabnew<CR>

"カーソルキー無効化
"HardModeと入力するとカーソルキー無効
function! HardMode ()
  noremap <Up> <Nop>
  noremap <Down> <Nop>
  noremap <Left> <Nop>
  noremap <Right> <Nop>
endfunction
"EasyModeと入力するとカーソルキー有効
function! EasyMode ()
  noremap <Up> <Up>
  noremap <Down> <Down>
  noremap <Left> <Left>
  noremap <Right> <Right>
endfunction

command! HardMode call HardMode()
command! EasyMode call EasyMode()

" ESC連打で検索のハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" leader設定
let mapleader = "\<Space>"
" ツリーと編集領域を移動する
nmap <Leader><Tab> <C-w>w
" ツリーを開く
map <Leader>n :NERDTreeToggle<CR>
