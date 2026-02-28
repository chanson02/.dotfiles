-- :Mason install codelldb (debugger) and rust_analyzer for this to work

vim.g.rustaceanvim = {
  server = { on_attach = lsp_on_attach } -- this function is set in lspconfig.lua
}
return {
  'mrcjkb/rustaceanvim',
  version = '^4',
  lazy = true,
  ft = 'rust',
  dependencies = { 'mfussenegger/nvim-dap', 'neovim/nvim-lspconfig' }
}
