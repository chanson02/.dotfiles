local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  print "Failed to load Tree Sitter"
  return
end

configs.setup {
  highlight = { enable = true },
  auto_install = true, -- Automatically install parsers for files I use
  additional_vim_regex_highlighting = false,

  -- p00f/nvim-ts-rainbow -- color code brackets
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 500,
  }
}

--vim.opt.foldmethod = 'expr' --fold functions
--vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

local ok, context = pcall(require, 'treesitter-context')
if not ok then
  print "Failed to load TS Context"
  return
end
context.setup()
