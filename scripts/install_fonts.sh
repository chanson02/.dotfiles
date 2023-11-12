#!/bin/bash

nf_base="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/"
declare -a fonts=(
  "FiraCode.zip"
  "Meslo.zip"
  "JetBrainsMono.zip"
)

install_fonts() {
  for font in "${fonts[@]}"; do
    url="$nf_base$font"
    curl -LO "$url"
    unzip -o "$font" -d $HOME/.fonts
    rm "$font"
    echo "$font Installed"
  done
}

mkdir -p "$HOME/.fonts"

install_fonts
fc-cache -fv
