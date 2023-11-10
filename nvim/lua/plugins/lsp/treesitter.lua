--[[
This isn't exactly an LSP extension, but I have it working with the LSP
Tree Sitter takes in a language and some source code and can parse out the meaning of the queries
It's most famous use case is highlighting and text colors
]]

local config = function()
  local ts = require('nvim-treesitter.configs')

  -- :TSenable highlight sometimes I run this manually?
  ts.setup({
    highlight = { enabled = true },
    indent = { enabled = true }, -- Make smarter indentations using parser
    auto_install = true, -- install parsers when file is opened
    additional_vim_regex_highlighting = false, -- I've had issues with the default highlighting
  })
end

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' }, -- configured in it's own file
  config = config,
  event = { 'BufReadPre', 'BufNewfile' }
}
