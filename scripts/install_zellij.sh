#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dfiles_dir="$(dirname $scripts_dir)"

if command -v dnf &> /dev/null; then
  sudo dnf copr enable varlad/zellij
fi
bash "$scripts_dir/install_package.sh" "zellij"

zell_home="$HOME/.config/zellij"
mkdir -p $zell_home
rm -rf $zell_home # remove old zellig
ln -s "$dfiles_dir/zellij" "$zell_home"
