#!/bin/bash

if [ "`pwd`" != "$(cd $(dirname $0) && pwd)" ]; then
  tput setaf 1 && echo "Usage:"
  tput setaf 4 && echo "  cd $(cd $(dirname $0) && pwd)"
  tput setaf 4 && echo "  ./setup.sh"
  exit 1
fi

dotfiles=`ls -dFG .* | grep -v -e "./" -e "../" -e ".*.swp" -e ".git/"`

for dotfile in $dotfiles; do
  echo $dotfile
  rm -rf "$HOME/$dotfile"
  ln -s `pwd`/$dotfile "$HOME/$dotfile"
done

# download git-completion.bash and git-prompt.sh from GitHub master branch
rm -f ~/.git-completion.bash
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
rm -f ~/.git-prompt.sh
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh

