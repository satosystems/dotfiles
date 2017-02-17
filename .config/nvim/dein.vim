" initialize dein.vim
call system("$XDG_CONFIG_HOME/nvim/dein/init.sh")

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$XDG_CONFIG_HOME/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$XDG_CONFIG_HOME/nvim/dein')
  call dein#begin('$XDG_CONFIG_HOME/nvim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('$XDG_CONFIG_HOME/nvim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

