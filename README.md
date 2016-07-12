# .dotfiles

A selection of oddities to help with my own day to day. Feel free to steal - there's nothing new here though, have a good look around and you'll find some great examples of `.bashrc` & `.vimrc`'s. My `.dockerfunc` file is a personal favourite - inspired by [@jfrazelle](https://github.com/jfrazelle), go check her out.


## support

This repo has been designed with OSX in mind. **Many things would be easier on Linux**, and we could avail of some really really cool things like mounting the display socket in our containers, or using `--net=host`, so if you **are not** an OSX user I'd strongly recommend tweaking this repo to suit your needs / avail of all the cool stuff.

## volumes

It's worth noting that I've dedicated a directory on my machine to act as a home for all of my container volumes - for me this is `~/v/`. Tweak this to suit your needs (esp. in `.dockerfunc`)

## requirements

- Docker
- Vim (and Vundle)

## install

- `make install`