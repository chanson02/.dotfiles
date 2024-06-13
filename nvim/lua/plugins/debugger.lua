--[[
:h dap-adapter
:h dap-configuration
:h dap-mapping
:h dap-api
]]
local function keymap(mode, lhs, rhs, desc)
  local opts = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Return a list of commands available by DAP
local function dap_commands()
  local dap = require('dap')
  local cmds = {}
  for k, v in pairs(dap) do
    if type(v) == "function" then
      table.insert(cmds, k)
    end
  end
  return cmds
end

-- key: function name, value: documentation
local function read_documentation()
  local path = vim.fn.expand('~/.local/share/nvim/lazy/nvim-dap/doc/dap.txt')
  local file = io.open(path, 'r')
  if not file then
    print('Could not open' .. path)
    return
  end

  local documentation = {}
  local current_func = nil

  for line in file:lines() do
    local func = line:match("%*dap.([a-zA-Z_.]+)%(")
    if func then
      current_func = func
      documentation[current_func] = { line }
    elseif current_func then
      if line:match("^=+$") then
        current_func = nil
      else
        table.insert(documentation[current_func], line)
      end
    end
  end

  file:close()
  return documentation
end

-- telescope previewer
local function doc_previewer()
  local previewers = require('telescope.previewers')
  local docs = read_documentation()

  return previewers.new_buffer_previewer {
    title = "DAP Command Documentation",
    define_preview = function(self, entry, status)
      local doc = docs[entry.value]
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, doc or { "No documentation found for " .. entry.value })
    end
  }
end

local function picker_mapping(prompt_bufnr, map)
  local actions = require 'telescope.actions'
  local state = require 'telescope.actions.state'
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = state.get_selected_entry().value
    local call = "lua require('dap')." .. selection .. '()'
    vim.cmd(vim.fn.input('', call))
  end)
  return true
end

local function dap_picker()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values

  local opts = {
    finder = finders.new_table(dap_commands()),
    sorter = conf.generic_sorter({}),
    previewer = doc_previewer(),
    attach_mappings = picker_mapping
  }

  local picker = pickers.new(opts)
  picker:find()
end

local config = function()
  local dap = require('dap')
  local repl = require('dap.repl')
  local widgets = require('dap.ui.widgets')

  keymap('n', '<leader>dbb', dap.toggle_breakpoint, 'Toggle breakpoint')
  keymap('n', '<leader>dbc', dap.continue, 'Continue Debugging')
  keymap('n', '<leader>dbg', dap_picker, 'Search DAP functions')
  keymap('n', '<leader>dbr', repl.toggle, 'Toggle the DAP repl')
  keymap('n', '<leader>dbk', widgets.hover, 'Evaluate variable')
  keymap('n', '<leader>dbf', function() widgets.centered_float(widgets.frames) end, 'Show stack frames')
  keymap('n', '<leader>dbs', function() widgets.centered_float(widgets.scopes) end, 'Show variable scopes')
  -- step_over
  -- step_into
  -- step_out
  -- step_back

  dap.defaults.fallback.terminal_win_cmd = '20vsplit new' -- don't make the terminal so big
end

return {
  'mfussenegger/nvim-dap',
  config = config,
  lazy = true,
  -- cmd = 'Dap',
  dependencies = { 'nvim-telescope/telescope.nvim' }
}
