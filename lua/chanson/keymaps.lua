local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Set leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Hold paste register
keymap("v", "p", '"_dP', opts)

-- Open Inventory
keymap("n", "<leader>ee", ":NvimTreeToggle<cr>", opts)
--keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize splits
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Indent
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move characters
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Get out of terminal
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

-- Telescope Finder
keymap('n', '<leader>f', '<cmd>Telescope find_files<cr>', opts)
keymap('n', '<leader>F', '<cmd>Telescope live_grep<cr>', opts)

-- Diagnostics
vim.keymap.set('n', '<leader>td', ':call v:lua.toggle_diagnostics()<CR>', {noremap=true, silent=true})
--vim.keymap.set('n', '<leader>d', vim.diagnostic.goto_next, {buffer=0}) -- Jump to error
vim.keymap.set('n', '<leader>er', '<cmd>Telescope diagnostics<cr>', {buffer=0}) -- Show errors
