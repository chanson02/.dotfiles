local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- go definition
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) -- go reference
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts) -- go type
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- rename
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) --code action
  -- vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
  -- vim.keymap.set('n', '<leader>tc', ':call v:lua.toggle_completion()<CR>', opts)
end)

lsp.setup()
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
  completion = { autocomplete = false },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(), -- manual suggestions
--    ['<Tab>'] = cmp_action.tab_complete(),
--    ['<S-Tab>'] = cmp_action.select_prev_or_fallback()
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab'] = cmp_action.luasnip_shift_supertab(),
    ['<CR>'] = cmp.mapping.confirm({select = false})
  }
})
