#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
git="$(dirname $scripts_dir)/gitconfig"
git_home="$HOME/.gitconfig"

touch $git_home
rm $git_home # reset
ln -s $git $git_home
