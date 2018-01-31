export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache

# Android 関連
if [ -d $HOME/Library/Android/sdk ]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  export PATH=$PATH:$ANDROID_HOME/tools
  [ -d $ANDROID_HOME/build-tools/26.0.2 ] && export PATH=$PATH:$ANDROID_HOME/build-tools/26.0.2
  [ -d $ANDROID_HOME/build-tools/26.0.0 ] && export PATH=$PATH:$ANDROID_HOME/build-tools/26.0.0
  [ -d $ANDROID_HOME/build-tools/25.0.3 ] && export PATH=$PATH:$ANDROID_HOME/build-tools/25.0.3
  [ -d $ANDROID_HOME/build-tools/25.0.2 ] && export PATH=$PATH:$ANDROID_HOME/build-tools/25.0.2
fi
[ -d $HOME/Library/Android/ndk ] && export PATH=$PATH:$HOME/Library/Android/ndk

# PATH 環境変数
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH
[[ "`arch`" =~ armv[0-9]+ ]] && [ -d $HOME/.stack/programs/arm-linux/ghc-8.0.2/bin ] && export PATH=$PATH:$HOME/.stack/programs/arm-linux/ghc-8.0.2/bin
[[ "`arch`" =~ armv[0-9]+ ]] && [ -d $HOME/.ghc-mod/.cabal-sandbox/bin ] && export PATH=$PATH:$HOME/.ghc-mod/.cabal-sandbox/bin
[[ "$(uname)" == "Linux" ]] && [ -d $HOME/raspberrypi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin ] && export PATH=$HOME/raspberrypi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:$PATH
[ -d $HOME/.stack/programs/x86_64-osx/ghc-8.0.2/bin ] && export PATH=$PATH:$HOME/.stack/programs/x86_64-osx/ghc-8.0.2/bin
[ -d /Library/TeX/texbin ] && export PATH=/Library/TeX/texbin:$PATH
[ -d /usr/local/opt/curl/bin ] && export PATH=/usr/local/opt/curl/bin:$PATH  # macOS 上で brew で OpenSSL を有効化した curl がある場合はそちらを使用する

# ヒストリ関連
export HISTCONTROL=ignoreboth  # 重複した履歴と先頭がスペースで始まるコマンドは履歴に含めない
export HISTIGNORE="fg*:bg*:jobs*:dirs*:history*"
export HISTSIZE=10000

# macOS Java のバージョン切り替え
[ "$(uname)" == "Darwin" ] && export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# Python 関連
if [ -s "`which pyenv 2> /dev/null`" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

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


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Applications/Cocos/Cocos2d-x/cocos2d-x-3.10/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT=/Applications/Cocos/Cocos2d-x
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT=/Applications/Cocos/Cocos2d-x/cocos2d-x-3.10/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable NDK_ROOT for cocos2d-x
export NDK_ROOT="/Users/ogata/Library/Android/android-ndk-r11c"
export PATH=$NDK_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT="/Users/ogata/Library/Android/sdk"
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Add environment variable ANT_ROOT for cocos2d-x
export ANT_ROOT="/usr/local/Cellar/ant/1.10.1/bin"
export PATH=$ANT_ROOT:$PATH
