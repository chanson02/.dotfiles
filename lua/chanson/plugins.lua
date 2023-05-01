local fn = vim.fn

-- Install Packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen neovim"
  vim.cmd [[packadd packer.nvim]]
end

-- Reload when new plugin added
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Safe load Packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print "Failed to load Packer"
  return
end

-- Open packer in popup
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Plugins
return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'arzg/vim-colors-xcode' -- XCode


  use 'nvim-lua/popup.nvim' -- Popup windows
  use 'nvim-lua/plenary.nvim' -- used by many plugins -- Call back for loading other plugins safely

  use 'christoomey/vim-tmux-navigator'

  use {
    'nvim-treesitter/nvim-treesitter',
    'p00f/nvim-ts-rainbow',
    run = ':TSUpdate',
  }
  use 'windwp/nvim-autopairs'

  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    tag = 'nightly'
  }

  use 'unblevable/quick-scope'
  use {
    -- sudo apt install ripgrep fd-find
    'nvim-telescope/telescope-media-files.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make', -- I had to run this manually cd /home/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim && make
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim'
  } --git integration

  --[[
  My old LSP
  use {
    --'williamboman/nvim-lsp-installer',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig'
  }
  --]]
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
