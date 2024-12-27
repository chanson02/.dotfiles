local config = function()
  require('mini.files').setup({
    windows = { preview = true }
  })
end

local keymaps = {
  { '<leader>e', function() MiniFiles.open() end, desc = 'Open Filetree' },
}

return {
  'echasnovski/mini.files',
  config = config,
  dependencies = { 'echasnovski/mini.icons' },
  keys = keymaps,
  lazy = false
}
