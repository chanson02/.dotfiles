--[[
LSP Configuration:
lspconfig is used to register individual servers to neovim
mason is used to download servers
mason-lspconfig automatically sets up the configuration for a server once it's been downloaded


:h lsp-defaults
--]]
local deps = {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', config = true }
  }
}

local diag_disable = { virtual_text = false, underline = false }
local diag_enable  = { virtual_text = { source = true },  underline = true, sign = true }
vim.diagnostic.config(diag_disable) -- default on startup
vim.g.diagnostics_active = false
-- Toggle vims diagnostics module. Useful for keeping a clean screen
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active
    then vim.diagnostic.config(diag_disable)
    else vim.diagnostic.config(diag_enable)
  end
  vim.g.diagnostics_active = not vim.g.diagnostics_active
end

local function set_lsp_keymaps(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then return end

  local keymap = vim.keymap.set
  local opts = { buffer = args.buf, noremap = true, silent = true, desc = "" }

  keymap('n', '<leader>td', toggle_diagnostics, opts)
  keymap('n', 'gl', vim.diagnostic.open_float, opts)

  if client.supports_method('textDocument/completion') then
    keymap('i', '<C-Space>', function() vim.lsp.omnifunc(1, '') end, opts)
  end
end

local function default_handler(server_name)
  require('lspconfig')[server_name].setup({})
end

local function lua_handler()
  local lspconfig = require('lspconfig')
  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        }
      }
    }
  })
end

local lsp_handlers = {
   default_handler,
   ["lua_ls"] = lua_handler,
   ['rust_analyzer'] = function() end, -- setup in rustaceanvim.lua
}

return {
  "neovim/nvim-lspconfig",
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = deps,
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({ handlers = lsp_handlers })
    -- require("lspconfig").lua_ls.setup {}
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        set_lsp_keymaps(args)
      end
    })
  end,
}
