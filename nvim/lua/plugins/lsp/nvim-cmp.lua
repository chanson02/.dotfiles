local deps = {
  'hrsh7th/cmp-buffer', -- completion on buffer
  'hrsh7th/cmp-path', -- completion using system path
  'L3MON4D3/LuaSnip', -- snippet engine to autocomplete
  'saadparwaiz1/cmp_luasnip', -- integrate luasnip into nvim-cmp
  'rafamadriz/friendly-snippets', -- adds a bunch of snippets that cmp can grab from
}

local config = function()
  local cmp = require('cmp')
  -- local luasnip = require('luasnip')
  require('luasnip.loaders.from_vscode').lazy_load() -- load vs-code snippets from friendly-snips

  cmp.setup({
    completion = {
      autocomplete = false, -- do not autocomplete automatically
      completeopt = 'menu,preview' -- :h completeopt
    },
    mapping = {
      ['<C-Space>'] = cmp.mapping.complete(), -- manually ask for an autocomplete
      ['<CR>'] = cmp.mapping.confirm({select = false}), -- select this completion
      ['<Esc>'] = cmp.mapping.abort(), -- do not select a completion
      ['<Tab>'] = cmp.mapping.select_next_item(), -- go to the next completion
      ['<S-Tab>'] = cmp.mapping.select_prev_item(), -- go to the previous completion
      ['<Up>'] = cmp.mapping.scroll_docs(4), -- scroll up the docs
      ['<Down>'] = cmp.mapping.scroll_docs(-4), -- scroll down the docs
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'luasnip' },
      { name = 'path' },
    })
  })
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = deps,
  config = config
}
