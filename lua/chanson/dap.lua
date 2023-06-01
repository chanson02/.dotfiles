local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap


local ok, dap = pcall(require, 'dap')
if not ok then
  print("Failed to load DAP")
  return
end
require('mason-nvim-dap').setup()
require('nvim-dap-virtual-text').setup()
vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

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

--local widgets = require('dap.ui.widgets')
--local sidebar = widgets.sidebar(widgets.scopes)


dap.listeners.after.event_initialized['binds'] = function()
  --sidebar.open()
  --dap.repl.open()
end
dap.listeners.before.event_terminated['binds'] = function()
  --sidebar.close()
  dap.repl.close()
end
dap.listeners.before.event_exited['binds'] = function()
  --sidebar.close()
  dap.repl.close()
end

keymap('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
keymap('n', '<leader>dB', '<cmd>lua require("dap").set_breakpoint(vim.fn.input("DP Condition: )<CR>', opts)
keymap('n', '<leader>dc', '<cmd>lua require("dap").continue()<CR>', opts)
keymap('n', '<leader>dr', '<cmd>lua require("dap").repl.toggle()<CR>', opts)

keymap('n', '<F1>', '<cmd>lua require("dap").step_into()<CR>', opts)
keymap('n', '<F2>', '<cmd>lua require("dap").step_over()<CR>', opts)
keymap('n', '<F3>', '<cmd>lua require("dap").step_out()<CR>', opts)
keymap('n', '<F4>', '<cmd>lua require("dap").up()<CR>', opts)
keymap('n', '<F5>', '<cmd>lua require("dap").down()<CR>', opts)

keymap('n', '<leader>dh', '<cmd>lua require("dap.ui.widgets").hover()<CR>', opts)

--[[
-- these don't work?
vim.keymap.set('n', '<Leader>df', function()
  local w = require('dap.ui.widgets')
  w.sidebar(w.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  widgets.sidebar(widgets.scopes)
end)
]]
