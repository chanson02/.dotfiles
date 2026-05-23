vim.pack.add({ 'https://www.github.com/ibhagwan/fzf-lua' })

local keymap = vim.keymap.set
local f = require('fzf-lua')

keymap('n', '<leader>F', f.builtin, { desc = 'Find anything' })
keymap('n', '<leader>ff', f.files, { desc = 'Find files' })
keymap('n', '<leader>fF', f.live_grep, { desc = 'Find regex' })
keymap('n', '<leader>fr', f.buffers, { desc = 'Find recent files' })
keymap('n', '<leader>fx', f.diagnostics_document, { desc = 'File diagnostics' })
keymap('n', '<leader>fX', f.diagnostics_workspace, { desc = 'Workspace diagnostics' })
