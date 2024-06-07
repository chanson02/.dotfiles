#!/bin/bash

add_to_bashrc() {
  local line="$1"
  if ! grep -Fxq "$line" ~/.bashrc; then
    echo "$line" >> ~/.bashrc
  fi
}
add_to_bashrc "set -o vi # vim mode"
add_to_bashrc "alias nocors='google-chrome --disable-web-security --disable-gpu --user-data-dir=$HOME/chromeTemp'"

# Install z
git clone https://github.com/rupa/z/ ~/tmp/z
chmod +x ~/tmp/z/z.sh
sudo mv ~/tmp/z/z.sh /usr/local/bin/
sudo mv ~/tmp/z/z.1 /usr/local/share/man/man1
rm -rf ~/tmp/z
add_to_bashrc ". /usr/local/bin/z.sh"
. /usr/local/bin/z.sh # start z

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
target="$(dirname $scripts_dir)/bash_tools.sh"
add_to_bashrc ". $target"
