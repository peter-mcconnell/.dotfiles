# load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc
# apt engine
if [ -d "$HOME/google_appengine" ] ; then
    PATH="$HOME/google_appengine:$PATH"
fi

# google cloud sdk
if [ -d "$HOME/google-cloud-sdk" ] ; then
    source "$HOME/google-cloud-sdk/path.bash.inc"
    source "$HOME/google-cloud-sdk/completion.bash.inc"
fi

if [ -d "$HOME/GoWorkspaces/bin" ]; then
    PATH="$HOME/GoWorkspaces/bin:$PATH"
fi

# The next line updates PATH for the Google Cloud SDK.
source '/Users/pete/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/pete/google-cloud-sdk/completion.bash.inc'
