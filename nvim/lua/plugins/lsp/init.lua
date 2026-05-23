vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',

  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
})

local function set_lsp_keymaps(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then return end

  local bufnr = args.buf
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }

  map('n', 'gl', vim.diagnostic.open_float, opts)
  map('n', 'gd', function()
    require('fzf-lua').lsp_definitions({ jump1 = true })
  end, opts)
  map('n', 'gD', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
  end, opts)
end
vim.api.nvim_create_autocmd("LspAttach", { callback = set_lsp_keymaps })

require('mason').setup()
require('mason-lspconfig').setup({ automatic_installation = true })
require('plugins.lsp.blink')
