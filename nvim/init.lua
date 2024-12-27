require 'global'
require 'core'
require 'keymaps'

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto install lazy.nvim plugin manager
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

-- put lazy into the vim's runtime path
vim.opt.rtp:prepend(lazypath)

-- require('lazy').setup('plugins', { change_detection = { enabled = false, notify = false }})
require('lazy').setup({
  { import = 'plugins' },
  { import = 'plugins.lsp' },
  { import = 'plugins.debuggers' },
})
