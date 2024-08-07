return {
  { 'stevearc/dressing.nvim', event = 'VeryLazy' }, -- UI plugin to change how neovim gathers user input

  { 'tpope/vim-fugitive', event = 'VeryLazy' }, -- Plugin to interact with git without leaving the buffer!
  -- { 'akinsho/git-conflict.nvim', event = 'VeryLazy' }, -- I really want to try this in the future

  {
    'OXY2DEV/markview.nvim',
    ft = 'markdown',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    }
  },
}
