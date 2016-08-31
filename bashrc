# some funcs to help with profile setup (not designed to be bash_funcs)
_initMyDir () {
	if [ ! -d "${1}" ]; then
		echo "${1} missing, so I'm adding it"
		mkdir -p "${1}"
		echo "${2}" > "${1}/.info"
	fi
}
_initMyDir "${HOME}/p" "Playground area for messing around"
_initMyDir "${HOME}/s" "General webapps dir"
_initMyDir "${HOME}/go" "Golang directory"
_initMyDir "${HOME}/v" "A place to store common docker volumes"

# set some useful exports
#export LOCALIP=$(ipconfig getifaddr en0)
export LOCALIP="127.0.0.1"
export OS=$(uname)

# load in extra files
test -f ~/.bash_aliases && source ~/.bash_aliases
test -f ~/.bash_exports && source ~/.bash_exports
test -f ~/.bash_functions && source ~/.bash_functions
test -f ~/.bash_completion && source ~/.bash_completion
test -f ~/.bash_completion && source ~/.bash_completion
test -f /etc/bash_completion && source /etc/bash_completion
test -f /usr/local/git/contrib/completion/git-completion.bash && source /usr/local/git/contrib/completion/git-completion.bash
test -f /usr/local/git/contrib/completion/git-prompt.sh && source /usr/local/git/contrib/completion/git-prompt.sh
test -f /usr/local/bin/virtualenvwrapper.sh && source /usr/local/bin/virtualenvwrapper.sh

# set some exports, if paths exist
test -f /usr/local/bin/mysql/bin && export PATH=/usr/local/mysql/bin:$PATH
test -f /usr/local/go/bin/go && export PATH=/usr/local/go/bin:$PATH
test -d ~/go_appengine && export PATH=~/go_appengine:$PATH
test -d ~/go && export GOPATH=~/go && PATH=$GOPATH/bin:$PATH

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# PS1
export PS1="\T"'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "\[\033[0;32m\]"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "\[\033[0;91m\]"$(__git_ps1 " {%s}"); \
  fi) \[\033[1;33m\]\w\[\033[0m\]\n\$ "; \
else \
  # @2 - Prompt when not in GIT repo
  echo " \[\033[1;33m\]\w\[\033[0m\]\n\$ "; \
fi)'

if [ "$PS1" ]; then # if running interactively, then run till 'fi' at EOF:

export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export BLOCKSIZE=K              # set blocksize size
export BROWSER='chrome'            # set default browser
export CDDIR="$HOME"                # for use with the function 'cd' and the alias 'cdd'
export EDITOR='vi'              # use default text editor
export GREP_OPTIONS='-D skip --binary-files=without-match --ignore-case'      # most commonly used grep options
export HISTCONTROL=ignoreboth:erasedups     # for 'ignoreboth': ignore duplicates and /^\s/
export HISTIGNORE="&:ls:ll:la:l.:pwd:cd:exit:clear"
export HISTSIZE=10000               # increase or decrease the size of the history to '10,000'
export HISTTIMEFORMAT='%H:%M > '
export HISTTIMEFORMAT='%Y-%m-%d_%H:%M:%S_%a  '  # makes history display in YYYY-MM-DD_HH:MM:SS_3CharWeekdaySpaceSpace format
export HOSTFILE=$HOME/.hosts            # put list of remote hosts in ~/.hosts ...
export LESSCHARSET='latin1'
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-' # use this if lesspipe.sh exists
export PAGER='less -e'
export TERM='xterm'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export TMOUT=0                # auto logout after n seconds of inactivity
export VIDEO_FORMAT=NTSC            # for use with creating compatible DVDs ('dvdauthor -x dvdauthor.xml' will fail if this not here)
export VISUAL='vi'
set -b                      # causes output from background processes to be output right away, not on wait for next primary prompt
set bell-style visible            # I hate noise
set completion-ignore-case on         # complete things that have been typed in the wrong case
set -o notify                   # notify when jobs running in background terminate
shopt -s cdable_vars                # set the bash option so that no '$' is required (disallow write access to terminal)
shopt -s cdspell                # this will correct minor spelling errors in a cd command
shopt -s checkhash
shopt -s checkwinsize               # update windows size on command
shopt -s cmdhist                    # save multi-line commands in history as single line
shopt -s extglob                # necessary for bash completion (programmable completion)
shopt -s histappend histreedit histverify
shopt -s mailwarn               # keep an eye on the mail file (access time)
shopt -s nocaseglob                 # pathname expansion will be treated as case-insensitive (auto-corrects the case)
shopt -s no_empty_cmd_completion        # no empty completion (bash>=2.04 only)
shopt -s sourcepath
stty start undef
stty stop undef
ulimit -S -c 0                      # (core file size) don't want any coredumps

# completion
COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
complete -cf sudo

fi  # end interactive check﻿
