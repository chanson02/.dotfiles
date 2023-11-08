# Dotfiles
Hi Cooper, these are your personal dotfiles, along with some installation scripts to get you up and running on a new computer!
This repository makes symbolic links, so you can update all your application configurations from this spot!

## License
Give this to as many friends as you can so that they can use, modify, and redistribute however they like.

## Installation
1. Clone this repository to your local machine
2. cd into `scripts` and run whichever onces you want!
  - Before running a script you may need to give it permission with `chmod +x`

## Usage

### Vim

`install_nvim.sh` will install my full blown NeoVim environment, including a NerdFont, plugins, and theme

`install_nvim_lite.sh` will install a barebones version consisting of mostly remaps. This can be useful for getting a server setup quick

#### Colorscheme
You can set a colorscheme by going to `nvim/lua/colorschemes.lua`
