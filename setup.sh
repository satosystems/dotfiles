#!/bin/sh

if [ "`pwd`" != "$(cd $(dirname $0) && pwd)" ]; then
  tput setaf 1 && echo "Usage:"
  tput setaf 4 && echo "  cd $(cd $(dirname $0) && pwd)"
  tput setaf 4 && echo "  ./setup.sh"
  exit 1
fi

# create symblic files
dotfiles=`ls -dFG .* | grep -v -e "/$" -e "\.*\.swp$" -e "^\.DS_Store$" -e "^\.gitignore$"`

for dotfile in $dotfiles; do
  echo "$dotfile => $HOME/$dotfile"
  rm -rf "$HOME/$dotfile"
  ln -s "`pwd`/$dotfile" "$HOME/$dotfile"
done

# create nvim of xdg-config-home
[ -d "$HOME/.config/nvim" ] || mkdir -p "$HOME/.config/nvim"

# create symbolic directories
dirs=(
  ".config/nvim" "$HOME/.config/nvim"
)

pair=()
for i in `seq ${#dirs[@]}`; do
  let i--
  pair=(${pair[@]} ${dirs[$i]})
  if [ $(($i % 2)) == 1 ]; then
    echo "${pair[0]} => ${pair[1]}"
    rm -rf "${pair[1]}"
    ln -s "`pwd`/${pair[0]}" "${pair[1]}"
    pair=()
  fi
done

# download git-completion.bash and git-prompt.sh from GitHub master branch
urls=(
  ".git-completion.bash" "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
  ".git-prompt.sh" "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"
)

pair=()
for i in `seq ${#urls[@]}`; do
  let i--
  pair=(${pair[@]} ${urls[$i]})
  if [ $(($i % 2)) == 1 ]; then
    echo "${pair[1]} => ${pair[0]}"
    curl ${urls[1]} > "$HOME/${pair[0]}"
    pair=()
  fi 	
done

