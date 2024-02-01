#!/bin/bash

install_with() {
  local manager="$1"
  local package="$2"
  output=$(sudo $manager install -y $package 2>&1)

  if echo "$output" | grep -q "but thre is a snap with that name"; then
    sudo snap install "$@" --classic
  fi
}

if [ -x "$(command -v apt)" ]; then
  manager="apt-get"
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
