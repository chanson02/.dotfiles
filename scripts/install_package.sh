#!/bin/bash

echo "The deps are $@"
if [ -x "$(command -v apt)" ]; then
  output=$(sudo apt install -y "$@" 2>$1)
elif [ -x "$(command -v dnf)" ]; then
  output=$(sudo dnf install -y "$@" 2>$1)
else
  echo "unexpected package manager"
  exit 1
fi

if echo "$output" | grep -q "but there is a snap with that name"; then
  sudo snap install "$@" --classic
fi
