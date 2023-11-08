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

local plugins = {
}

-- Add the color schemes
for _, v in ipairs(require('colorschemes')) do
  table.insert(plugins, v)
end
require('lazy').setup(plugins)
