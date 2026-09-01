#!/bin/bash

set -e

scripts_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

bash "$scripts_dir/install_utils.sh"
bash "$scripts_dir/set_gitconfig.sh"
bash "$scripts_dir/install_mise.sh"
