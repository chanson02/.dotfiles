local function open()
  for _, tabnr in ipairs(vim.api.nvim_list_tabpages()) do
    for _, winnr in ipairs(vim.api.nvim_tabpage_list_wins(tabnr)) do
      local buf = vim.api.nvim_win_get_buf(winnr)
      local name = vim.api.nvim_buf_get_name(buf)
      if name:find('lazydocker') then
        vim.api.nvim_set_current_tabpage(tabnr)
        vim.cmd('startinsert')
        return
      end
    end
  end

  vim.cmd('tabnew')
  vim.cmd('terminal lazydocker')
  vim.cmd('startinsert')
end

vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*lazydocker*',
  callback = function() vim.cmd('tabclose') end,
})

vim.keymap.set('n', '<leader>ld', open, { desc = "Lazydocker" })
