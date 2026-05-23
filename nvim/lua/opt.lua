vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- tabs
vim.opt.tabstop = 2         -- display \t as 2 spaces
vim.opt.shiftwidth = 2      -- auto indent level
vim.opt.softtabstop = 2     -- Tab&BackSpace jump 2 spaces at a time
vim.opt.expandtab = true    -- Tab key inserts 2 spaces
vim.opt.smartindent = true  -- (un)indent after } {
vim.opt.autoindent = true   -- keep current indent level on newline

-- search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- decor
vim.opt.signcolumn = "yes"
vim.opt.winblend = 0    -- transparency of floating windows
vim.opt.winborder = "rounded"
vim.opt.conceallevel = 0
vim.opt.concealcursor = "n"   -- conceal only in normal mode
vim.opt.synmaxcol = 300

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.autowrite = false

vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**") -- include subdirs in search
vim.opt.mouse = "a"

-- these were moved to treesitter.lua
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldlevel = 99

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmode = "longest:full,full"
vim.opt.diffopt:append("linematch:60")

vim.opt.exrc = true
vim.opt.secure = true

require("vim._core.ui2").enable({})
