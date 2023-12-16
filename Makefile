.PHONY: install test full

EXTRA_VARS?=hosts=local

test:

full: EXTRA_VARS += neovim_nightly_update=True
full: install

install:
	@if ! command -v ansible > /dev/null; then sudo apt-get install -yq ansible; fi
	ansible-playbook playbook.yaml --extra-vars "$(EXTRA_VARS)" -K
