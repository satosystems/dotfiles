#!/bin/bash

UNAME=$(uname)

if [ "`pwd`" != "$(cd $(dirname $0) && pwd)" ]; then
  tput setaf 1 && echo "Usage:"
  tput setaf 4 && echo "cd $(cd $(dirname $0) && pwd)"
  tput setaf 4 && echo "./setup.sh"
  exit 1
fi

# setup environment variables
if [ "$XDG_CONFIG_HOME" == "" ]; then
  XDG_CONFIG_HOME=~/.config
fi
if [ "$XDG_CACHE_HOME" == "" ]; then
  XDG_CACHE_HOME=~/.cache
fi

# create directories
dirs=(
  "$XDG_CONFIG_HOME"
  "$XDG_CACHE_HOME"
)

for dir in ${dirs[@]}; do
  echo "mkdir $dir"
  [ -d $dir ] || mkdir -p $dir
done

# create symblic files
dotfiles=`ls -dFG .* | grep -v -e "/$" -e "\.*\.swp$" -e "^\.DS_Store$" -e "^\.gitignore$"`

for dotfile in $dotfiles; do
  echo "$dotfile => $HOME/$dotfile"
  rm -rf "$HOME/$dotfile"
  if [ "${UNAME#CYGWIN}" == "$UNAME" ]; then
    ln -s "`pwd`/$dotfile" "$HOME/$dotfile"
  else
    cp -f "`pwd`/$dotfile" "$HOME/$dotfile"
  fi
done

# create symbolic directories
pairs=(
  ".haskell" "$HOME/.haskell"
  ".hlint.yaml" "$HOME/.hlint.yaml"
  ".config/nvim" "$XDG_CONFIG_HOME/nvim"
  ".config/peco" "$XDG_CONFIG_HOME/peco"
  "Library/KeyBindings" "$HOME/Library/KeyBindings"
  ".config/nvim" "$HOME/.vim"
  ".config/nvim/init.vim" "$HOME/.vimrc"
  ".stack/config.yaml" "$HOME/.stack/config.yaml"
  ".stack/global-project/stack.yaml" "$HOME/.stack/global-project/stack.yaml"
  ".clang-format" "$HOME/.clang-format"
  "Library/Application Support/Code/User/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
  "Library/Application Support/Code/User/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
)

for i in `seq ${#pairs[@]}`; do
  if [ $(($i % 2)) == 1 ]; then
    fst=${pairs[$i-1]}
    snd=${pairs[$i]}
    echo "${fst} => ${snd}"
    rm -rf "${snd}"
    if [ "${UNAME#CYGWIN}" == "$UNAME" ]; then
      if [  -f "${snd}" ]; then
        rm "${snd}"
      fi
      ln -s "`pwd`/${fst}" "${snd}"
    else
      cp -rf "`pwd`/${fst}" "${snd}"
    fi
  fi
done

# download git-completion.bash and git-prompt.sh from GitHub master branch
# Homebrew で導入する git に付属するのでダウンロードしない
# スクリプトと git のバージョンの整合が崩れると補完時にエラーが出る
# 上記理由でコメントアウト
#pairs=(
#  "$HOME/.git-completion.bash" "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
#  "$HOME/.git-prompt.sh" "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"
#)
#
#pair=()
#for i in `seq ${#pairs[@]}`; do
#  let i--
#  pair=(${pair[@]} ${pairs[$i]})
#  if [ $(($i % 2)) == 1 ]; then
#    echo "${pair[1]} => ${pair[0]}"
#    curl ${pair[1]} > "${pair[0]}"
#    pair=()
#  fi
#done

# refresh
. ~/.bash_profile

