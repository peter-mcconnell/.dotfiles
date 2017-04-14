.PHONY: help install vim bash bashprofile bashaliases tmux vundle vundleplugins clean

help:
	@echo "install - installs dotfiles"

install: tmux vundle vim bashprofile bashaliases bashgit bash vundleplugins
	@echo "installed"

vim:
	@ln -fs `pwd`/vimrc ~/.vimrc

bash: 
	@ln -fs `pwd`/bashrc ~/.bashrc

bashprofile:
	@ln -fs `pwd`/bash_profile ~/.bash_profile

bashaliases:
	@ln -fs `pwd`/bash_aliases ~/.bash_aliases
	@ln -fs `pwd`/dockerfunc ~/.dockerfunc

bashgit: 
	@ln -fs `pwd`/bash_git ~/.bash_git

tmux:
	@ln -fs `pwd`/tmux.conf ~/.tmux.conf

vundle:
	@if ! test -d ~/.vim/bundle; \
	then git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; \
	fi

vundleplugins:
	@vim +PluginClean +PluginInstall +qall
