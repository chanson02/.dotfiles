-- Setting lazy to false will automatically load the color scheme
-- lazy = true will only load the colorscheme if you manually request it

local xcode = {
  'arzg/vim-colors-xcode',
  lazy = true,
  config = function()
    vim.cmd 'colorscheme xcodedark'
  end
}

local nightfly = {
  'bluz71/vim-nightfly-guicolors',
  lazy = true,
  config = function()
    vim.cmd 'colorscheme nightfly'
  end
}

local cyberdream = {
  'scottmckendry/cyberdream.nvim',
  lazy = false,
  config = function()
    require("cyberdream").setup({
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
    })
    vim.cmd 'colorscheme cyberdream'
  end
}

-- Lazy will load theme schemes
local schemes = {
  xcode,
  nightfly,
  cyberdream
}

return schemes
