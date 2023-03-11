.PHONY: install test

test:

install:
	@if command -v ansible; then sudo apt-get install -yq ansible; fi
	@ansible-playbook -i inventory.ini playbook.yaml --extra-vars "hosts=local" -vv -K
