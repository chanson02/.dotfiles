#!/bin/bash

if [ -x "$(command -v apt)" ]; then
  sudo apt install "$1"
elif [ -x "$(command -v dnf)" ]; then
  sudo dnf install "$1"
else
  echo "unexpected package manager"
  exit 1
fi
