# .dotfiles

[![Publish Docker image](https://github.com/peter-mcconnell/.dotfiles/actions/workflows/yeet.yml/badge.svg)](https://github.com/peter-mcconnell/.dotfiles/actions/workflows/yeet.yml)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/pemcconnell/dev?label=docker%20image%20size)](https://hub.docker.com/repository/docker/pemcconnell/dev)

A selection of oddities to help with my own day to day. Used mostly on OSX / debian / arch. No guarantees

## volumes

It's worth noting that I've dedicated a directory on my machine to act as a home for all of my container volumes - for me this is `~/v/`. Tweak this to suit your needs (esp. in `.dockerfunc`)

## requirements

- `make`

## docker

A docker image has been provided - mostly this is just to validate the dotfiles inside a 'clean' environment but it is useable if a docker dev env is your thing:

```sh
docker run --rm -ti pemcconnell/dev:master
```

## install

- `make install`