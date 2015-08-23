# load in extra files
test -f ~/.bash_aliases && source ~/.bash_aliases
test -f ~/.bash_exports && source ~/.bash_exports
test -f ~/.bash_functions && source ~/.bash_functions
test -f ~/.bash_completion && source ~/.bash_completion
test -f ~/.bash_completion && source ~/.bash_completion
test -f /etc/bash_completion && source /etc/bash_completion
test -f /usr/local/git/contrib/completion/git-completion.bash && source /usr/local/git/contrib/completion/git-completion.bash
test -f /usr/local/git/contrib/completion/git-prompt.sh && source /usr/local/git/contrib/completion/git-prompt.sh

# mysql (osx)
if [ -d /usr/local/mysql/bin ]; then
	export PATH=/usr/local/mysql/bin:$PATH
fi

# packer
if [ -d ~/packer ]; then
	export PATH=~/packer:$PATH
fi

# golang
export GOPATH=~/GoWorkspaces

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# adding 256 colors
export TERM=xterm-256color

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

# OSX
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# PS1
export PS1=$IBlack$Time12h$Color_Off'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$IRed'"$(__git_ps1 " {%s}"); \
  fi) '$BYellow$PathShort$Color_Off$'\n\$ "; \
else \
  # @2 - Prompt when not in GIT repo
  echo " '$Yellow$PathShort$Color_Off'\n\$ "; \
fi)'

######################################################################################################################################################
#----- CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE
######################################################################################################################################################

######################################################################################################################################################
###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ######
######################################################################################################################################################

if [ "$PS1" ]; then # if running interactively, then run till 'fi' at EOF:

# source ~/.bashlocalrc # settings that vary per workstation
OS=$(uname)     # for resolving pesky os differing switches

######################################################################################################################################################
###### COMMAND PROMPT & CLI ###### COMMAND PROMPT & CLI ###### COMMAND PROMPT & CLI ###### COMMAND PROMPT & CLI ###### COMMAND PROMPT & CLI ######
######################################################################################################################################################
##################################################
# More PROMPT_COMMANDS               #
##################################################

###### Annoying PROMPT_COMMAND animation
# PROMPT_COMMAND='seq $COLUMNS | xargs -IX printf "%Xs\r" @'

###### Saves terminal commands in history file in real time (for use with 'shopt -s histappend')
PROMPT_COMMAND="history -a;$PROMPT_COMMAND" # use with 'shopt -s histappend';save terminal commands in history file in real time

###### Share history between using multiple commands (press enter before get history from other bash shells)
# PROMPT_COMMAND='history -a && history -n'

###### Shows date
# PROMPT_COMMAND='date +%k:%m:%S'

###### Shows memory, load average, and history
# PROMPT_COMMAND='history -a;echo -en "\033[m\033[38;5;2m"$(( `sed -nu "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -nu "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\t\033[m\033[38;5;55m$(< /proc/loadavg)\033[m"'

###### Shows the return value of the last executed command (using smileys as to whether it was successful or not)
# PROMPT_COMMAND='RET=$?; if [[ $RET -eq 0 ]]; then echo -ne "\033[0;32m$RET\033[0m ;)"; else echo -ne "\033[0;31m$RET\033[0m ;("; fi; echo -n " "'


######################################################################################################################################################
###### BASH SETTINGS ###### BASH SETTINGS ###### BASH SETTINGS ###### BASH SETTINGS ###### BASH SETTINGS ###### BASH SETTINGS ###### BASH SETTINGS ######
######################################################################################################################################################

# autoload -U compinit              # use to enable famous zsh tab-completion system
# compinit                  # use to enable famous zsh tab-completion system
export BLOCKSIZE=K              # set blocksize size
export BROWSER='firefox'            # set default browser
# export BROWSER='opera'            # set default browser
# export BROWSER=$(find_alternatives chromium-browser google-chrome opera firefox firefox-bin iceweasel konqueror w3m lynx) # uses function 'find_alternatives'
export CDDIR="$HOME"                # for use with the function 'cd' and the alias 'cdd'
# export CDPATH=.:~:~/src:/etc
# export CDPATH=.:~:~/Dropbox           # if you use dropbox from the command line often
# export DISPLAY=:79
# export EDITOR='gedit'             # use default text editor
# export EDITOR="gedit -w --resume" Typing 'fc' # open last command for editing in gedit, then execute on save
export EDITOR='vi'              # use default text editor
# export ftp_proxy=${MY_PROXY}
# export GPG_TTY='tty'              # gpg-agent says it needs this
# export GREP_OPTIONS='-D skip --binary-files=without-match --ignore-case'      # most commonly used grep options
export HISTCONTROL=ignoreboth:erasedups     # for 'ignoreboth': ignore duplicates and /^\s/
# export HISTCONTROL=ignoreboth         # ignore spaced commands and prevents storing of duplicate commands (ie, ignoredups & ignorespace)
# export HISTCONTROL=ignoredups         # don't put duplicate lines in the history. See bash(1) for more options
# export HISTCONTROL=ignorespace        # will make sure that bash don’t store any command beginning with the space character
# export HISTFILE=/dev/null         # disable history for current shell session
# export HISTFILE='$HOME/.history'      # set history file location
# export HISTFILESIZE=10000         # increase or decrease the size of the history to '10,000'
# export HISTFILESIZE=${HISTSIZE}       # bash will remember 'N' commands
export HISTIGNORE='&:bg:fg:ll:h'
# export HISTIGNORE=' cd "`*: PROMPT_COMMAND=?*?'   # define shell variable HISTIGNORE so comments appear in shell history
# export HISTIGNORE='${HISTIGNORE:+$HISTIGNORE:}la:ll:lah:lat:;a:-:fg:bg:j:sync:esu:rma:rmp:fol:pfol'
# export HISTIGNORE="&:ls:[bf]g:exit"       # duplicate entries in bash history, as well as ls, bg, fg & exit, making for cleaner bash history
# export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear"
# export HISTIGNORE='pwd:cd:ls:ls -l:'      # ignore commands given
export HISTSIZE=10000               # increase or decrease the size of the history to '10,000'
# export HISTTIMEFORMAT='| %d/%m/%y %T | '  # make 'History' Show The Date For Each Command
# export HISTTIMEFORMAT='%F %T '        # adds date and time to history
export HISTTIMEFORMAT='%H:%M > '
# export HISTTIMEFORMAT='%s'            # the beloved Second of Our Linux
# export HISTTIMEFORMAT='%Y-%b-%d::%Hh:%Mm:%Ss '
export HISTTIMEFORMAT='%Y-%m-%d_%H:%M:%S_%a  '  # makes history display in YYYY-MM-DD_HH:MM:SS_3CharWeekdaySpaceSpace format
export HOSTFILE=$HOME/.hosts            # put list of remote hosts in ~/.hosts ...
# export http_proxy=${MY_PROXY}         # proxy setting
# export https_proxy=${MY_PROXY}        # proxy setting
# export IGNOREEOF=1                # prevent CTRL-D from immediately logging out
# export INPUTRC=/etc/inputrc           # it's possible that this will make bash find my delete key (and everything else)((but i don't think it did))
# export INPUTRC=$HOME/.inputrc         # type in ‘whatever’ and press ‘Page Up’ key and bash automatically fetches last command that starts with whatever and completes the command for you (requires '$HOME/.inputrc' with these lines: #Page up/page down && "\e[5~": history-search-backward && "\e[6~": history-search-forward)
# export LC_COLLATE="en_CA.utf8"        # change sorting methods [a-Z] instead of [A-Z]
export LESSCHARSET='latin1'
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \'
# export LESSOPEN="|lesspipe.sh %s"; export LESSOPEN
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-' # use this if lesspipe.sh exists
# export LESS="-QR"             # tell less not to beep and also display colours
# export LESS='-R'
# export LESS_TERMCAP_mb=$'\E[01;31m'       # less colors for Man pages # begin blinking
# export LESS_TERMCAP_md=$'\E[01;38;5;74m'      # less colors for Man pages # begin bold
# export LESS_TERMCAP_me=$'\E[0m'               # less colors for Man pages # end mode
# export LESS_TERMCAP_se=$'\E[0m'               # less colors for Man pages # end standout-mode
# export LESS_TERMCAP_so=$'\E[38;5;246m'        # less colors for Man pages # begin standout-mode - info box
# export LESS_TERMCAP_ue=$'\E[0m'               # less colors for Man pages # end underline
# export LESS_TERMCAP_us=$'\E[04;38;5;146m'     # less colors for Man pages # begin underline
# export LIBGL_DRIVERS_PATH=/usr/lib/xorg/modules/dri                   # gallium
# export MY_PROXY='http://YOUR_USERNAME:YOUR_PASSWORD@PROXY_IP:PROXY_PORT/'
# export OOO_FORCE_DESKTOP=gnome        # openoffice preferences
# export OPERA_KEEP_BLOCKED_PLUGIN=1        # this is the special sauce to enhance flash (on opera's) performance
# export OPERAPLUGINWRAPPER_PRIORITY=0      # this is the special sauce to enhance flash (on opera's) performance
export PAGER='less -e'
# export PATH=$PATH:$HOME/scripts
# export PILOTRATE=57600            # make pilot-xfer go faster than 9600
export TERM='xterm'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export TMOUT=0                # auto logout after n seconds of inactivity
# export USER_CLIENT=deluge
# export USER_DPRT=22218
# export USER_OPRT=47426
# export USER_VPRT=79
# export USER_WPRT=30818
export VIDEO_FORMAT=NTSC            # for use with creating compatible DVDs ('dvdauthor -x dvdauthor.xml' will fail if this not here)
# export VIDEO_FORMAT=PAL           # for use with creating compatible DVDs ('dvdauthor -x dvdauthor.xml' will fail if this not here)
export VISUAL='vi'
# export wpsetters=feh
# ${file%\.[^.]*}               # to remove filename extensions in bash
# fortune -a                    # fortunes at each new shell
# mesg n                            #
set -b                      # causes output from background processes to be output right away, not on wait for next primary prompt
# set bell-style visible            # I hate noise
# set completion-ignore-case on         # complete things that have been typed in the wrong case
# set -o ignoreeof              # can't c-d out of shell
# set -o noclobber              # disallow > to work on files that already exist (prevents catting over file)
set -o notify                   # notify when jobs running in background terminate
# set -o nounset                # attempt to use undefined variable outputs error message and forces exit (messes up completion if enabled)
# set +o nounset                    # otherwise some completions will fail
# setopt autopushd pushdminus pushdsilent pushdtohome
# setopt correct
# setopt extendedglob
# setopt hist_ignore_space              # prepend ' ' to not be saved
# setopt hist_verify                    # verify when using !
# setopt nocheckjobs                    # don't complain about background jobs on e
# setopt no_clobber                     # don't overwrite files when redirect
# setopt nohup                          # don't kill bg jobs when tty quits
# setopt printexitvalue                 # print exit value from jobs
# setopt share_history
# set -o xtrace                 # useful for debuging
# setterm -blength 0                # set the bell duration in milliseconds (silence the beeps)
# set visible-stats on              # when listing possible file completions, put / after directory names and * after programs
shopt -s cdable_vars                # set the bash option so that no '$' is required (disallow write access to terminal)
shopt -s cdspell                # this will correct minor spelling errors in a cd command
shopt -s checkhash
shopt -s checkwinsize               # update windows size on command
shopt -s cmdhist                    # save multi-line commands in history as single line
# shopt -s dotglob              # files beginning with . to be returned in the results of path-name expansion
# shopt -s expand aliases           # expand aliases
shopt -s extglob                # necessary for bash completion (programmable completion)
# shopt -s globstar             # enables the ** globbing operator
# shopt -s histappend               # bash history is only saved when close terminal, not after each command and this fixes it
shopt -s histappend histreedit histverify
# shopt -s histreedit
# shopt -s histverify
# shopt -s hostcomplete                 # attempt hostname expansion when @ is at the beginning of a word
# shopt -s huponexit
shopt -s mailwarn               # keep an eye on the mail file (access time)
# shopt -s nocaseglob cdspell histappend
shopt -s nocaseglob                 # pathname expansion will be treated as case-insensitive (auto-corrects the case)
shopt -s no_empty_cmd_completion        # no empty completion (bash>=2.04 only)
# shopt -s nullglob dotglob
shopt -s sourcepath
# shopt -u cmdhist              # do not treat multiple line commands as a single entry
# shopt -u force_fignore            # expand to complete an ignored word, if no other words match.
# shopt -u mailwarn
# shopt -u sourcepath
# stty -ixon                    # disable XON/XOFF flow control (^s/^q)
stty start undef
stty stop undef
# stty stop ''                  # use C-s to search forward through history (do not block output)
# ulimit -c unlimited               # let me have core dumps
ulimit -S -c 0                      # (core file size) don't want any coredumps
# ulimit -S -f 1024                 # open files
# ulimit -S -s 8192                 # stack size
# ulimit -S -u 256                  # max user processes
# umask 007                     # all files created 660, dirs 770
# umask 022                 # makes new files have permissions: rwxr-xr-x
# umask 077                         # after everything is installed, uncomment this and the mkdir alias below ((base 8) 777 & ~077 = 700 = u=rwx,g=,o=)
# unset HISTFILESIZE                # infinite History
# unset HISTSIZE                # infinite History
# unset MAILCHECK                     # don't want my shell to warn me of incoming mail
# unsetopt bgnice                       # don't nice bg command

if [ -d $HOME/Maildir/ ]; then
    export MAIL=$HOME/Maildir/
    export MAILPATH=$HOME/Maildir/
    export MAILDIR=$HOME/Maildir/
elif [ -f /var/mail/$USER ]; then
    export MAIL="/var/mail/$USER"
fi

if [ "$TERM" = "screen" ]; then
    export TERM=$TERMINAL
fi

function get_xserver()
{
    case $TERM in
       xterm )
            XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
            # Ane-Pieter Wieringa suggests the following alternative:
            # I_AM=$(who am i)
            # SERVER=${I_AM#*(}
            # SERVER=${SERVER%*)}
            XSERVER=${XSERVER%%:*}
            ;;
        aterm | rxvt)
        # Find some code that works here. ...
            ;;
    esac
}
if [ -z ${DISPLAY:=""} ]; then
    get_xserver
    if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) || \
      ${XSERVER} == "unix" ]]; then
        DISPLAY=":0.0"          # Display on local host.
    else
        DISPLAY=${XSERVER}:0.0  # Display on remote host.
    fi
fi
export DISPLAY

##################################################
# PATH                       #
##################################################

if [ "$UID" -eq 0 ]; then
    PATH=$PATH:/usr/local:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
fi

# remove duplicate path entries
export PATH=$(echo $PATH | awk -F: '
{ for (i = 1; i <= NF; i++) arr[$i]; }
END { for (i in arr) printf "%s:" , i; printf "\n"; } ')

# autocomplete ssh commands
complete -W "$(echo `cat ~/.bash_history | egrep '^ssh ' | sort | uniq | sed 's/^ssh //'`;)" ssh

##################################################
# Various options to make $HOME comfy        #
##################################################

if [ ! -d "${HOME}/bin" ]; then
    mkdir ${HOME}/bin
    chmod 700 ${HOME}/bin
    echo "${HOME}/bin was missing. I created it for you."
fi

if [ ! -d "${HOME}/Sites" ]; then
    mkdir -p "${HOME}/Sites"
    echo "${HOME}/Sites was missing. I created it for you."
fi

if [ ! -d "${HOME}/tmp" ]; then
    mkdir ${HOME}/tmp
    chmod 700 ${HOME}/tmp
    echo "${HOME}/tmp was missing.  I created it for you."
fi

##################################################
# Stop Flash from tracking everything you do.    #
##################################################

###### Brute force way to block all LSO cookies on Linux system with non-free Flash browser plugin
for A in ~/.adobe ~/.macromedia ; do ( [ -d $A ] && rm -rf $A ; ln -s -f /dev/null $A ) ; done

##################################################
##################################################
##################################################








######################################################################################################################################################
###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS
######################################################################################################################################################








##################################################
# 'Universal' completion function        #
##################################################

######  it works when commands have a so-called 'long options' mode
# ie: 'ls --all' instead of 'ls -a'
# Needs the '-o' option of grep
# (try the commented-out version if not available).
# First, remove '=' from completion word separators
# (this will allow completions like 'ls --color=auto' to work correctly).
COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}



##################################################
# To enable tab-completion with sudo         #
##################################################

###### alternatively, install bash-completion, which does this too
# complete -cf sudo



######################################################################################################################################################
###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS
######################################################################################################################################################



######################################################################################################################################################
#----- BASHRC ENDS HERE ------ BASHRC ENDS HERE ------ BASHRC ENDS HERE ------ BASHRC ENDS HERE ------ BASHRC ENDS HERE ------ BASHRC ENDS HERE ------
######################################################################################################################################################

fi  # end interactive check﻿
