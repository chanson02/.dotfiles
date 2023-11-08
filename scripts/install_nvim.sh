#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dfiles_dir="$(dirname $scripts_dir)/nvim"

# Install fonts
#"$scripts_dir/install_fonts.sh"

# Install nvim
#"$scripts_dir/update_nvim.sh"

nvim_home="$HOME/.config/nvim"
mkdir -p $nvim_home
rm -rf $nvim_home/* # remove old config
for file in "$dfiles_dir"/*; do
  ln -s $file "$nvim_home/$(basename "$file")"
done
