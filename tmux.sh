#!/bin/bash
home=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6) # home dir

apt-get update
apt-get upgrade
apt-get install -y git tmux

git clone https://github.com/tmux-plugins/tmp $home/.tmux/plugins/tpm

mkdir -p $home/.config/tmux
ln -s $home/.dotfiles/tmux.conf $home/.tmux.conf

# install plugins
tmux new-session -d
bash $home/.tmux/plugins/tpm/bin/install_plugins
tmux kill-session -t 0
