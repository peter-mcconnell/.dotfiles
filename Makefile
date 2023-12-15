.PHONY: install test

test:

install:
	@if ! command -v ansible > /dev/null; then sudo apt-get install -yq ansible; fi
	@ansible-playbook  playbook.yaml --extra-vars "hosts=local" -K
