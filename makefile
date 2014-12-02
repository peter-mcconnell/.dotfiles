help:
	@echo "install - installs vim setup"

install: clean linkrc
	@git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

linkrc:
	@ln -s `pwd`/.vimrc ~/.vimrc

clean:
	@rm -rf ~/.vim/bundle/
	@touch ~/.vimrc && mv ~/.vimrc ~/.vimrc.backup
