#!/bin/sh

URL=https://github.com/satosystems/dotfiles/archive/master.zip

if [ -s "`which curl`" ]; then
  curl -LO $URL
elif [ -s "`which wget`" ]; then 
  wget $URL
else
  echo "not found curl and wget"
  exit 1
fi

if [ -s "`which unzip`" ]; then
  unzip master.zip
  rm -f master.zip
else
  echo "not found unzip"
  exit 1
fi

cd dotfiles-master
./setup.sh
cd ..

