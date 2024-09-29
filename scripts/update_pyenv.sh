#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
declare -a dependencies=(
  'curl'
  'gcc'
  'libbz2-dev'
  'zlib-devel'
  'bzip2-devel'
  'libncurses5-dev'
  'ncurses-devel'
  'libreadline-dev'
  'readline-devel'
  'tk-dev'
  'xz-devel'
  'libsqlite3-dev'
  'sqlite-devel'
  'libssl-dev'
  'openssl-devel'
)
bash "$scripts_dir/install_package.sh" "${dependencies[@]}"
if [ -d "$PYENV_ROOT" ]; then
  pyenv update
  return 0
fi

bash "$scripts_dir/../bash_tools/add_to_bashrc" 'export PYENV_ROOT="$HOME/.pyenv"'
bash "$scripts_dir/../bash_tools/add_to_bashrc" '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"'
bash "$scripts_dir/../bash_tools/add_to_bashrc" 'eval "$(pyenv init -)"'
bash "$scripts_dir/../bash_tools/add_to_bashrc" 'eval "$(pyenv virtualenv-init -)"'

curl "https://pyenv.run" | bash
source ~/.bashrc

version=$(pyenv install --list | grep -v '[a-zA-Z]' | tail -n 1)
pyenv install $version
pyenv global $version
