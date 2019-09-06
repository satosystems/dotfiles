export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache

# Android 関連
if [ -d $HOME/Library/Android/sdk ]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  export PATH=$PATH:$ANDROID_HOME/tools
#  for v in 25.0.3 27.0.3 28.0.3
#  do
#    [ -d $ANDROID_HOME/build-tools/$v ] && export PATH=$PATH:$ANDROID_HOME/build-tools/$v
#  done
  [ -d $ANDROID_HOME/ndk-bundle ] && export NDK_ROOT=$ANDROID_HOME/ndk-bundle && export PATH=$PATH:$NDK_ROOT
fi

# PATH 環境変数
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH
[ "$(uname)" == "Darwin" ] && [ -d /usr/local/opt/openssl/bin ] && export PATH=/usr/local/opt/openssl/bin:$PATH  # brew で入れた OpenSSL を優先する
[ "$(uname)" == "Linux" ] && [ -d $HOME/raspberrypi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin ] && export PATH=$HOME/raspberrypi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:$PATH
[ -d /Library/TeX/texbin ] && export PATH=/Library/TeX/texbin:$PATH
[ -d /usr/local/opt/curl/bin ] && export PATH=/usr/local/opt/curl/bin:$PATH  # macOS 上で brew で OpenSSL を有効化した curl がある場合はそちらを使用する
# MacVim に付属する vim を使用してクリップボード連携する
if [ -d /usr/local/Cellar/macvim/*/MacVim.app/Contents/bin ]; then
  pushd /usr/local/Cellar/macvim/*/MacVim.app/Contents/bin > /dev/null
  export PATH=`pwd`:$PATH
  popd > /dev/null
fi
# Homebrew 版 vim が導入されている場合はそちらを利用する。
if [ -d /usr/local/Cellar/vim/*/bin/ ]; then
  for i in /usr/local/Cellar/vim/*/bin/; do
    pushd $i > /dev/null
    export PATH=`pwd`:$PATH
    popd > /dev/null
  done
fi
if [ -d /usr/local/opt/go/libexec/bin ]; then
  export GOPATH=$HOME/.go
  export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin
fi
if [ -d /usr/local/opt/sqlite/bin ]; then
  export PATH="/usr/local/opt/sqlite/bin:$PATH"
  if [ "$LDFLAGS" == "" ]; then
    export LDFLAGS="-L/usr/local/opt/sqlite/lib"
  else
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/sqlite/lib"
  fi
  if [ "$CPPFLAGS" == "" ]; then
    export CPPFLAGS="-I/usr/local/opt/sqlite/include"
  else
    export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/sqlite/include"
  fi
  if [ "$PKG_CONFIG_PATH" == "" ]; then
    export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig"
  else
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/sqlite/lib/pkgconfig"
  fi
fi
if [ -d $HOME/.haskell ]; then
  export PATH=$PATH:$HOME/.haskell
fi

# ヒストリ関連
export HISTCONTROL=ignoreboth  # 重複した履歴と先頭がスペースで始まるコマンドは履歴に含めない
export HISTIGNORE="fg*:bg*:jobs*:dirs*:history*"
export HISTSIZE=10000

# macOS Java のバージョン切り替え
[ "$(uname)" == "Darwin" ] && /usr/libexec/java_home > /dev/null 2>&1 && export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# node 関連
[ -d ~/.nodebrew/current/bin ] && export PATH=$PATH:~/.nodebrew/current/bin

# Python 関連
if [ -s "`which pyenv 2> /dev/null`" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
[ -d $HOME/Library/Python/2.7/bin ] && export PATH=$PATH:$HOME/Library/Python/2.7/bin
# pyenv 内の gettext が使われないように対策
[ -d /usr/local/opt/gettext/bin ] && export PATH=/usr/local/opt/gettext/bin:$PATH

# PlatformIO 関連
[ -d $HOME/.platformio/penv/bin ] && export PATH=$PATH:$HOME/.platformio/penv/bin

# llvm 関連
if [ -d /usr/local/opt/llvm/bin ]; then
  export PATH=/usr/local/opt/llvm/bin:$PATH
  if [ "$LDFLAGS" == "" ]; then
    export LDFLAGS="-L/usr/local/opt/llvm/lib"
  else
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/llvm/lib"
  fi
  if [ "$CPPFLAGS" == "" ]; then
    export CPPFLAGS="-I/usr/local/opt/llvm/include"
  else
    export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/llvm/include"
  fi
fi

# mysql 関連
if [ -d /usr/local/opt/mysql@5.7/bin ]; then
  export PATH=/usr/local/opt/mysql@5.7/bin:$PATH
  if [ "$LDFLAGS" == "" ]; then
    export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
  else
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/mysql@5.7/lib"
  fi
  if [ "$CPPFLAGS" == "" ]; then
    export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
  else
    export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/mysql@5.7/include"
  fi
  if [ "$PKG_CONFIG_PATH" == "" ]; then
    export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"
  else
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/mysql@5.7/lib/pkgconfig"
  fi
fi

# Sebastien AIML 関連
[ -d $HOME/Documents/xls2aiml/bin ] && export PATH=$PATH:$HOME/Documents/xls2aiml/bin

# nvm
res=which brew 2> /dev/null && brew list | grep -E '^nvm$'
if [ "$res" == "nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  . $(brew --prefix nvm)/nvm.sh
fi

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# MINGW の場合、/ で開始してしまうため ~ に移動
if [[ $(uname) = MINGW* ]]; then cd; fi

# 便利関数
## grep 置換
## greprep *.sh "\/bin\/sh" "\/bin\/bash"
greprep() {
  grep -rl "$2" $1 | grep -v .git/ | xargs perl -i -pe "s/$2/$3/g"
}

# direnv
which direnv 2> /dev/null 1>&2 && eval "$(direnv hook bash)"

# 複数ターミナルのコマンド履歴をすべて保存
shopt -s histappend

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if [ -d /Users/ogata/Library/cocos2d-x ]; then
  # Add environment variable COCOS_X_ROOT for cocos2d-x
  export COCOS_X_ROOT="$HOME/Library/cocos2d-x"
  export PATH=$COCOS_X_ROOT:$PATH

  # Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
  export COCOS_CONSOLE_ROOT="$COCOS_X_ROOT/tools/cocos2d-console/bin"
  export PATH=$COCOS_CONSOLE_ROOT:$PATH

  # Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
  export COCOS_TEMPLATES_ROOT="$COCOS_X_ROOT/templates"
fi
