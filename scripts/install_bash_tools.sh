#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
tools="$(dirname $scripts_dir)/bash_tools/init.sh"
grep -qxF "source $tools" ~/.bashrc || echo "source $tools" >> ~/.bashrc
