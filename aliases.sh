#!/usr/bin/env bash

# shellcheck disable=SC1090

alias diff='diff --color=auto'

alias asciicast2gif='docker run --rm -v $PWD:/data asciinema/asciicast2gif'

alias dockerfilelint='~/s/dockerfilelint/bin/dockerfilelint'

alias pip3='python3 -m pip'

#lazy stuff
if command -v exa > /dev/null; then
  alias l='exa --long --header --git -t modified -h -a'
else
  alias l='ls -laht -color'
fi
alias c='clear'

# vim on osx
if [ -d /usr/local/Cellar/macvim/7.4-77/bin ]; then
  alias vim='/usr/local/Cellar/macvim/7.4-77/bin/mvim -v'
fi

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
if [ -x /usr/bin/dircolors ]; then
  (test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)") || eval "$(dircolors -b)"
fi
#alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias tmux="TERM=screen-256color-bce tmux"

if [ -f ~/.machine.specific.aliases ]; then
  source ~/.machine.specific.aliases
fi

if command -v bat > /dev/null 2>&1; then
  alias og_cat="\$(which cat)"
  alias cat="bat"
fi

if command -v gtop > /dev/null 2>&1; then
  alias og_top="\$(which top)"
  alias top="gtop"
elif command -v htop > /dev/null 2>&1; then
  alias og_top="\$(which top)"
  alias top="htop"
fi

export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# docker media player shortcuts
spotify_cmd="d_tizonia --spotify-user pemcconnell"
if [ -f ~/secrets/spotify ]; then
  spotify_cmd="${spotify_cmd} --spotify-password '$(cat ~/secrets/spotify)'"
fi
alias play_artist="\$spotify_cmd --spotify-artist"
