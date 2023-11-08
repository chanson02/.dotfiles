#!/bin/bash

scripts_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Install fonts
"$scripts_dir/install_fonts.sh"
