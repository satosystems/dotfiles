if &compatible
  set nocompatible
endif

set list  " 空白の可視化
set listchars=tab:￫\ ,extends:»,precedes:«,nbsp:░  " 空白の見え方
set laststatus=2  " ステータスラインを常に表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P  " ステータスライン設定
highlight WhiteSpace ctermbg=234  " 末尾スペースに色を付ける
match WhiteSpace / \+$/  " 末尾スペースに色を付ける

set number  " 行番号表示
set showcmd  " 入力中のコマンドをステータスに表示する
set showmatch  " 対応する括弧を強調
set hlsearch  " 検索結果を強調
" set mouse=a  " ヴィジュアルモードのみマウスを有効
" set clipboard=autoselect  " 選択で visual モード移行、クリップボードにコピー
set hidden  " 保存せずにバッファ切替可能にする
set ignorecase  "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase  "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan  "検索時に最後まで行ったら最初に戻る
set noincsearch  "検索文字列入力時に順次対象文字列にヒットさせない


set autoindent  " 自動インデント
set smartindent  " { があると次の行をインデントする
set cindent  " C プログラムファイルの自動インデント
set smarttab  " 新しい行を作ったときに高度な自動インデントを行う
set expandtab  " タブをスペースに展開
set tabstop=4  " タブ文字幅設定
set softtabstop=4  " タブ入力時変換幅設定
set shiftwidth=4  " インデント時幅設定

filetype plugin on
filetype indent on
autocmd FileType haskell     setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType vim         setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType yaml        setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType sh          setlocal tabstop=2 softtabstop=2 shiftwidth=2

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" q で quickfix を閉じれるようにする
au FileType qf nnoremap <silent><buffer>q :quit<CR>
" QuickFix を自動で開く
autocmd QuickfixCmdPost * copen

" Markdown のための拡張子設定
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
" プレビューを Firefox で開く
let g:previm_open_cmd = 'open -a Firefox'

set t_ke=""  " コンソールの状態を復元
