#!/usr/bin/env bash

# load in main config
# shellcheck source=/dev/null
test -f ~/.bashrc && . ~/.bashrc

# arch-specific settings
if [ -f "/etc/arch-release" ]; then
  # if we're in tty1, load startx
  if [ "$(tty)" = "/dev/tty1" ]; then
    if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
      exec startx
    fi
  fi
  if [ -f ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
  fi
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && . "${HOME}/.iterm2_shell_integration.bash"

# osx python installs
if [ -d "/Library/Frameworks/Python.framework/Versions/2.7/bin" ]; then
  PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
  export PATH
fi
if [ -d "/Library/Frameworks/Python.framework/Versions/3.6/bin" ]; then
  PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
  export PATH
fi

# run docker automatically in WSL2
if uname -a | grep -i -q wsl2; then
  if command -v pgrep dockerd > /dev/null; then
    # note: requires update to sudoers file:
    #   myusername ALL=(ALL) NOPASSWD: /usr/bin/dockerd
    sudo dockerd > /dev/null 2>&1 &
    disown
  fi
fi

# WSL thingys
# https://github.com/stuartleeks/wsl-notify-send
if command -v wsl-notify-send.exe > /dev/null; then
  function notify-send() {
    wsl-notify-send.exe --category "$WSL_DISTRO_NAME" "${@}";
  }
fi
