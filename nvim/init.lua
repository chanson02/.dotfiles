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

vim.opt.rtp:prepend(lazypath)


require('lazy').setup({
  { import = 'plugins' },
  { import = 'plugins.lsp' },
  checker = { enabled = true, notify = false },
  change_detection = { notify = false } -- do not notify me when dotfiles change
})
