function keymap(mode, lhs, rhs, desc)
  local opts = { noremap = true, silent = true, desc = desc }
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

keymap('', '<Space>', '<Nop>', 'Set the leader key')

-- Split Navigation
keymap('n', '<C-h>', '<C-w>h', 'Navigate to left split')
keymap('n', '<C-j>', '<C-w>j', 'Navigate to downward split')
keymap('n', '<C-k>', '<C-w>k', 'Navigate to upward split')
keymap('n', '<C-l>', '<C-w>l', 'Navigate to right split')

-- Resize splits
keymap('n', '<C-Up>', ':resize +2<CR>', 'Increase split horizontal size')
keymap('n', '<C-Down>', ':resize -2<CR>', 'Decrease split horizontal size')
keymap('n', '<C-Left>', ':vertical resize +2<CR>', 'Increase split vertical size')
keymap('n', '<C-Right>', ':vertical resize -2<CR>', 'Decrease split vertical size')

-- Register maps
keymap('x', '<leader>p', '"_dP', 'Paste without overwriting register')
keymap('n', '<leader>y', '"+y', 'Yank into system clipboard')
keymap('v', '<leader>y', '"+y', 'Yank into system clipboard')
keymap('n', '<leader>Y', '"+Y', 'yank into system clipboard')
keymap('v', '<leader>Y', '"+Y', 'yank into system clipboard')

-- Indent
keymap('v', '<', '<gv', 'De-indent a visual block') -- the purpose of this is so that it reselects the text after moving
keymap('v', '>', '>gv', 'Indent a visual block')

-- Move selected text around
keymap('x', 'J', ":move '>+1<CR>gv-gv", 'Move selection down')
keymap('x', 'K', ":move '>-2<CR>gv-gv", 'Move selection up')

-- Stay in the middle of the screen while jumping around
keymap('n', '<C-d>', '<C-d>zz', 'Jump down half a page')
keymap('n', '<C-u>', '<C-u>zz', 'Jump up half a page')
keymap('n', 'n', 'nzzzv', 'Next search result') -- The purpose of this is to keep the search in the center of the screen
keymap('n', 'N', 'Nzzzv', 'Previous search result')

keymap('t', '<Esc>', '<C-\\><C-n>', 'Enter normal mode')
