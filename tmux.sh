home=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6) # home dir

apt-get update
apt-get upgrade
apt-get install git
apt-get install tmux

git clone https://github.com/tmux-plugins/tmp $home/.tmux/plugins/tpm

mkdir -p $home/.config/tmux
ln -s $home/.dotfiles/tmux.conf $home/.tmux.conf
