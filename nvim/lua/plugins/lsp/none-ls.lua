-- A list of builtins here: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
-- Install through :Mason and then enable in sources

local config = function()
  local null_ls = require('null-ls')

  local formatters = null_ls.builtins.formatting
  --local diagnostics = null_ls.builtins.diagnostics
  --local completions = null_ls.builtins.completion
  --local actions = null_ls.builtins.code_actions
  --local hover = null_ls.builtins.hover

  local sources = {
    -- js
    formatters.prettierd,

    -- python
    formatters.black,
  }

  null_ls.setup({ sources=sources })
end

return {
  enabled = true,
  'nvimtools/none-ls.nvim',
  lazy = true, -- don't load until lsp asks for it
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = config
}
