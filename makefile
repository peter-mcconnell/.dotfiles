.PHONY: help install mv_dotfiles vundleplugins

help:
	@echo "install - installs dotfiles"

install: mv_dotfiles vundleplugins
	@echo "installed"

mv_dotfiles:
	@mkdir -p `pwd`/config/nvim
	@ln -fs `pwd`/config ~/.config
	@ln -fs `pwd`/vimrc ~/.vimrc
	@ln -fs `pwd`/vimrc ~/.config/nvim/init.vim
	@ln -fs `pwd`/bashrc ~/.bashrc
	@ln -fs `pwd`/bash_profile ~/.bash_profile
	@ln -fs `pwd`/exports ~/.exports
	@ln -fs `pwd`/aliases ~/.aliases
	@ln -fs `pwd`/functions ~/.functions
	@ln -fs `pwd`/dockerfunc ~/.dockerfunc
	@ln -fs `pwd`/bash_git ~/.bash_git
	@ln -fs `pwd`/tmux.conf ~/.tmux.conf
	@ln -fs `pwd`/zshrc ~/.zshrc
	@ln -fs `pwd`/fehbg ~/.fehbg

vundleplugins:
	@vim +PluginClean +PluginInstall +qall
