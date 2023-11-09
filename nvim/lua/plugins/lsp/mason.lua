local deps = {
  { 'williamboman/mason.nvim', config = true },
  'neovim/nvim-lspconfig'
}

local config = function()
  local lspconfig = require('mason-lspconfig')
  local lsp = require('lspconfig')

  lspconfig.setup({
    automatic_installation = true
  })

  lsp.setup_handlers({
    function(server)
      lsp[server].setup({})
    end,
  })
end

return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = deps,
  config = config
}
