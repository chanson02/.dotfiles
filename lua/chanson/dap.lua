local function set_debug_binds()
  local opts = {
    mode = 'n',
    buffer = 0,
    nowait = true,
    script = true
  }

  vim.api.nvim_buf_set_keymap(0, 'n', 'c', '<cmd>lua print("DEBUG MODE")<CR>', opts)
end

vim.cmd[[
augroup DebugModeKeymaps
  autocmd!
  autocmd User DAPEntering * lua set_debug_binds()
augroup END
]]

local ok, dap = pcall(require, 'dap')
if not ok then
  print("Failed to load DAP")
  return
end
require('mason-nvim-dap').setup()

dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' }
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      return 'python'
    end,
  }
}
