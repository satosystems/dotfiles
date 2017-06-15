#!/bin/bash

UNAME=$(uname)

if [ "`pwd`" != "$(cd $(dirname $0) && pwd)" ]; then
  tput setaf 1 && echo "Usage:"
  tput setaf 4 && echo "  cd $(cd $(dirname $0) && pwd)"
  tput setaf 4 && echo "  ./setup.sh"
  exit 1
fi

# create directories
dirs=(
  "$HOME/.cache"  # XDG_CACHE_HOME
  "$HOME/.config/nvim"  # nvim in XDG_CONFIG_HOME
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
  ".config/nvim" "$HOME/.config/nvim"
  ".config/nvim" "$HOME/.vim"
  ".config/nvim/init.vim" "$HOME/.vimrc"
  ".stack/config.yaml" "$HOME/.stack/config.yaml"
)

pair=()
for i in `seq ${#pairs[@]}`; do
  let i--
  pair=(${pair[@]} ${pairs[$i]})
  if [ $(($i % 2)) == 1 ]; then
    echo "${pair[0]} => ${pair[1]}"
    rm -rf "${pair[1]}"
    if [ "${UNAME#CYGWIN}" == "$UNAME" ]; then
      ln -s "`pwd`/${pair[0]}" "${pair[1]}"
    else
      cp -rf "`pwd`/${pair[0]}" "${pair[1]}"
    fi
    pair=()
  fi
done

# download git-completion.bash and git-prompt.sh from GitHub master branch
pairs=(
  "$HOME/.git-completion.bash" "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
  "$HOME/.git-prompt.sh" "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"
)

pair=()
for i in `seq ${#pairs[@]}`; do
  let i--
  pair=(${pair[@]} ${pairs[$i]})
  if [ $(($i % 2)) == 1 ]; then
    echo "${pair[1]} => ${pair[0]}"
    curl ${pair[1]} > "${pair[0]}"
    pair=()
  fi
done

# refresh
. ~/.bash_profile

