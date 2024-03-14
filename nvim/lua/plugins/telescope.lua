--[[
This is a searching extension, it requires ripgrep to be installed on the system
]]

local config = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  telescope.load_extension('fzf')

  telescope.setup({
    defaults = {
      mappings = { -- :h telescope.actions
        i = {
          ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist, -- must be out of insert mode or use `tab` to select
          ['<C-t>'] = actions.select_tab, -- open in new tab
          ['<C-v>'] = actions.file_vsplit -- open in vsplit
        }
      }
    }
  })

  local keymap = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }
  
  opts.desc = 'Search project for file'
  keymap('n', '<leader>f', '<cmd>Telescope find_files<cr>', opts)

  opts.desc = 'Search project for pattern'
  keymap('n', '<leader>F', '<cmd>Telescope live_grep<cr>', opts)

  opts.desc = 'Get currently open buffers'
  keymap('n', '<leader>r', '<cmd>Telescope buffers<cr>', opts)
end

local dependencies = {
  'nvim-lua/plenary.nvim',
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'nvim-tree/nvim-web-devicons',
  'nvim-lua/plenary.nvim'
}

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = dependencies,
  config = config,
  -- keys = { '<leader>f', '<leader>F', '<leader>r' },
  event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
}
