# .dotfiles

[![Publish Docker image](https://github.com/peter-mcconnell/.dotfiles/actions/workflows/yeet.yml/badge.svg)](https://github.com/peter-mcconnell/.dotfiles/actions/workflows/yeet.yml)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/pemcconnell/dev?label=docker%20image%20size)](https://hub.docker.com/repository/docker/pemcconnell/dev)

Personal dotfiles. ubuntu / macos / tmux / neovim. single command install.

![only l33t little bots may contribute](./media/banner-robot.png)

Dependencies:

- ubuntu: `sudo apt install -yq make ansible`
- macos: `brew install ansible` (make comes with the Command Line Tools), plus
  [homebrew](https://brew.sh) itself

`make` installs ansible and the required collections for you if they are missing.

## install locally

`inventory/local.ini` already points the `local` group at this machine, so:

```sh
make full
```

`./ansible.cfg` loads everything in `./inventory/`, so drop additional inventory
files in there for remote targets.

## layout

`playbook.yaml` gathers facts, loads `vars/<os_family>.yaml` and then hands off
to `tasks/<os_family>/main.yaml`, which lists the topics that apply to that
platform in order. Task files therefore never branch on the OS:

```
vars/Debian.yaml      package lists + paths for ubuntu
vars/Darwin.yaml      package lists + paths for macos
tasks/Debian/         apt, source builds, X11 dotfiles
tasks/Darwin/         homebrew
tasks/common/         works as-is on both (dotfiles, git, ssh, rust, ...)
```

Adding a platform means a `vars/<os_family>.yaml` and a
`tasks/<os_family>/main.yaml`; anything a topic cannot support there is simply
left out of that `main.yaml`.

## docker

A docker image has been provided - mostly this is just to validate the dotfiles inside a 'clean' environment but it is useable if a docker dev env is your thing:

```sh
docker run --rm -ti pemcconnell/dev:master
```