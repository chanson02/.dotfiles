local deps = { 'rafamadriz/friendly-snippets' }

local keymaps = {
  preset = 'enter',
  ['<C-S-Space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },  -- only show snippets
  ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
  ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' }
}

local config_options = {
  signature = { enabled = false }, -- use ctrl s
  completion = {
    menu = { auto_show = false }, -- use ctrl space
    documentation = { auto_show = true },
  },
  keymap = keymaps,
  cmdline = { keymap = { ['<Enter>'] = { 'accept', 'fallback' } }, },
}

return {
  'saghen/blink.cmp',
  version= '*',
  dependencies = deps,
  opts = config_options,
  lazy = true
}
