" 実験
if has('nvim')
  call rpcrequest(rpcstart(expand('$HOME/Documents/git/neovim-plugin-hello-haskell/plugin.sh')), "PingNvimhs")
  nnoremap <C-s> :echo Hello('Haskell')<cr>
else
  runtime dein.vim
  runtime common.vim
  runtime color.vim
endif
