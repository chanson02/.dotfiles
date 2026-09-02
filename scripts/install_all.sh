#!/bin/bash

set -e

dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"
scripts_dir="$dotfiles/scripts"

bash "$scripts_dir/install_symlinks.sh"
bash "$scripts_dir/install_calamp.sh"

omarchy pkg add postgresql

"$dotfiles/bash_tools/add_to_bashrc" 'PS0="${PS0}\033]133;A\007"'
"$dotfiles/bash_tools/add_to_bashrc" 'source "$HOME/.config/opencode/opencode.sh"'

curl https://mise.run | sh
"$HOME/.local/bin/mise" use -g python@latest ruby@latest node@latest heroku@latest rust@latest

curl -LsSf https://astral.sh/uv/install.sh | sh
