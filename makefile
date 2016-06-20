help:
	@echo "install - installs dotfiles"

install: clean tmux vundle vim bashprofile bashaliases bash vundleplugins
	@echo "installed"

vim:
	@ln -s `pwd`/vimrc ~/.vimrc

bash: 
	@ln -s `pwd`/bashrc ~/.bashrc

bashprofile:
	@ln -s `pwd`/bash_profile ~/.bash_profile

bashaliases:
	@ln -s `pwd`/bash_aliases ~/.bash_aliases
	@ln -s `pwd`/dockerfunc ~/.dockerfunc

tmux:
	@ln -s `pwd`/tmux.conf ~/.tmux.conf

vundle:
	@if [ -d "~/.vim/bundle" ]; then git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim; fi

vundleplugins:
	@vim +PluginClean +PluginInstall +qall

clean:
	@touch ~/.tmux.conf && mv ~/.tmux.conf ~/.tmux.conf.backup
	@touch ~/.bashrc && mv ~/.bashrc ~/.bashrc.backup
	@touch ~/.bash_aliases && mv ~/.bash_aliases ~/.bash_aliases.backup
	@touch ~/.dockerfunc && mv ~/.dockerfunc ~/.dockerfunc.backup
	@touch ~/.bash_profile && mv ~/.bash_profile ~/.bash_profile.backup
	@touch ~/.vimrc && mv ~/.vimrc ~/.vimrc.backup
