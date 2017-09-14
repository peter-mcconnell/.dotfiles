.PHONY: help install mv_dotfiles vundle vundleplugins

help:
	@echo "install - installs dotfiles"

install: mv_dotfiles vundle vundleplugins
	@echo "installed"

mv_dotfiles:
	@ln -fs `pwd`/vimrc ~/.vimrc
	@ln -fs `pwd`/bashrc ~/.bashrc
	@ln -fs `pwd`/bash_profile ~/.bash_profile
	@ln -fs `pwd`/exports ~/.exports
	@ln -fs `pwd`/aliases ~/.aliases
	@ln -fs `pwd`/functions ~/.functions
	@ln -fs `pwd`/dockerfunc ~/.dockerfunc
	@ln -fs `pwd`/bash_git ~/.bash_git
	@ln -fs `pwd`/tmux.conf ~/.tmux.conf
	@ln -fs `pwd`/zshrc ~/.zshrc
	@ln -fs `pwd`/config ~/.config

vundle:
	@if ! test -d ~/.vim/bundle; \
	then git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; \
	fi

vundleplugins:
	@vim +PluginClean +PluginInstall +qall
