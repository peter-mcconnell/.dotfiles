.PHONY: install test full deps

EXTRA_VARS?=hosts=local

# Opt in to the topics that are tagged `never` (llvm, java, ghidra), e.g.
#   make install TAGS=ghidra      everything, plus ghidra
#   make install TOPICS=ghidra    only ghidra, nothing else
TAGS?=
TOPICS?=
ifneq ($(TOPICS),)
TAG_ARGS=--tags "$(TOPICS)"
else ifneq ($(TAGS),)
TAG_ARGS=--tags "all,$(TAGS)"
else
TAG_ARGS=
endif

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
	ansible-playbook playbook.yaml --extra-vars "$(EXTRA_VARS)" $(TAG_ARGS) -K
