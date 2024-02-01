#!/bin/bash

install_with() {
  local manager="$1"
  local package="$2"
  sudo $manager install -y $package || true
}

if [ -x "$(command -v apt)" ]; then
  manager="apt"
elif [ -x "$(command -v dnf)" ]; then
  manager="dnf"
else
  echo "Unsupported package manager"
  exit 1
fi

packages=( "$@" )
for package in "${packages[@]}"; do
  install_with $manager "$package"
done
