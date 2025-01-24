--[[
LSP Configuration:
lspconfig is used to register individual servers to neovim
mason is used to download servers
mason-lspconfig automatically sets up the configuration for a server once it's been downloaded


:h lsp-defaults
--]]

-- Dependency for developing neovim
local lazydev = {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      { path = "${3rd}/lub/library", words = { "vim%.uv" } },
    },
  },
}

local deps = {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', config = true }
  },
  { 'saghen/blink.cmp' },
  lazydev
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
end

local function default_handler(server_name)
  require('lspconfig')[server_name].setup({
    capabilities = require('blink.cmp').get_lsp_capabilities()
  })
end

local function lua_handler()
  local lspconfig = require('lspconfig')
  lspconfig.lua_ls.setup({
    capabilities = require('blink.cmp').get_lsp_capabilities(),
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

-- setup separately because not supported by mason
local function setup_dart()
  local lspconfig = require('lspconfig')
  local dart_path = vim.fn.expand('$HOME/fvm/default/bin/dart')
  if not file_exists(dart_path) then return end -- only setup dart if installed

  -- use FVM version if available
  local root = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true})[1])
  local fvm_dart_path = root .. '/.fvm/flutter_sdk/bin/dart'
  if file_exists(fvm_dart_path) then dart_path = fvm_dart_path end

  lspconfig.dartls.setup({
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    cmd = { dart_path, 'language-server', '--protocol=lsp' },
    settings = {
      dart = {
        flutter = true
      }
    }
  })
end

return {
  "neovim/nvim-lspconfig",
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = deps,
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({ handlers = lsp_handlers })
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        set_lsp_keymaps(args)
      end
    })
    setup_dart()
  end,
}
