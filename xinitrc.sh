#!/bin/sh

set -u

if [ -f /etc/arch-release ]; then
  setxkbmap -model macintosh -layout gb
  if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
  fi
  xscreensaver &
  if [ -f ~/.config/polybar/launch.sh ]; then
    # shellcheck disable=SC1090
    . ~/.config/polybar/launch.sh
  fi
  if command -v wal > /dev/null 2>&1; then
    wal -R
  fi
  if [ -d ~/.local/share/fonts ]; then
    xset +fp ~/.local/share/fonts
  fi
  xset fp rehash
  if command -v i3 > /dev/null 2>&1; then
    exec i3
  fi
fi
