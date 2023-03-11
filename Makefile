.PHONY: install deps tmuxplugins tmux reloadshell linters test

test:

install:
	@if command -v ansible; then sudo apt-get install -yq ansible; fi
	@ansible-playbook -i inventory.ini playbook.yaml --extra-vars "hosts=local" -vv -K

linters:
	@curl -L https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 -o hadolint && chmod +x hadolint && sudo mv -n hadolint /usr/local/bin/hadolint
	@DEBIAN_FRONTEND=noninteractive sudo apt-get install -yq \
		shellcheck yamllint

deps:
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

tmuxplugins: tmux
	@mkdir -p ~/.tmux/plugins
	@if [ ! -d ~/.tmux/plugins/tpm ]; then git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; fi
	@if [ ! -d ~/.tmux/plugins/tmux-resurrect ]; then git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/tmux-resurrect; fi

tmux:
	@mkdir -p ~/.tmux/
	@ln -fs `pwd`/tmux.conf ~/.tmux.conf

reloadshell:
	@exec bash -l
