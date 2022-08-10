#! /usr/bin/bash

# echo $(command) - runs command
# read var - waits for user input
# "$var" - string interpolation
# $1.. $n - passed in args
# if [ $var ] else fi

apt-get update -y
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get install update-manager-core -y
do-release-upgrade -d -y


# Create Symbolic Link for gitconfig
echo $(ln -s ~/.dotfiles/gitconfig ~/.gitconfig)

# Install virtualbox
echo "Installing Various Dependencies"
apt-get install curl virtualbox -y

reboot -y
