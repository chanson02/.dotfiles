#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
declare -a dependencies=(
  'rbenv'
  'postgresql'
)
bash "$scripts_dir/install_package.sh" "${dependencies[@]}"
sudo service postgresql start
