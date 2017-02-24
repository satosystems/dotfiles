if &compatible
  set nocompatible
endif

set list
set listchars=tab:⠒\ ,trail:⣿,extends:»,precedes:«,nbsp:░

set number
set mouse=

set tabstop=4
set shiftwidth=4
set noexpandtab
set softtabstop=0

filetype plugin indent on

" q で quickfix を閉じれるようにする
au FileType qf nnoremap <silent><buffer>q :quit<CR>

