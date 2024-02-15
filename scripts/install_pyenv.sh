#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
declare -a dependencies=(
  'curl'
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
)
bash "$scripts_dir/install_package.sh" "${dependencies[@]}"

rm -rf $HOME/.pyenv
curl "https://pyenv.run" | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

echo "!!! Restart Shell for Pyenv to finsih installing"
