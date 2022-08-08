

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  print("Failed to load Nvim Tree")
  return
end

nvim_tree.setup({
  disable_netrw = true,
  auto_reload_on_write = true,
  git = { ignore = false }, --show git ignored files
  view = { number = true },
  renderer = { group_empty = true }, -- Folders with only one item: show item instead of folder
  actions = { open_file = { quit_on_open = true, } } -- close explorer on file open
})
