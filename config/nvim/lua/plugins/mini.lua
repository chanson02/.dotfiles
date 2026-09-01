vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

local function m(module) require('mini.' .. module).setup() end

-- utils
m('icons')
m('notify')
m('files')

m('ai')
m('move')
m('surround')
m('pairs')

m('bracketed') -- [x go to previous conflict
m('splitjoin') -- gS
m('align') -- gaip

local function map(mode, lhs, rhs, desc)
  local opts = { remap = false, silent = true, desc = desc }
  vim.keymap.set(mode, lhs, rhs, opts)
end

map('n', '<leader>e', require('mini.files').open, 'File tree')

require('mini.indentscope').setup({
  draw = {
    delay = 1000,
    predicate = function(scope)
      local buftype = vim.api.nvim_get_option_value('buftype', { buf = 0 })
      if 'terminal' == buftype then return false end

      local total_lines = (scope.border.bottom - scope.border.top) + 1
      return not scope.body.is_incomplete and total_lines >= 10
    end,
  },
})
