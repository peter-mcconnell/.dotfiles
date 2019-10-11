#!/usr/bin/env bash

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
_initMyDir "${HOME}/.config" "A place to store various configs - mostly Arch stuff"

# load in extra files
# shellcheck source=/dev/null
test -f ~/.aliases && source ~/.aliases
# shellcheck source=/dev/null
test -f ~/.exports && source ~/.exports
# shellcheck source=/dev/null
test -f ~/.functions && source ~/.functions
# shellcheck source=/dev/null
test -f ~/.bash_completion && source ~/.bash_completion
# shellcheck source=/dev/null
test -f ~/.bash_completion && source ~/.bash_completion
# shellcheck source=/dev/null
test -f /etc/bash_completion && source /etc/bash_completion
# shellcheck source=/dev/null
test -f /usr/local/git/contrib/completion/git-completion.bash && source /usr/local/git/contrib/completion/git-completion.bash
# shellcheck source=/dev/null
test -f /usr/local/git/contrib/completion/git-prompt.sh && source /usr/local/git/contrib/completion/git-prompt.sh
# shellcheck source=/dev/null
test -f /usr/local/bin/virtualenvwrapper.sh && source /usr/local/bin/virtualenvwrapper.sh
# shellcheck source=/dev/null
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# maven
alias grun='java org.antlr.v4.runtime.misc.TestRig'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# PS1
# shellcheck source=/dev/null
source ~/.bash_git
export PS1="\\T (\\h)"'$(git branch &>/dev/null;
if [ $? -eq 0 ]; then
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1;
  if [ "$?" -eq "0" ]; then
    # @4 - Clean repository - nothing to commit
    echo "\[\033[0;32m\]"$(__git_ps1 " (%s)");
  else
    # @5 - Changes to working tree
    echo "\[\033[0;91m\]"$(__git_ps1 " {%s}");
  fi) \[\033[1;33m\]\w\[\033[0m\]\n\$ ";
else
  # @2 - Prompt when not in GIT repo
  echo " \[\033[1;33m\]\w\[\033[0m\]\n\$ "
fi)'

if [ "$PS1" ]; then # if running interactively, then run till 'fi' at EOF:
  set -b
  set -o notify
  set bell-style visible
  set completion-ignore-case on
  shopt -s cdable_vars
  shopt -s cdspell
  shopt -s checkhash
  shopt -s checkwinsize
  shopt -s cmdhist
  shopt -s extglob
  shopt -s histappend histreedit histverify
  shopt -s mailwarn
  shopt -s nocaseglob
  shopt -s no_empty_cmd_completion
  shopt -s sourcepath
  stty start undef
  stty stop undef
  ulimit -S -c 0
  COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
  complete -cf sudo
fi
