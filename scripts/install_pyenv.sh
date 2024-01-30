#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
declare -a dependencies=(
  'curl'
  'zlib-devel'
  'bzip2-devel'
  'ncurses-devel'
  'readline-devel'
  'tk-devel'
  'xz-devel'
  'sqlite-devel'
)
bash "$scripts_dir/install_package.sh" "${dependencies[@]}"

rm -rf $HOME/.pyenv
curl "https://pyenv.run" | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

echo "!!! Restart Shell for Pyenv to finsih installing"
