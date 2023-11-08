local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('', '<Space>', '<Nop>', opts) -- leader

-- Register maps
keymap('x', '<leader>p', '"_dP', opts) -- Paste over selected text without changing what's in the paste register
keymap('n', '<leader>y', '"+y', opts) -- yank into the system clipboard
keymap('v', '<leader>y', '"+y', opts) -- yank line into the system clipboard
keymap('n', '<leader>Y', '"+Y', opts) -- yank into the system clipboard
keymap('v', '<leader>Y', '"+Y', opts) -- yank iine nto the system clipboard

-- Resize splits
keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize -2<CR>', opts)

-- Indent
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move selected text around
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '>-2<CR>gv-gv", opts)

-- Stay in the middle of the screen while jumping around
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

keymap('t', '<Esc>', '<C-\\><C-n>', opts) -- return to normal mode in terminal
