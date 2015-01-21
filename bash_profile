# app engine
if [ -d "$HOME/google_appengine" ] ; then
    PATH="$HOME/google_appengine:$PATH"
fi

# google cloud sdk
if [ -d "$HOME/google-cloud-sdk" ] ; then
    source "$HOME/google-cloud-sdk/path.bash.inc"
    source "$HOME/google-cloud-sdk/completion.bash.inc"
fi

# go
if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi

# ansible
#if [ -d "$HOME/ansible" ]; then
#    source "$HOME/ansible/hacking/env-setup"
#fi
