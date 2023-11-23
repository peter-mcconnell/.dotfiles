.PHONY: install test

test:

install:
	@if ! command -v ansible > /dev/null; then sudo apt-get install -yq ansible; fi
	@ansible-playbook -i ./inventory/homelab.ini playbook.yaml --extra-vars "hosts=localhost" -vv -K
