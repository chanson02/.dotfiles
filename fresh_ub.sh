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
do-release-upgrade -d


# Create Symbolic Link for gitconfig
echo $(ln -s ~/.dotfiles/gitconfig ~/.gitconfig)

# Install virtualbox
echo "Installing Various Dependencies"
apt install curl -y
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
apt install -y gcc g++ make nodejs yarn git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

# Install rails
bash ./rails.sh

# Install nvim
bash ./nvim.sh

reboot -y
