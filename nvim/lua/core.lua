vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.showtabline = 2 -- graphically show 2 spaces
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- number of spaces for autoindent
vim.opt.tabstop = 2 -- number of spaces for tab key pressed
vim.opt.smartindent = true -- try to know when to indent
vim.opt.autoindent = true -- automatically indent on return
vim.opt.formatoptions:remove('c') -- don't auto insert comment on return

vim.opt.termguicolors = true -- enable terminal colors
vim.opt.mouse = 'a' -- able to use mouse in all modes

vim.opt.fileencoding = 'utf-8'
vim.opt.swapfile = false
vim.opt.undofile = true -- can undo even after closing buffer

vim.opt.incsearch = true -- search as you type, otherwise you need to hit enter
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- not sure what this is but it sounds helpful

vim.opt.cursorline = true -- make the cursor a line instead of a block
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.splitright = true -- put new vsplits on the right
vim.opt.splitbelow = true -- put new hsplits on the bottom
vim.o.signcolumn = 'yes' -- display an extra column on the left of the screen
vim.opt.scrolloff = 8 -- can scroll below the page
vim.opt.sidescrolloff = 8 -- can scroll horizontally off the page
