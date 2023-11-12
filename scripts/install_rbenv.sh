#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
declare -a dependences=(
  'rbenv'
)
bash "$scripts_dir/install_package.sh" "${dependencies[@]}"
