local deps = {
  'hrsh7th/cmp-nvim-lsp',
  --'aznhe21/actions-preview.nvim',
  { 'antosha417/nvim-lsp-file-operations', config = true },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', config = true }
  }
}


-- A global function for disabling diagnostics
local diag_disable = { virtual_text = false, underline = false }
local diag_enable  = { virtual_text = { source = true },  underline = true, sign = true }
vim.diagnostic.config(diag_disable) -- default on startup
vim.g.diagnostics_active = false
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active
    then vim.diagnostic.config(diag_disable)
    else vim.diagnostic.config(diag_enable)
  end
  vim.g.diagnostics_active = not vim.g.diagnostics_active
end

-- function runs when LSP client attaches to buffer
local on_attach = function(_, bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true, desc = "" }

  opts.desc = 'Search LSP references'
  keymap(bufnr, 'n', 'gr', ':Telescope lsp_references<CR>', opts) -- references are where class methods are used

  opts.desc = 'Search LSP implementations'
  keymap(bufnr, 'n', 'gi', ':Telescope lsp_implementations<CR>', opts) -- implementations are where classes are used

  opts.desc = 'Go to LSP definition'
  keymap(bufnr, 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)

  -- Disabled because gt is to switch tabs
  -- opts.desc = 'Go to LSP type definition'
  -- keymap(bufnr, 'n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>', opts)

  opts.desc = 'Preview LSP function signature'
  keymap(bufnr, 'n', 'gs', ':lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  opts.desc = 'LSP Documentation'
  keymap(bufnr, 'n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)

  opts.desc = 'See LSP code actions'
  keymap(bufnr, 'n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
  --keymap(bufnr, 'n', '<leader>ca', ':lua require("actions-preview").code_actions', opts)
  keymap(bufnr, 'v', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)

  opts.desc = 'LSP Smart rename'
  keymap(bufnr, 'n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)

  --- Diagnostics
  opts.desc = 'Toggle all LSP diagnostics'
  keymap(bufnr, 'n', '<leader>td', ':call v:lua.toggle_diagnostics()<CR>', opts)

  opts.desc = 'Preview LSP diagnostics'
  keymap(bufnr, 'n', 'gl', ':lua vim.diagnostic.open_float()<CR>', opts)
  --[[
  If you'd like to see the LSP throwing errors add `float = { source = true }` to `diag_disable/enable above`
  ]]
end


-- Find the configuration options at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
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
