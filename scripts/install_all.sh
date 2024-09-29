#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
bash "$scripts_dir/install_nvim.sh" # also installs fonts
bash "$scripts_dir/install_zellij.sh"
source "$scripts_dir/update_pyenv.sh"
bash "$scripts_dir/install_rbenv.sh" # also installs psql
bash "$scripts_dir/set_gitconfig.sh"
bash "$scripts_dir/install_bash_tools.sh"

curl -s "https://get.sdkman.io" | bash # install java tools
