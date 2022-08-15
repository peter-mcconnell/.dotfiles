.PHONY: install mv_dotfiles vundleplugins vundleinstall pipdeps deps neovim tmuxplugins tmux reloadshell linters nodedeps aptdeps

neovim:
	@hash nvim || (\
		rm -rf ~/neovimsrc \
		&& git clone https://github.com/neovim/neovim.git ~/neovimsrc \
		&& cd ~/neovimsrc/ \
		&& make CMAKE_BUILD_TYPE=RelWithDebInfo \
		&& sudo make install \
		&& rm -rf ~/neovimsrc \
	)

linters: aptupdate
	@curl -L https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 -o hadolint && chmod +x hadolint && sudo mv -n hadolint /usr/local/bin/hadolint
	@DEBIAN_FRONTEND=noninteractive sudo apt-get install -yq \
		shellcheck yamllint

aptupdate:
	@sudo apt-get update -yq

deps: aptupdate aptdeps nodedeps
	@if ! hash rg; then \
		curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb && \
		sudo dpkg -i ripgrep_12.1.1_amd64.deb && \
		rm ripgrep_12.1.1_amd64.deb; \
	fi
	@if ! hash fd; then \
		curl -LO https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb && \
		sudo dpkg -i fd_8.2.1_amd64.deb && \
		rm fd_8.2.1_amd64.deb; \
	fi

aptdeps:
	@hash bash git curl vim jq tmux nmap libtool cmake unzip bat htop nmon gcalcli pip3 fzf powerline xclip nikto regina okteta x3270 || \
		DEBIAN_FRONTEND=noninteractive sudo apt-get install -yq \
			bash \
			git \
			curl \
			vim \
			jq \
			tmux \
			nmap \
			fonts-powerline \
			libtool-bin \
			cmake \
			unzip \
			bat \
			htop \
			nmon \
			gcalcli \
			build-essential \
			pkg-config \
			gettext \
			python3 \
			python3-setuptools \
			python3-dev \
			python3-pip \
			fzf \
			xclip \
			nikto \
			powerline \
			regina-rexx \
			okteta \
			x3270 \
	@if [ -f /usr/bin/batcat ]; then sudo ln -sf /usr/bin/batcat /usr/bin/bat; fi

pipdeps:
	@if ! hash black radon bandit pylint ipdb3 doq pytest; then \
		pip3 install --user \
			black \
			radon \
			bandit \
			pylint \
			ipdb \
			neovim \
			doq \
			pytest; \
	fi

nodedeps:
	@hash node || if uname -a | grep -q "armv[0-9]"; then \
		curl -L https://nodejs.org/download/release/v16.9.1/node-v16.9.1-linux-`uname -a | grep -o -e "armv[^ ]*"`.tar.gz -o node.tar.gz; \
	else \
		curl -L https://nodejs.org/download/release/v16.9.1/node-v16.9.1-linux-x64.tar.gz -o node.tar.gz; \
	fi
	@hash node || (tar -xvf node.tar.gz \
		&& sudo cp -R node-v16.9.1-linux-*/* /usr/local/ \
		&& rm -rf node-v16.9.1-linux-* \
		&& rm node.tar.gz)
	@hash yarn || sudo npm install -g yarn

tmuxplugins: tmux
	@mkdir -p ~/.tmux/plugins
	@if [ ! -d ~/.tmux/plugins/tpm ]; then git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; fi
	@if [ ! -d ~/.tmux/plugins/tmux-resurrect ]; then git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/tmux-resurrect; fi


install: deps linters neovim tmuxplugins mv_dotfiles pipdeps vundleplugins reloadshell
	@echo "installed"

tmux:
	@mkdir -p ~/.tmux/
	@ln -fs `pwd`/tmux.conf ~/.tmux.conf

reloadshell:
	@exec bash -l

mv_dotfiles:
	@ln -fs `pwd`/config ~/.config
	@ln -fs `pwd`/config/nvim/init.vim ~/.vimrc
	@ln -fs `pwd`/bashrc.sh ~/.bashrc
	@ln -fs `pwd`/bash_profile.sh ~/.bash_profile
	@ln -fs `pwd`/exports.sh ~/.exports
	@ln -fs `pwd`/jira.sh ~/.jira
	@ln -fs `pwd`/aliases.sh ~/.aliases
	@ln -fs `pwd`/functions.sh ~/.functions
	@ln -fs `pwd`/dockerfunc.sh ~/.dockerfunc
	@ln -fs `pwd`/bash_git.sh ~/.bash_git
	@ln -fs `pwd`/zshrc ~/.zshrc
	@ln -fs `pwd`/fehbg.sh ~/.fehbg
	@ln -fs `pwd`/Xresources ~/.Xresources
	@ln -fs `pwd`/dircolors ~/.dircolors
	@ln -fs `pwd`/xinitrc.sh ~/.xinitrc

vundleplugins: vundleinstall
	@nvim +PluginClean +PluginInstall +GoInstallBinaries +UpdateRemotePlugins +qall
	@if [ ! -f ~/.vim/bundle/coc.nvim/build/index.js ]; then \
		cd ~/.vim/bundle/coc.nvim/ && \
		yarn install; \
	fi

vundleinstall:
	@if [ ! -d ${HOME}/.config/nvim/bundle/Vundle.vim/ ]; then git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim/; fi
