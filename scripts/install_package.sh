#!/bin/bash

echo "The deps are $@"
if [ -x "$(command -v apt)" ]; then
  sudo apt install "$@"
elif [ -x "$(command -v dnf)" ]; then
  sudo dnf install "$@"
else
  echo "unexpected package manager"
  exit 1
fi
