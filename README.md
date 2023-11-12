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
- You can disable any plugins by going into their `.lua` file and returning {} early

`install_nvim_lite.sh` will install a barebones version consisting of mostly remaps. This can be useful for getting a server setup quick

#### Verify Installation
Launch vim and run :checkhealth to make sure everything is A-ok
    - For some reason the xcodecolor scheme errors on the first boot, but second time it should be fine.

#### Colorscheme
You can set a colorscheme by going to `nvim/lua/plugins/colorschemes.lua`

#### Language Servers
Once in a nvim buffer, use `:Mason` to install any language servers you want
  - If you need to edit the configuration for a language server, check `nvim/lua/plugins/lsp/lspconfig.lua`

#### Learning the Keymaps
There is no easy way to learn all the keymaps in this configuration.
The best way is to go through each of the `.lua` files (starting with `keymaps.lua`) and memorize chunks of keymaps at a time

### Zellij

`install_zellij.sh`
- I unbound the `move` mode so you need to switch with `alt` + arrow keys
- Also there is a layout for my rails apps
