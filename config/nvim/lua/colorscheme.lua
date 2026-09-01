vim.pack.add({ 'https://github.com/scottmckendry/cyberdream.nvim' })

require('cyberdream').setup({
  transparent = true,
  variant = 'dark',
  italic_comments = true,
  hide_fillchars = true,
  borderless_pickers = true,
})

vim.cmd('colorscheme cyberdream')
