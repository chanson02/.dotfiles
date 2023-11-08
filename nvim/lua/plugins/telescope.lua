--[[
This is a searching extension, it requires ripgrep to be installed on the system
]]

local config = function()
  local telescope = require('telescope')
  local actions = require('telescope')

  telescope.load_extension('fzf')

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ['<C-q>'] = actions.send_selected_to_qflist
        }
      }
    }
  })

  local keymap = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }
  keymap('n', '<leader>f', '<cmd>Telescope find_files<cr>', opts) -- search project for file
  keymap('n', '<leader>F', '<cmd>Telescope live_grep<cr>', opts) -- search project for pattern
  keymap('n', '<leader>r', '<cmd>Telescope buffers<cr>', opts) -- get recent files (currently open buffers)
end

local dependencies = {
  'nvim-lua/plenary.nvim',
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'nvim-tree/nvim-web-devicons'
}

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = dependencies,
  config = config,
  keys = { '<leader>f', '<leader>F', '<leader>r' }
}
