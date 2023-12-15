# .dotfiles

[![Publish Docker image](https://github.com/peter-mcconnell/.dotfiles/actions/workflows/yeet.yml/badge.svg)](https://github.com/peter-mcconnell/.dotfiles/actions/workflows/yeet.yml)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/pemcconnell/dev?label=docker%20image%20size)](https://hub.docker.com/repository/docker/pemcconnell/dev)

Personal dotfiles. ubuntu / tmux / neovim. single command install.

![only l33t little bots may contribute](./media/banner-robot.png)

`sudo apt install ansible` - that should be all the dependencies


## install locally

This repo pulls in my personal .ini file which likely won't make sense for you. You can create `./inventory/homelab.ini` like so:

```
[local]
localhost ansible_connection=local
```

Then you can run the playbook against that target:

```sh
ansible-playbook playbook.yaml --extra-vars "hosts=local" -K

# or to include neovim nightly updates
ansible-playbook playbook.yaml --extra-vars "hosts=local neovim_nightly_update=True" -K
```

## run against remotes

`ansible-playbook playbook.yaml --extra-vars "hosts=something"`


## docker

A docker image has been provided - mostly this is just to validate the dotfiles inside a 'clean' environment but it is useable if a docker dev env is your thing:

```sh
docker run --rm -ti pemcconnell/dev:master
```