# load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc
test -f ~/.bash_aliases && source ~/.bash_aliases
test -f ~/.bash_exports && source ~/.bash_exports
test -f ~/.bash_functions && source ~/.bash_functions
test -f ~/.bash_completion && source ~/.bash_completion
test -f ~/.bash_completion && source ~/.bash_completion
test -f /etc/bash_completion && source /etc/bash_completion

# app engine
if [ -d "$HOME/google_appengine" ] ; then
    PATH="$HOME/google_appengine:$PATH"
fi

# google cloud sdk
if [ -d "$HOME/google-cloud-sdk" ] ; then
    source "$HOME/google-cloud-sdk/path.bash.inc"
    source "$HOME/google-cloud-sdk/completion.bash.inc"
fi
