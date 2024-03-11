#!/bin/bash

install_with() {
  local manager="$1"
  local package="$2"

  # adjust package name for dnf
  if [ "$manager" == "dnf" ] && [[ "$package" == *"-dev" ]]; then
    package="${package/-dev/-devel}"
  fi

  echo "Installing $package with $manager..."
  output=$(sudo $manager install -y $package 2>&1)
  
  local exit_code=$?

  if echo "$output" | grep -q "but there is a snap with that name"; then
    sudo snap install "$package" --classic
  elif [ $exit_code -ne 0 ]; then
    echo "WARN: $output"
  fi
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
