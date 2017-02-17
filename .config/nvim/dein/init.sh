#!/bin/bash

dein_home=$(cd $(dirname $0) && pwd)
echo $dein_home

if ! [ -d "$dein_home/repos" ]; then
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  sh installer.sh "$dein_home"
  rm installer.sh
fi

