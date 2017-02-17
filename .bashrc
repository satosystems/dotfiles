# Haskell と Stack
if [ -s "`which stack`" ]; then
  eval "$(stack --bash-completion-script stack)"
  alias ghc='stack exec ghc --'
  alias ghci='stack exec ghci --'
  alias runghc='stack exec runghc --'
  alias runhaskell='stack exec runghc --'
fi

# SMC 関連のエイリアス
alias smc='java -jar ~/Dropbox/smc/bin/Smc.jar'
alias smcdot='smc -graph -glevel 1'
alias smcpng='dot -T png -o'
alias makepng='~/Dropbox/smc/bin/makepng.sh'

# 一般的なエイリアス
alias ls='ls -FG'
alias tree='tree -N'

# さくらのレンタルサーバへのログイン
alias sakura='ssh ogre@ogre.sakura.ne.jp'

# Git 関連
if [ -s "`which git`" ]; then
  . $HOME/.git-completion.bash
  . $HOME/.git-prompt.sh
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
export PS1='\[\e[0;35m\]\w\[\e[0m\033[1;34m\]$(__git_ps1)\[\e[1;32m\]\n\H\[\033[00m\] \$ '

# 履歴のインクリメンタルサーチが使用できるように stty の方を無効にする（stty stop は C-s）
stty stop undef

# nvm
if [ "$(uname)" == "Darwin" ] && [ -s "`which brew`" ] && [ "`brew list | grep -E '^nvm$'`" == "nvm" ]; then
  . $(brew --prefix nvm)/nvm.sh
fi

# bash-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Google Cloud SDK
[ -f $HOME/google-cloud-sdk/completion.bash.inc ] && . "$HOME/google-cloud-sdk/completion.bash.inc"
