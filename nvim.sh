#! /usr/bin/bash

# Dependencies
apt install curl gcc g++ -y
apt-get --purge remove neovim -y # delete old nvim if installed

# This link redirects to the newest version of nvim
nvim_redirect='https://github.com/neovim/neovim/releases/latest'
# -L follows redirect, -s silent output, -w get url
nvim_command="curl -Ls -w %{url_effective} $nvim_redirect"
nvim_home=$($nvim_command | tail -n1) # the last line is the url
nvim_version=$(echo $nvim_home | rev | cut -d'/' -f 1 | rev) # split on / and get last
nvim_download="https://github.com/neovim/neovim/releases/download/$nvim_version/nvim-linux64.deb"
nvim_installer="nvim_linux64_$nvim_version.deb"

# Download / Install Neovim
curl -L $nvim_download -o $nvim_installer
dpkg -i ./$nvim_installer
apt-get install -f -y
rm $nvim_installer
apt autoremove

# Create nvim config
home=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6) # home dir
nvim_home="$home/.config/nvim/plugin"
mkdir -p $nvim_home
if [ -f "$nvim_home/init.lua" ] ; then rm $nvim_home/init.lua; fi
if [ -d "$nvim_home/lua"]; then rm -Rf $nvim_home/lua; fi

ln -s $home/.dotfiles/init.lua $home/.config/nvim/init.lua
ln -s $home/.dotfiles/lua $home/.config/nvim/lua

sudo -u $SUDO_USER nvim -c "q" # Install packer
sudo -u $SUDO_USER nvim -c "w" $home/.dotfiles/lua/chanson/plugins.lua # Install plugins
