-- Setting lazy to false will automatically load the color scheme
-- lazy = true will only load the colorscheme if you manually request it

local xcode = {
  'arzg/vim-colors-xcode',
  lazy = false,
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

-- Lazy will load theme schemes
local schemes = {
  xcode,
  nightfly
}

return schemes
