vim.g.qs_max_chars = 150
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
vim.cmd([[ highlight QuickScopePrimary guifg=yellow ctermfg=yellow gui=underline cterm=underline ]])
vim.cmd([[ highlight QuickScopeSecondary guifg=yellow ctermfg=yellow ]])
vim.pack.add({ 'https://github.com/unblevable/quick-scope' })
