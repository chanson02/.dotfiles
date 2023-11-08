#!/bin/bash
url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
out_path="/usr/local/bin/nvim-linux64"
install="nvim.tar.gz"

curl -L $url -o $install
sudo mkdir -p $out_path
sudo tar -xzvf $install -C $out_path --strip-components=1
rm $install

if [ ! -L "/usr/local/bin/nvim" ]; then
  sudo ln -s "$out_path/bin/nvim" /usr/local/bin/nvim
fi
