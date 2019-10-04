#!/usr/bin/env bash

# load in main config
# shellcheck source=/dev/null
test -f ~/.bashrc && source ~/.bashrc

# arch-specific settings
if [ -f "/etc/arch-release" ]; then
  # if we're in tty1, load startx
  if [[ $(tty) == "/dev/tty1" ]]; then
    if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
      exec startx
    fi
  fi
  if command -v "wal" 2&>1 /dev/null; then
    # wal is installed - grab latest config
    wal -R > /dev/null
  fi
  if [ -f ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
  fi
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# osx python installs
if [ -d "/Library/Frameworks/Python.framework/Versions/2.7/bin" ]; then
  PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
  export PATH
fi
if [ -d "/Library/Frameworks/Python.framework/Versions/3.6/bin" ]; then
  PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
  export PATH
fi
