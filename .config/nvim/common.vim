if &compatible
  set nocompatible
endif

syntax on  " シンタックスハイライト

set list  " 空白の可視化
set listchars=tab:⠒\ ,trail:⣿,extends:»,precedes:«,nbsp:░  " 空白の見え方
set laststatus=2  " ステータスラインを常に表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P  " ステータスライン設定

set number  " 行番号表示
set tabstop=4  " タブ幅設定
set shiftwidth=4  " タブ幅設定
set softtabstop=0  " タブ幅設定
set expandtab  " タブをスペースに展開
set autoindent  " 自動インデント
set showcmd  " 入力中のコマンドをステータスに表示する
set showmatch  " 対応する括弧を強調
set hlsearch  " 検索結果を強調
set paste  " 貼り付け時に自動インデントしない

set ignorecase  "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase  "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan  "検索時に最後まで行ったら最初に戻る
set noincsearch  "検索文字列入力時に順次対象文字列にヒットさせない

filetype plugin on
filetype indent on

" q で quickfix を閉じれるようにする
au FileType qf nnoremap <silent><buffer>q :quit<CR>

