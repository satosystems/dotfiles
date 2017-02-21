# dotfiles

This repository controls version of dotfiles like `.bash_profile`.

# update Bash to 4 on macOS

```
if [ "`uname`" == "Darwin" ] && ! [ -f /usr/local/bin/bash ]; then
  brew install bash
  sudo sh -c 'echo /usr/local/bin/bash >> /etc/shells'
  chsh -s /usr/local/bin/bash
fi
```

