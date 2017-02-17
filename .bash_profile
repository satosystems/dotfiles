export XDG_CONFIG_HOME=~/.config

# PATH 環境変数
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH
[ -d $HOME/Library/Android/sdk/platform-tools ] && export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools
[ -d $HOME/Library/Android/sdk/tools ] && export PATH=$PATH:$HOME/Library/Android/sdk/tools
[ -d $HOME/Library/ndk ] && export PATH=$PATH:$HOME/Library/ndk

# ヒストリ関連
export HISTCONTROL=ignoreboth  # 重複した履歴と先頭がスペースで始まるコマンドは履歴に含めない
export HISTIGNORE="fg*:bg*:jobs*:history*:cd*"
export HISTSIZE=10000

# macOS Java のバージョン切り替え
[ "$(uname)" == "Darwin" ] && export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# nvm
if [ -s "`which brew`" ] && [ "`brew list | grep -E '^nvm$'`" == "nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
fi

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

