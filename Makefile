.PHONY: help install mv_dotfiles vundleplugins vundleinstall aptdeps neovim ohmytmux reloadshell

help:
	@echo "install - installs dotfiles"

neovim:
	@hash nvim || (\
		curl -L https://github.com/neovim/neovim/releases/download/v0.5.0/nvim-linux64.tar.gz -O \
		&& tar -xvf nvim-linux64.tar.gz --directory /usr/local \
		&& chmod u+x /usr/local/nvim-linux64/bin/nvim \
		&& ln -s /usr/local/nvim-linux64/bin/nvim /usr/local/bin/nvim \
	)

aptupdate:
	@apt-get update -yq

aptdeps: aptupdate
	@hash bash git curl vim jq tmux || \
		DEBIAN_FRONTEND=noninteractive apt-get install -yq bash git curl vim jq tmux

install: aptdeps neovim ohmytmux mv_dotfiles vundleplugins reloadshell
	@echo "installed"

ohmytmux:
	@git clone https://github.com/gpakosz/.tmux.git ~/.tmux
	@cd && ln -s -f .tmux/.tmux.conf && cp .tmux/.tmux.conf.local .

reloadshell:
	@exec bash -l

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
