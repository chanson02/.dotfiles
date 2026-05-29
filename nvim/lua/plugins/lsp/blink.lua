vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
})

local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup({
  completion = {
    menu = { auto_show = false },
    documentation = { auto_show = true },
  },

  keymap = {
    preset = 'enter',
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },

  cmdline = { keymap = { preset = 'inherit' }, completion = { menu = { auto_show = false } }, },
  term = { enabled = true },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    per_filetype = {
      sql = { 'dadbod', 'snippets', 'buffer' },
    },
    providers = {
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
    },
  },
})

vim.lsp.config["*"] = { capabilities = require('blink.cmp').get_lsp_capabilities() }
