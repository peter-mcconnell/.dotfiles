#!/bin/sh

# install homebrew
if ! [ -x "$(command -v brew)" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install cask
brew tap homebrew/cask

# install desired software
if ! [ -x "$(command -v go)" ]; then
  brew install go
fi
if ! [ -x "$(command -v terraform)" ]; then
  brew install terraform
fi
if ! [ -x "$(command -v python3)" ]; then
  brew install python3
fi
if ! [ -x "$(command -v docker)" ]; then
  brew cask install docker
fi
brew cask install iterm2

pip3 install neovim

# upgrade ?
read -p "brew upgrade? this may take a while. [y|n]" -n 1 -r
echo    # (optional)
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew upgrade
fi
