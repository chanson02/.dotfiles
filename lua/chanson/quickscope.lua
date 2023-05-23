-- Requires unblevable/quick-scope

vim.cmd('highlight QuickScopePrimary ctermfg=yellow guifg=yellow')
vim.cmd('highlight QuickScopeSecondary ctermfg=cyan guifg=cyan')
vim.cmd [[
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] " Only highlight when in search mode
]]
