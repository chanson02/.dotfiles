#! /usr/bin/bash
home=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6) # home dir

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
do-release-upgrade -d


# Create Symbolic Link for gitconfig
echo $(ln -s $home/.dotfiles/gitconfig $home/.gitconfig)

reboot -y
