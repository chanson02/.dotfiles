#!/bin/bash
src_dir="$HOME/src"

if [ ! -d "$src_dir" ]; then
  mkdir -p "$src_dir"
fi

nvim_dir="$src_dir/neovim"
if [ ! -d "$nvim_dir" ]; then
  git clone https://github.com/neovim/neovim $nvim_dir
fi

cd $nvim_dir
git pull origin master
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd -
