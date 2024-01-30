#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
bash "$scripts_dir/install_package.sh" "postgresql"
(bash "$scripts_dir/install_package.sh" "libpq-dev") || true # debian
(bash "$scripts_dir/install_package.sh" "postgresql-devel") || true # RHEL

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
eval "$(~/.rbenv/bin/rbenv init - bash)"

git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

echo '!!! Restart shell to finsih rbenv install'
sudo service postgresql start

# postgres can give issues on fedora
# https://www.postgresql.org/download/linux/redhat/
curl https://cli-assets.heroku.com/install.sh | sh
