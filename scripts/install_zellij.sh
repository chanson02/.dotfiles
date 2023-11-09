#1/bin/bash

if command -v dnf &> /dev/null; then
  sudo dnf copr enable varlad/zellij
fi
bash "$scripts_dir/install_package.sh" "zellij"
