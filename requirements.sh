#!/bin/bash

# os-specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  ./requirements/osx.sh
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  ./requirements/linux-gnu.sh
fi

# general (requirements installed in os-specific area)
if ! [ -x "$(command -v wtf)" ]; then
  go get github.com/senorprogrammer/wtf
  cd $GOPATH/src/github.com/senorprogrammer/wtf
  make install
  make run
fi
