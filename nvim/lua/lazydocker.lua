vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*lazydocker*',
  callback = function()
    vim.cmd('tabclose')
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*lazydocker*',
  callback = function()
    print('Side scroll set to 0')
    vim.opt_local.scrolloff = 0
    vim.opt_local.sidescrolloff = 0
  end,
})
