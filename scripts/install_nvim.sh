#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dfiles_dir="$(dirname $scripts_dir)/nvim"

# Install fonts
#"$scripts_dir/install_fonts.sh"

# Install nvim
#"$scripts_dir/update_nvim.sh"

nvim_home="$HOME/.config/nvim"
mkdir -p $nvim_home

if [ -f "$nvim_home/init.lua" ]; then rm $nvim_home/init.lua; fi
ln -s "$dfiles_dir/init.lua" "$nvim_home/init.lua"
