#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dfiles_dir="$(dirname $scripts_dir)/nvim"

declare -a dependencies=(
  'build-essential' # c compiler for ubuntu
  'gcc' # c compiler for fedora?
  'make' # required on fedora
  'curl'
  'ripgrep' # BurntSushi/ripgrep - recursively search directories
  'fd-find' # sharkdp/fd - faster file finder
  'xclip' # astrand/xclip - CLI for X11 clipboard
  'wl-clipboard' # bugaevc/wl-clipboard - CLI for Wayland clipboard
  'nodejs' # required for some language servers
)
bash "$scripts_dir/install_package.sh" "${dependencies[@]}"

# Install fonts
"$scripts_dir/install_fonts.sh"

# Install nvim
"$scripts_dir/update_nvim.sh"

config="$HOME/.config"
rm -rf $config/nvim # remove old config
ln -s "$dfiles_dir" "$config"

# Set as default editor
export EDITOR="/usr/local/bin/nvim"
echo "export EDITOR=$EDITOR" >> ~/.bashrc
