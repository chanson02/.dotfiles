require "chanson.options"
require "chanson.plugins"

local ok, err = pcall(function()
  vim.cmd "colorscheme xcodedark"
end)
if not ok then
  print('Error loading colorscheme:', err)
end

require 'chanson.diagnostic'
require "chanson.keymaps"
require "chanson.treesitter"
require "chanson.autopairs"
require "chanson.nvim-tree"
require 'chanson.quickscope'
require 'chanson.telescope'
require 'chanson.lsp'
require 'chanson.lualine'
