# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
[[ -d "${HOME}/.oh-my-zsh" ]] && export ZSH="${HOME}/.oh-my-zsh"
[[ -d "${HOME}/.oh-my-zsh" ]] && ZSH_THEME="agnoster"
[[ -d "${HOME}/.oh-my-zsh" ]] && plugins=(git)
[[ -d "${HOME}/.oh-my-zsh" ]] && source $ZSH/oh-my-zsh.sh

export SKIP_PS1=1  # ignore bashrc's attempt at PS1
source ~/.bashrc
source ~/.aliases
source ~/.exports

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

autoload -U +X bashcompinit && bashcompinit
