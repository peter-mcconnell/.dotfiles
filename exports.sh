#!/bin/sh

test -f "${HOME}/.kube/config.yaml" && export KUBECONFIG="$HOME/.kube/config.yaml"
test -d "${HOME}/.krew" && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
test -d /var/lib/flatpak/exports/share && export PATH="/var/lib/flatpak/exports/share:$PATH"
test -d "${HOME}/.local/share/flatpak/exports/share" && export PATH="${HOME}/.local/share/flatpak/exports/share:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/opt/apache-maven-3.3.9/bin:$PATH"
export PATH="${HOME}/Library/Python/3.7/bin/:$PATH"
export PATH="${HOME}/Library/Python/3.11/bin/:$PATH"
test -d /opt/Goland-2023.2.1 && export PATH="/opt/GoLand-2023.2.1/bin:$PATH"
#export PATH="/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages:$PATH"
export PATH="${HOME}/Library/Python/2.7/bin:$PATH"
test -f /usr/local/bin/mysql/bin && export PATH=/usr/local/mysql/bin:$PATH
test -f /usr/local/go/bin/go && export PATH=/usr/local/go/bin:$PATH
test -d ~/go/bin/ && export PATH=$HOME/go/bin:$PATH
test -d ~/bin && PATH=$HOME/bin:$PATH
test -d ~/.local/bin && PATH=~/.local/bin:$PATH
test -d ~/.krew/bin && PATH=~/.krew/bin:$PATH
test -d /usr/local/lib/ruby/gems/2.6.0/bin && PATH=/usr/local/lib/ruby/gems/2.6.0/bin:$PATH
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export BLOCKSIZE=K            # set blocksize size
export BROWSER='chrome'       # set default browser
export CDDIR="$HOME"          # for use with the function 'cd' and the alias 'cdd'
export EDITOR='nvim'          # use neovim
export GIT_EDITOR='nvim'      # use neovim
export HISTCONTROL=ignoreboth:erasedups     # for 'ignoreboth': ignore duplicates and /^\s/
export HISTIGNORE="&:ls:ll:la:l.:pwd:cd:exit:clear"
export HISTSIZE=10000         # increase or decrease the size of the history to '10,000'
export HISTTIMEFORMAT='%H:%M > '
export HISTTIMEFORMAT='%Y-%m-%d_%H:%M:%S_%a  '  # makes history display in YYYY-MM-DD_HH:MM:SS_3CharWeekdaySpaceSpace format
export HOSTFILE=$HOME/.hosts  # put list of remote hosts in ~/.hosts ...
export LESSCHARSET='latin1'
export LESS="-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \\"
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-' # use this if lesspipe.sh exists
export PAGER='less -e'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export TMOUT=0                # auto logout after n seconds of inactivity
export VIDEO_FORMAT=NTSC      # for use with creating compatible DVDs ('dvdauthor -x dvdauthor.xml' will fail if this not here)
export VISUAL='vim'
test -d /opt/jdk/jdk-21.0.1 && export JAVA_HOME=/opt/jdk/jdk-21.0.1
test -d /opt/jdk/jdk-21.0.1 && export PATH="/opt/jdk/jdk-21.0.1/bin:$PATH"

test -f ~/.machine.specific.exports && . ~/.machine.specific.exports

test -d /opt/homebrew/bin && export PATH="$PATH:/opt/homebrew/bin/"

test -d /Users/petermcconnell/Library/Python/3.9/bin && export PATH="$PATH:/Users/petermcconnell/Library/Python/3.9/bin/"

export PATH="$PATH:/Users/petermcconnell/go/bin/"

if command -v nvim >/dev/null 2>&1; then alias vim='nvim'; fi
