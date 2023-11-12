#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
declare -a dependencies=(
  'rbenv'
  'postgresql'
)

bash "$scripts_dir/install_package.sh" "${dependencies[@]}"
(bash "$scripts_dir/install_package.sh" "libpq-dev") || true # debian
(bash "$scripts_dir/install_package.sh" "postgresql-devel") || true # RHEL
sudo service postgresql start
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
