# load in main config
test -f ~/.bashrc && source ~/.bashrc

# arch-specific settings
if [ -f "/etc/arch-release" ]; then
  # if we're in tty1, load startx
  if [[ $(tty) == "/dev/tty1" ]]; then
    if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
      exec startx
    fi
  fi
fi
