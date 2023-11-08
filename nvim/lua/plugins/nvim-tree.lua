--[[
  Nvim Tree is a plugin for file navigation
  hit leader e to open the nav menu
]]--

local config = function()
  local nvimtree = require('nvim-tree')
  nvimtree.setup({
    disable_netrw = true,
    auto_reload_on_write = true,
    git = { ignore = false }, --show git ignored files
    view = { number = true }, -- use line numbers to jump around
    renderer = { group_empty = true }, -- Folders with only one item: show item instead of folder
    actions = { open_file = { quit_on_open = true } } -- close explorer when file is opened
  })
end


return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = config,
  keys = { { '<leader>e', '<cmd>NvimTreeToggle<CR>' } }
}
