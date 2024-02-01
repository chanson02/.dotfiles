#!/bin/bash

# Install z
git clone https://github.com/rupa/z/ ~/tmp/z
chmod +x ~/tmp/z/z.sh
sudo mv ~/tmp/z/z.sh /usr/local/bin/
sudo mv ~/tmp/z/z.1 /usr/local/share/man/man1
rm -rf ~/tmp/z
echo ". /usr/local/bin/z.sh" >> ~/.bashrc
. /usr/local/bin/z.sh # start z


scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
tools="$(dirname $scripts_dir)/bash_tools/init.sh"
grep -qxF "source $tools" ~/.bashrc || echo "source $tools" >> ~/.bashrc
