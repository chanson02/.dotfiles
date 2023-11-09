local deps = {
  'hrsh7th/cmp-nvim-lsp',
  { 'antosha417/nvim-lsp-file-operations', config = true },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', config = true }
  }
}

-- function runs when LSP client attaches to buffer
local on_attach = function(_, bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true, desc = "" }

  opts.desc = 'Search LSP references'
  keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts) -- references are where class methods are used

  opts.desc = 'Search LSP implementations'
  keymap(bufnr, 'n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- implementations are where classes are used

  opts.desc = 'Go to definition'
  keymap(bufnr, 'n', 'gd', vim.lsp.buf.definition.opts)

  opts.desc = 'Go to type definition'
  keymap(bufnr, 'n', 'gt', vim.lsp.buf.type_definition, opts)

  opts.desc = 'See code actions'
  keymap(bufnr, {'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)

  opts.desc = 'Smart rename'
  keymap(bufnr, 'n', '<leader>rn', vim.lsp.buf.rename, opts)

  opts.desc = 'Documentation'
  keymap(bufnr, 'n', 'K', vim.lsp.buf.hover, opts)
end


local config = function()
  local lsp = require('lspconfig')
  local cmp_lsp = require('cmp_nvim_lsp')
  local mason = require('mason-lspconfig')
  local caps = cmp_lsp.default_capabilities()

  mason.setup({ automatic_installation = true })

  local default_handler = function(server)
    lsp[server].setup({
      capabilities = caps,
      on_attach = on_attach,
    })
  end

  local handlers = {
    default_handler,
    ['lua_ls'] = function()
      lsp.lua_ls.setup {
        capabilities = caps,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      }
    end
  }

  -- :h mason-lspconfig-dynamic-server-setup
  mason.setup_handlers(handlers)
end



return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = deps,
  config = config
}
