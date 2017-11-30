export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache

# PATH 環境変数
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH
[ -d $HOME/Library/Android/sdk/platform-tools ] && export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools
[ -d $HOME/Library/Android/sdk/tools ] && export PATH=$PATH:$HOME/Library/Android/sdk/tools
[ -d $HOME/Library/ndk ] && export PATH=$PATH:$HOME/Library/ndk
[ -d $HOME/Library/Android/sdk/build-tools/26.0.0 ] && export PATH=$PATH:$HOME/Library/Android/sdk/build-tools/26.0.0
[ -d $HOME/Library/Android/sdk/build-tools/25.0.3 ] && export PATH=$PATH:$HOME/Library/Android/sdk/build-tools/25.0.3
[[ "`arch`" =~ armv[0-9]+ ]] && [ -d $HOME/.stack/programs/arm-linux/ghc-8.0.2/bin ] && export PATH=$PATH:$HOME/.stack/programs/arm-linux/ghc-8.0.2/bin
[[ "`arch`" =~ armv[0-9]+ ]] && [ -d $HOME/.ghc-mod/.cabal-sandbox/bin ] && export PATH=$PATH:$HOME/.ghc-mod/.cabal-sandbox/bin
[[ "$(uname)" == "Linux" ]] && [ -d $HOME/raspberrypi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin ] && export PATH=$HOME/raspberrypi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:$PATH
[ -d $HOME/.stack/programs/x86_64-osx/ghc-8.0.2/bin ] && export PATH=$PATH:$HOME/.stack/programs/x86_64-osx/ghc-8.0.2/bin

# ヒストリ関連
export HISTCONTROL=ignoreboth  # 重複した履歴と先頭がスペースで始まるコマンドは履歴に含めない
export HISTIGNORE="fg*:bg*:jobs*:dirs*:history*"
export HISTSIZE=10000

# ESP8266 closs compile
if [ "$(uname)" == "Darwin" ]; then
  [ -d /usr/local/opt/gnu-sed/bin ] && export PATH=/usr/local/opt/gnu-sed/bin:$PATH
  [ -d $HOME/xtensa-crosstools.sparsebundle ] || hdiutil create -type SPARSEBUNDLE -nospotlight -volname xtensa-crosstools -size 10g -fs "Case-sensitive HFS+" -verbose $HOME/xtensa-crosstools.sparsebundle
  [ -d /Volumes/xtensa-crosstools ] || hdiutil mount $HOME/xtensa-crosstools.sparsebundle
  export PATH=$PATH:/Volumes/xtensa-crosstools/esp-open-sdk/xtensa-lx106-elf/bin
fi

# macOS Java のバージョン切り替え
[ "$(uname)" == "Darwin" ] && export JAVA_HOME=`/usr/libexec/java_home -v 1.7`

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
