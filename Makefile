.PHONY: help install mv_dotfiles vundleplugins vundleinstall

help:
	@echo "install - installs dotfiles"

install: mv_dotfiles vundleplugins
	@echo "installed"

mv_dotfiles:
	@mkdir -p ~/.config/nvim/
	@ln -fs `pwd`/config ~/.config
	@ln -fs `pwd`/vimrc ~/.vimrc
	@ln -fs `pwd`/vimrc ~/.config/nvim/init.vim
	@ln -fs `pwd`/bashrc.sh ~/.bashrc
	@ln -fs `pwd`/bash_profile.sh ~/.bash_profile
	@ln -fs `pwd`/exports.sh ~/.exports
	@ln -fs `pwd`/aliases.sh ~/.aliases
	@ln -fs `pwd`/functions.sh ~/.functions
	@ln -fs `pwd`/dockerfunc.sh ~/.dockerfunc
	@ln -fs `pwd`/bash_git.sh ~/.bash_git
	@ln -fs `pwd`/tmux.conf ~/.tmux.conf
	@ln -fs `pwd`/zshrc ~/.zshrc
	@ln -fs `pwd`/fehbg.sh ~/.fehbg
	@ln -fs `pwd`/Xresources ~/.Xresources
	@ln -fs `pwd`/dircolors ~/.dircolors
	@ln -fs `pwd`/tmux.conf ~/.tmux.conf
	@ln -fs `pwd`/xinitrc.sh ~/.xinitrc

vundleplugins: vundleinstall
	@nvim +PluginClean +PluginInstall +GoInstallBinaries +UpdateRemotePlugins +qall

vundleinstall:
	@if [ ! -d ${HOME}/.config/nvim/bundle/Vundle.vim/ ]; then git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim/; fi
