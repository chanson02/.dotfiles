#!/bin/bash
### This is only setup for fedora atm

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
hypr_dir="$(dirname $scripts_dir)/hypr"
waybar_dir="$(dirname $scripts_dir)/waybar"
git submodule update --init --recursive  # Requires ssh key to be set

source "$HOME/.bashrc"
source "$scripts_dir/update_pyenv.sh" # requires pyenv
sudo dnf copr enable solopasha/hyprland
sudo dnf copr enable jaques22/xdg-desktop-portal-hyprland

declare -a dependencies=(
  'hyprland'
  'waybar'
  'gobject-introspeciton-devel'
  'feh'
  'xdg-desktop-portal-hyprland'
  'dunst'
  'grim'
  'slurp'
  'rofi-wayland'
  'hyprpaper'
)
bash "$scripts_dir/install_package.sh" "${dependencies[@]}"

config="$HOME/.config"
rm -rf $config/hypr
rm -rf $config/waybar
ln -s "$hypr_dir" "$config"
ln -s "$waybar_dir" "$config"

pyenv virtualenv waybar
pyenv activate waybar
pip install -r "$waybar_dir/waybar-mediaplayer/requirements.txt"
pyenv deactivate
