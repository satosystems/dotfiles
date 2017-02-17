#!/bin/bash

dotfiles=`ls -dFG .* | grep -v -e "./" -e "../" -e ".*.swp" -e ".git/"`

for dotfile in $dotfiles; do
  echo $dotfile
  rm -rf "$HOME/$dotfile"
  ln -s `pwd`/$dotfile "$HOME/$dotfile"
done

