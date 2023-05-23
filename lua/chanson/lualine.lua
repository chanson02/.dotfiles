local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  print("Failed to load lualine")
  return
end
--lualine.setup()
lualine.setup {
  options = {
    globalstatus = true
  },
  sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = { 'diff' },
    lualine_y = { 'branch' },
    lualine_z = { 'mode' }
  },
}
vim.opt.showmode = false -- only want this disabled if lualine
