runtime dein.vim

if has('nvim')
  call rpcrequest(rpcstart(expand('$HOME/Documents/git/neovim-plugin-hello-haskell/plugin.sh')), "PingNvimhs")
endif

