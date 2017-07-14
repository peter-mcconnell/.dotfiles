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

# load in extra files
test -f ~/.aliases && source ~/.aliases
test -f ~/.exports && source ~/.exports
test -f ~/.functions && source ~/.functions
test -f ~/.bash_completion && source ~/.bash_completion
test -f ~/.bash_completion && source ~/.bash_completion
test -f /etc/bash_completion && source /etc/bash_completion
test -f /usr/local/git/contrib/completion/git-completion.bash && source /usr/local/git/contrib/completion/git-completion.bash
test -f /usr/local/git/contrib/completion/git-prompt.sh && source /usr/local/git/contrib/completion/git-prompt.sh
test -f /usr/local/bin/virtualenvwrapper.sh && source /usr/local/bin/virtualenvwrapper.sh
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# maven
alias grun='java org.antlr.v4.runtime.misc.TestRig'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# PS1
source ~/.bash_git
export PS1="\T (\h)"'$(git branch &>/dev/null;\
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
