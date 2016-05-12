#lazy stuff
alias l='ls -al'
alias c='clear'

#vim
alias vi='vim'
alias vim='/usr/local/bin/vim'

# vim on osx
if [ -d /usr/local/Cellar/macvim/7.4-77/bin ]; then
	alias vim='/usr/local/Cellar/macvim/7.4-77/bin/mvim -v'
fi

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ls='ls -GFh'

alias tmux="TERM=screen-256color-bce tmux"
