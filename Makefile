.PHONY: install test full deps

EXTRA_VARS?=hosts=local

test:

full: EXTRA_VARS += neovim_nightly_update=True
full: install

deps:
	@if ! command -v ansible > /dev/null; then \
	  if [ "$$(uname -s)" = "Darwin" ]; then brew install ansible; \
	  else sudo apt-get install -yq ansible; fi; \
	fi
	ansible-galaxy collection install -r requirements.yaml

install: deps
	ansible-playbook playbook.yaml --extra-vars "$(EXTRA_VARS)" -K
