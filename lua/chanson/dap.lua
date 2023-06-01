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
keymap('n', '<leader>dh', '<cmd>lua require("dap.ui.widgets").hover()<CR>', opts)
keymap('v', '<leader>dh', '<cmd>lua require("dap.ui.widgets").hover()<CR>', opts)
keymap('n', '<leader>df', '<cmd>lua require("dap.ui.widgets").sidebar(require("dap.ui.widgets").frames).open()<CR>', opts)
keymap('n', '<leader>ds', '<cmd>lua require("dap.ui.widgets").sidebar(require("dap.ui.widgets").scopes).open()<CR>', opts)

keymap('n', '<F1>', '<cmd>lua require("dap").step_into()<CR>', opts)
keymap('n', '<F2>', '<cmd>lua require("dap").step_over()<CR>', opts)
keymap('n', '<F3>', '<cmd>lua require("dap").step_out()<CR>', opts)
keymap('n', '<F4>', '<cmd>lua require("dap").up()<CR>', opts)
keymap('n', '<F5>', '<cmd>lua require("dap").down()<CR>', opts)



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

dap.adapters.chrome = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js'}
}
dap.configurations.javascript = {
  {
    type = 'chrome',
    request = 'launch',
    name = 'Current File',
    file = vim.fn.expand('%:p'),
    sourceMaps = true,
    protocol = 'inspector',
    webRoot = '${workspaceFolder}'
  },
  {
    type = 'chrome',
    request = 'launch',
    name = '8090',
    url = 'http://localhost:8090',
    protocol = 'inspector',
    webRoot = '${workspaceFolder}',
    sourceMaps = true
  },
  {
    type = 'chrome',
    request = 'launch',
    name = '3000',
    url = 'http://localhost:3000',
    protocol = 'inspector',
    webRoot = '${workspaceFolder}'
  },
  {
    type = 'chrome',
    request = 'launch',
    name = 'Other port',
    url = function() return 'http://localhost:' .. vim.fn.input('Port: ') end,
    protocol = 'inspector',
    webRoot = '${workspaceFolder}'
  },
}
-- google-chrome-stable --remote-debugging-port=9222
