#!/usr/bin/env bash

# some funcs to help with profile setup (not designed to be bash_funcs)
_initMyDir () {
  if [ ! -d "${1}" ]; then
    echo "${1} missing, so I'm adding it"
    mkdir -p "${1}"
    echo "${2}" > "${1}/.info"
  fi
}
_initMyDir "${HOME}/go/src/github.com/" "Golang directory"
_initMyDir "${HOME}/v" "A place to store common docker volumes"

# load in extra files
# shellcheck source=/dev/null
test -f ~/.jira && source ~/.jira
# shellcheck source=/dev/null
test -f ~/.aliases && source ~/.aliases
# shellcheck source=/dev/null
test -f ~/.exports && source ~/.exports
# shellcheck source=/dev/null
test -f ~/.functions && source ~/.functions
# shellcheck source=/dev/null
test -f ~/.Xmodmap && xmodmap ~/.Xmodmap
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
# kubernetes plugins
test -d ~/.kube/plugins/jordanwilson230 && export PATH=$PATH:~/.kube/plugins/jordanwilson230
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
if [ "$SKIP_PS1" != "1" ]; then
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
fi

if [ "$PS1" ]; then # if running interactively, then run till 'fi' at EOF:
  set -b > /dev/null 2>&1
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

complete -C /usr/bin/terraform terraform

dockersh_ps1() { if [ -f /.dockerenv ]; then export PS1="\e[41;4;33m[docker] $ \e[0;m$PS1"; fi; }; dockersh_ps1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Powerline configuration
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  source /usr/share/powerline/bindings/bash/powerline.sh
fi

[[ -s "/home/peter/.gvm/scripts/gvm" ]] && source "/home/peter/.gvm/scripts/gvm"
# shellcheck source=/dev/null
test -f ~/.cargo/env && source ~/.cargo/env

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/pete/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/pete/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/pete/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/pete/Downloads/google-cloud-sdk/completion.bash.inc'; fi
