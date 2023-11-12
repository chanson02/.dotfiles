return {
  'https://git.sr.ht/~swaits/zellij-nav.nvim',
  lazy = true,
  keys = {
    { '<c-h>', ':ZellijNavigateLeft<CR>',  { silent = true, desc = 'Navigate to left pane'} },
    { '<c-j>', ':ZellijNavigateDown<CR>',  { silent = true, desc = 'Navigate down a pane'} },
    { '<c-k>', ':ZellijNavigateUp<CR>',    { silent = true, desc = 'Navigate up a pane'} },
    { '<c-l>', ':ZellijNavigateRight<CR>', { silent = true, desc = 'Navigate to right pane'} }
  },
  config = true
}
