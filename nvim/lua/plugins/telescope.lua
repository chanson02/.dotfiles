--[[
This is a searching extension, it requires ripgrep to be installed on the system
]]

local config = function()
  local telescope = require('telescope')
  local funcs = require('telescope.builtin')
  -- these builtin functions could be fun...
  -- marks, quickfix, loclist, jumplist, registers, resume, lsp_references, lsp_diagnostics
  telescope.load_extension('fzf')

  telescope.setup({
    pickers = {
      find_files = { theme = 'ivy' },
      live_grep = { theme = 'ivy' },
      buffers = { theme = 'ivy' },
    },
  })

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  opts.desc = 'Search project for file'
  keymap('n', '<leader>ff', funcs.find_files, opts)

  opts.desc = 'Search project for pattern'
  keymap('n', '<leader>fF', funcs.live_grep, opts)

  opts.desc = 'Get currently open buffers'
  keymap('n', '<leader>fr', funcs.buffers, opts)

  opts.desc = 'Search neovim dotfiles'
  keymap('n', '<leader>fnf', function() funcs.find_files({ cwd = vim.fn.stdpath('config') }) end, opts)

  opts.desc = 'Search Neovim help'
  keymap('n', '<leader>fnh', funcs.help_tags, opts)

  opts.desc = 'Search neovim plugins'
  keymap('n', '<leader>fnp', function() funcs.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')}) end, opts)
end

local dependencies = {
  'nvim-lua/plenary.nvim',
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'nvim-tree/nvim-web-devicons',
}

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = dependencies,
  config = config,
  event = { 'VeryLazy' },
}
