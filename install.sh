#! /usr/bin/bash

# echo $(command) - runs command
# read var - waits for user input
# "$var" - string interpolation
# $1.. $n - passed in args
# if [ $var ] else fi

# Create Symbolic Link for gitconfig
echo $(ln -s ~/.dotfiles/gitconfig ~/.gitconfig)

# Install virtualbox
echo "Installing VirtualBox"
echo $(sudo apt-get install -y virtualbox)
