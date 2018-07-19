#!/usr/bin/env bash

# os-specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  ./requirements/osx.sh
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  ./requirements/linux-gnu.sh
fi
