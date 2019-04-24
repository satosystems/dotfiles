# Haskell と Stack
if [ -s "`which stack 2> /dev/null`" ]; then
  eval "$(stack --bash-completion-script stack)"
  eval "$(stack exec env | grep ^PATH=)"
fi

# SMC 関連のエイリアス
alias smc='java -jar ~/Dropbox/smc/bin/Smc.jar'
alias smcdot='smc -graph -glevel 1'
alias smcpng='dot -T png -o'
alias makepng='~/Dropbox/smc/bin/makepng.sh'

# 一般的なエイリアス
if [ "$(uname)" == "Darwin" ]; then
  alias ls='ls -FG'
else
  alias ls='ls -F --color=auto'
fi
if [ -s "`which macrm 2> /dev/null`" ]; then
  alias rm='macrm'
fi
alias ag='ag --smart-case --all-types'
alias tree='tree -N'
#[[ `which nvim 2> /dev/null` = */nvim ]] && alias vi='nvim' || alias vi='vim'
alias vi='vim'
alias vi-noplugin='vi -u NONE --noplugin'
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
[[ -s "`which gtimeout 2> /dev/null`" ]] && alias timeout='gtimeout'

# ssh-agent 関連
SSH_ENV=$HOME/.ssh-agent-environment
start_agent() {
  ssh-agent > $SSH_ENV
  chmod 600 $SSH_ENV
  . $SSH_ENV > /dev/null
  # ssh-add
  for i in `ls ~/.ssh/id_rsa* | grep -v ".pub"`;
  do
    ssh-add $i
  done
}

if [ -f $SSH_ENV ]; then
  . $SSH_ENV > /dev/null
  if ps ${SSH_AGENT_PID:-999999} | grep ssh-agent$ > /dev/null && test -S $SSH_AUTH_SOCK; then
    echo agent already running > /dev/null
  else
    start_agent
  fi
else
  start_agent
fi

# PlatformIO 関連
if [ -s "`which platformio 2> /dev/null`" ]; then
  eval "$(_PLATFORMIO_COMPLETE=source platformio)"
  eval "$(_PIO_COMPLETE=source pio)"
fi

# npm/yarn completion
if [ -f /usr/local/lib/node_modules/npm-completion/npm-completion.sh ]; then
  export PATH_TO_NPM_COMPLETION=/usr/local/lib/node_modules/npm-completion
  source /usr/local/lib/node_modules/npm-completion/npm-completion.sh
fi

[ -f /usr/local/etc/bash_completion.d/cabal ] && source /usr/local/etc/bash_completion.d/cabal
[ -f /usr/local/etc/bash_completion.d/docker ] && source /usr/local/etc/bash_completion.d/docker

# Git 関連
if [ -d /usr/local/etc/bash_completion.d ]; then
  . /usr/local/etc/bash_completion.d/git-completion.bash
  . /usr/local/etc/bash_completion.d/git-prompt.sh
  # 現在のブランチが upstream より進んでいるとき ">" を、
  # 遅れているとき "<" を、
  # 遅れてるけど独自の変更もあるとき "<>" を表示する
  GIT_PS1_SHOWDIRTYSTATE=1
  # add されてない新規ファイルがあるとき "%" を表示する
  GIT_PS1_SHOWUPSTREAM=1
  # stash になにか入っているとき "$" を表示する
  GIT_PS1_SHOWUNTRACKEDFILES=1
  # add されてない変更があったとき "*" を、
  # add されているが commit されていない変更があったとき "+" を表示する
  GIT_PS1_SHOWSTASHSTATE=1
fi

##### ターミナルプロンプト設定 #####
# \u ユーザ名                      #
# \h ホスト名                      #
# \W カレントディレクトリ          #
# \w カレントディレクトリのパス    #
# \n 改行                          #
# \d 日付                          #
# \[ 表示させない文字列の開始      #
# \] 表示させない文字列の終了      #
# \$ $                             #
####################################
if [ $(uname) != MINGW* ]; then
  export PS1='\[\e[0;35m\]\w\[\e[0m\033[1;34m\]$(__git_ps1)\[\e[1;32m\]\n\H\[\033[00m\] \$ '
fi

# 履歴のインクリメンタルサーチが使用できるように stty の方を無効にする（stty stop は C-s）
# ただし scp コマンド等でエラーが出ないように条件を付ける
[ "$SSH_TTY" != "" ] && stty stop undef

# bash-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Google Cloud SDK
[ -f $HOME/google-cloud-sdk/completion.bash.inc ] && . "$HOME/google-cloud-sdk/completion.bash.inc"
