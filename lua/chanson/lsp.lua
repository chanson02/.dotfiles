local mason_ok, mason = pcall(require, 'mason')
local mlsp_ok, mlsp = pcall(require, 'mason-lspconfig')
local lsp_ok, lsp = pcall(require, 'lspconfig')
if not mason_ok then
  print('Failed to load mason for LSP')
  return
elseif not mlsp_ok then
  print('Failed to load mason LSP config')
  return
elseif not lsp_ok then
  print('Failed to laod LSP')
  return
end

-- Default config for each LSP server
local lsp_defaults = {
  autostart = true,
  flags = { debounce_text_changes = 100 },

  -- Function ran when server connects
  on_attach = function(_, _)
    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})

    -- Keymaps only used when LSP attached
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0}) -- Map K to hover documentation for current buffer
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0}) -- Jump to definition, CTRL + o to go back
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, {buffer=0}) -- Jump to reference
    -- Not sure what an implementation is -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {buffer=0}) -- Jump to implementation
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {buffer=0}) -- Refactor symbol
  end
}



mason.setup()
mlsp.setup({ automatic_installation = true })
lsp.util.default_config = vim.tbl_deep_extend(
  'force',
  lsp.util.default_config,
  lsp_defaults
)

lsp.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

lsp.tsserver.setup({})
lsp.cssls.setup({})
lsp.html.setup({})
lsp.jsonls.setup({})
lsp.svelte.setup({})

lsp.solargraph.setup({})
lsp.jdtls.setup({}) -- Java
lsp.pyright.setup({})
lsp.clangd.setup({})
lsp.bashls.setup({})
