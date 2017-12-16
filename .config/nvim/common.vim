if &compatible
  set nocompatible
endif

filetype plugin on
filetype indent on

set list  " 空白の可視化
set listchars=tab:￫\ ,trail:⣿,extends:»,precedes:«,nbsp:░  " 空白の見え方
set laststatus=2  " ステータスラインを常に表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P  " ステータスライン設定

set number  " 行番号表示
set tabstop=4  " タブ文字幅設定
set softtabstop=0  " タブ入力時変換幅設定
set shiftwidth=4  " インデント時幅設定
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.hs setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufNewFile,BufRead *.lhs setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufNewFile,BufRead *.vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END
set expandtab  " タブをスペースに展開
set autoindent  " 自動インデント
set smartindent  " { があると次の行をインデントする
set showcmd  " 入力中のコマンドをステータスに表示する
set showmatch  " 対応する括弧を強調
set hlsearch  " 検索結果を強調
set mouse=v  " ヴィジュアルモードのみマウスを有効

set ignorecase  "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase  "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan  "検索時に最後まで行ったら最初に戻る
set noincsearch  "検索文字列入力時に順次対象文字列にヒットさせない

"if has('mac')
"  let g:vimproc_dll_path = $XDG_CACHE_HOME . '/dein/repos/github.com/Shougo/vimproc.vim/lib/vimproc_mac.so'
"elseif has('win32')
"  let g:vimproc_dll_path = $XDG_CACHE_HOME . '/dein/repos/github.com/Shougo/vimproc.vim/lib/vimproc_win32.dll'
"elseif has('win64')
"  let g:vimproc_dll_path = $XDG_CACHE_HOME . '/dein/repos/github.com/Shougo/vimproc.vim/lib/vimproc_win64.dll'
"endif

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

