#! /usr/bin/bash

# Dependencies
apt install curl -y
apt-get remove neovim -y # delete old nvim if installed

# This link redirects to the newest version of nvim
nvim_redirect='https://github.com/neovim/neovim/releases/latest'
# -L follows redirect, -s silent output, -w get url
nvim_command="curl -Ls -w %{url_effective} $nvim_redirect"
nvim_home=$($nvim_command | tail -n1) # the last line is the url
nvim_version=$(echo $nvim_home | rev | cut -d'/' -f 1 | rev) # split on / and get last
nvim_download="https://github.com/neovim/neovim/releases/download/$nvim_version/nvim-linux64.deb"

nvim_installer="nvim_linux64_$nvim_version.deb"

curl -L $nvim_download -o $nvim_installer
dpkg -i ./$nvim_installer
apt-get install -f -y
rm $nvim_installer
