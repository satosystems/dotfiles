#!/usr/local/bin/bash

if [ "`pwd`" != "$(cd $(dirname $0) && pwd)" ]; then
  tput setaf 1 && echo "Usage:"
  tput setaf 4 && echo "  cd $(cd $(dirname $0) && pwd)"
  tput setaf 4 && echo "  ./setup.sh"
  exit 1
fi

# create symblic files
dotfiles=`ls -dFG .* | grep -v -e "./" -e ".*.swp"`

for dotfile in $dotfiles; do
  echo "$dotfile => $HOME/$dotfile"
  rm -rf "$HOME/$dotfile"
  ln -s "`pwd`/$dotfile" "$HOME/$dotfile"
done

# create nvim of xdg-config-home
[ -d "$HOME/.config/nvim" ] || mkdir -p "$HOME/.config/nvim"

# create symbolic directories
declare -A dirs

dirs[".config/nvim"]="$HOME/.config/nvim"

for i in ${!dirs[@]}; do
  echo "${i} => ${dirs[$i]}"
  rm -rf "${dirs[$i]}"
  ln -s "`pwd`/${i}" "${dirs[$i]}"
done

# download git-completion.bash and git-prompt.sh from GitHub master branch
declare -A urls

urls[".git-completion.bash"]="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
urls[".git-prompt.sh"]="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"

for i in ${!urls[@]}; do
  echo "${urls[$i]} => ${i}"
  curl ${urls[$i]} > "$HOME/${i}"
done

