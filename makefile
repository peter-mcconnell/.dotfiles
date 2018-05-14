.PHONY: help install mv_dotfiles vundleplugins vundleinstall

help:
	@echo "install - installs dotfiles"

install: mv_dotfiles vundleplugins
	@echo "installed"

mv_dotfiles:
	@mv ~/.vim/ ~/.config/nvim
	@ln -fs `pwd`/config/nvim/ ~/.vim/
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

vundleplugins: vundleinstall
	@vim +PluginClean +PluginInstall +GoInstallBinaries +qall

vundleinstall:
	@if [[ ! -d ${HOME}/.vim/bundle/Vundle.vim ]]; then git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; fi
