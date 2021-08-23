export ZSH="${HOME}/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export SKIP_PS1=1  # ignore bashrc's attempt at PS1
source ~/.bashrc

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
