vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Wrapped text movement
keymap("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })
keymap("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

-- Split Navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize splits
keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize -2<CR>', opts)

-- Yank into system clipboard
keymap({'n', 'x'}, '<leader>y', '"+y', opts)
keymap({'n', 'x'}, '<leader>Y', '"+Y', opts)

-- Indent / de-indent visual block
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move selected lines
keymap('v', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('v', 'K', ":move '>-2<CR>gv-gv", opts)
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)

-- Jump half page and center
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Keep search results centered
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

-- Paste without overwriting register
keymap('x', '<leader>p', '"_dP', opts)

-- Terminal mode
-- OSC133 [[ ]]
keymap('t', '<Esc>', '<C-\\><C-n>', opts)
keymap('t', '<C-Esc>', '<Esc>', opts)

-- Tabs
keymap('n', 'H', ':tabprevious<CR>', opts)
keymap('n', 'L', ':tabnext<CR>', opts)

-- Toggle diagnostics
local function toggle_diagnostics()
  local diag_disable = { virtual_text = false, underline = false, signs = true }
  local diag_enable = { virtual_text = { source = true }, underline = true, signs = true }
  if vim.g.diag_decos then
    vim.diagnostic.config(diag_disable)
    vim.g.diag_decos = false
  else
    vim.diagnostic.config(diag_enable)
    vim.g.diag_decos = true
  end
end
keymap('n', '<leader>td', toggle_diagnostics, { desc = 'Toggle diagnostics' })

-- Show diagnostics for line
keymap('n', 'gl', vim.diagnostic.open_float, opts)

keymap("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy file path" })

keymap('n', '<Esc>', ':nohlsearch<CR><Esc>', opts) -- clear searches on escape
