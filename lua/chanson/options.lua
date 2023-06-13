--vim.opt.guifont = "monospace:h17"
--vim.opt.clipboard = "unnamedplus"
--
vim.opt.termguicolors = true
vim.opt.mouse = "a"
-- vim.cmd "set clipboard+=unnamedplus" -- always use system clipboard? -- changed in keymaps to use leader
vim.opt.fileencoding = "utf-8"
vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.showtabline = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.signcolumn = 'yes'
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.formatoptions:remove('c') -- don't auto insert comment on new line
