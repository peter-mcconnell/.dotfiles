.PHONY: install mv_dotfiles vimpluginstall pipdeps deps neovim tmuxplugins tmux reloadshell linters nodedeps aptdeps test docker kube vpns terragrunt

test:

vpns:
	@hash tailscale || (\
		curl -fsSL https://tailscale.com/install.sh | sh \
	)

kube:
	# install kubectl
	@hash kubectl || (\
    curl -L "https://dl.k8s.io/release/$(shell curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /tmp/kubectl && \
		sudo install /tmp/kubectl /usr/local/bin/kubectl \
	)
	# install krew
	hash kubectl-ctx || (\
  		cd "$(shell mktemp -d)" && \
  		OS="linux" && \
		ARCH="amd64" && \
  		curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz" && \
  		tar zxvf "krew-linux_amd64.tar.gz" && \
  		./krew-linux_amd64 install krew \
	)
	# install ctx
	@PATH="$(PATH):$(HOME)/.krew/bin"; kubectl krew install ctx
	# install ns
	@PATH="$(PATH):$(HOME)/.krew/bin"; kubectl krew install ns

docker:
	@hash docker || (\
		sudo apt-get install -yq \
			ca-certificates \
			curl \
			gnupg \
			lsb-release && \
		mkdir -p /etc/apt/keyrings && \
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg --batch --yes && \
		echo "deb [arch=$(shell dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(shell lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  		sudo apt-get update && \
		sudo apt-get install -yq docker-ce docker-ce-cli containerd.io docker-compose-plugin \
	);
	sudo groupadd docker || true
	sudo usermod -aG docker $(shell whoami) || true
	newgrp docker || true

neovim:
	@hash git cmake libtools || sudo apt-get install -yq git cmake gettext libtool-bin
	@hash nvim || (\
		rm -rf ~/neovimsrc \
		&& git clone https://github.com/neovim/neovim.git ~/neovimsrc \
		&& cd ~/neovimsrc/ \
		&& make CMAKE_BUILD_TYPE=RelWithDebInfo \
		&& sudo make install \
		&& rm -rf ~/neovimsrc \
	)

rust:
	@if ! command -v rustup > /dev/null 2>&1; then curl https://sh.rustup.rs -sSf -o /tmp/rustup.sh && sh /tmp/rustup.sh -y && rm /tmp/rustup.sh; fi

linters:
	@curl -L https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 -o hadolint && chmod +x hadolint && sudo mv -n hadolint /usr/local/bin/hadolint
	@DEBIAN_FRONTEND=noninteractive sudo apt-get install -yq \
		shellcheck yamllint

deps: aptdeps nodedeps
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
	@hash bash git curl jq tmux nmap libtool cmake unzip bat htop nmon gcalcli pip3 fzf powerline xclip nikto lua hugo regina okteta x3270 || \
		sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -yq \
			bash \
			git \
			curl \
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
			bpfcc-tools \
			bpftrace \
			linux-tools-generic \
			linux-cloud-tools-generic \
      hugo \
      lua5.3
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


install: deps linters neovim tmuxplugins mv_dotfiles pipdeps reloadshell rust docker kube
	@echo "installed"

tmux:
	@mkdir -p ~/.tmux/
	@ln -fs `pwd`/tmux.conf ~/.tmux.conf

reloadshell:
	@exec bash -l

terragrunt:
	@curl -L https://github.com/gruntwork-io/terragrunt/releases/download/v0.42.7/terragrunt_linux_amd64 -o /tmp/terragrunt
	@sudo install /tmp/terragrunt /usr/local/bin/terragrunt
	@rm /tmp/terragrunt

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

vimpluginstall:
	@hash lua || sudo apt-get install -yq lua5.3
	@if [ ! -f /usr/local/bin/lua ]; then sudo ln -sf $(which lua) /usr/local/bin/lua; fi
	@mkdir -p $(HOME)/.local/share/nvim/lazy/lazy.nvim/lua/lazy/
	@nvim +PackerInstall +qa
