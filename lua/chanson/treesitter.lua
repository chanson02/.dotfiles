local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  print "Failed to load Tree Sitter"
  return
end

configs.setup {
  highlight = { enable = true },
  auto_install = true, -- Automatically install parsers for files I use

  -- p00f/nvim-ts-rainbow -- color code brackets
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 500,
  }
}

--vim.opt.foldmethod = 'expr' --fold functions
--vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
