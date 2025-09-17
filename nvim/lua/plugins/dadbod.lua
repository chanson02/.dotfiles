local dependencies = {
  { 'tpope/vim-dadbod', lazy = true },
  { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'psql' }, lazy = true },
  { 'tpope/vim-dotenv' }
}

return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = dependencies,
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
