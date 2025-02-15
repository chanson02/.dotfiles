-- Setting lazy to false will automatically load the color scheme
-- lazy = true will only load the colorscheme if you manually request it


-- this is unmaintained
-- local xcode = {
--   'arzg/vim-colors-xcode',
--   lazy = true,
--   config = function()
--     vim.cmd 'colorscheme xcodedark'
--   end
-- }

local nightfly = {
  'bluz71/vim-nightfly-guicolors',
  lazy = true,
  config = function()
    vim.cmd 'colorscheme nightfly'
  end
}


-- local term_bkg = '#24243e'
local cyberdream = {
  'scottmckendry/cyberdream.nvim',
  lazy = false,
  config = function()
    require('cyberdream').setup({
      terminal_colors = true,
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      borderless_pickers = false, -- this breaks the transparentcy for some reason??
      highlights = {
        CursorLine = { bg = 'NONE' }, --term_bkg
        TabLineFill = { bg = 'NONE' },
        TabLineSel = { bg = 'NONE', bold = true }, --term_bkg
      },
    })
    vim.cmd 'colorscheme cyberdream'
  end
}

-- Lazy will load theme schemes
local schemes = {
  -- xcode,
  nightfly,
  cyberdream
}

return schemes
