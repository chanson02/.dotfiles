#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
target="$(dirname $scripts_dir)/bash_tools.sh"
. $target
bash_tools add_to_bashrc ". $target"

bash_tools add_to_bashrc "set -o vi # vim mode"
bash_tools add_to_bashrc "alias nocors='google-chrome --disable-web-security --disable-gpu --user-data-dir=$HOME/chromeTemp'"

# Install z
git clone https://github.com/rupa/z/ ~/tmp/z
chmod +x ~/tmp/z/z.sh
sudo mv ~/tmp/z/z.sh /usr/local/bin/
sudo mv ~/tmp/z/z.1 /usr/local/share/man/man1
rm -rf ~/tmp/z
bash_tools add_to_bashrc ". /usr/local/bin/z.sh"
. /usr/local/bin/z.sh # start z
