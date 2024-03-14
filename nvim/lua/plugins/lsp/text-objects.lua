--[[
Text objects uses the parsers from tree sitter to add additional objects to vim commands
Example: diw  |  In this case `w` is the `word` object, and the word will be deleted. Text objects can add `dif` where the object is a function parsed by tree sitter
]]

local maps = {
  -- Assignment binds: Assignment example: `my_var = 5`
  ['a='] = { query = '@assignment.outer', desc = 'Select outer part of assignment operation' }, -- how to use: `da=` delete around assignment
  ['i='] = { query = '@assignment.inner', desc = 'Select inner part of assignment operation' },
  -- this makes it so you can't use l to move in visual mode. Must be changed to something else
  --['l='] = { query = '@assignment.lhs', desc = 'Select left-side of assignment operator' },
  --['r='] = { query = '@assignment.rhs', desc = 'Select right-side of assignment operator' },
  ['='] = { query = '@assignment.rhs', desc = 'Select right-side of assignment operator' },

  -- Params / Args
  ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a function argument' }, -- around argument
  ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a function argument' },

  -- Conditional statements
  ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of conditional statement' }, -- around if
  ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of conditional statement' },

  -- Loops
  ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' }, -- around loop
  ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },

  -- Functions / Methods
  ['ac'] = { query = '@call.outer', desc = 'Select outer part of function call' }, -- around function | This is not an actual function, just the call, ex: `sum(5,3)`
  ['ic'] = { query = '@call.inner', desc = 'Select inner part of function call' }, -- couldn't use ac/ic because 
  ['af'] = { query = '@function.outer', desc = 'Select outer part of function definition' }, -- around definition
  ['if'] = { query = '@function.inner', desc = 'Select inner part of function definition' }
}


local swap = {
  enable = true,
  swap_next = {
    ['<leader>na'] = { query = '@parameter.inner', desc = 'Swap with next function argument' },
    ['<leader>nf'] = { query = '@function.outer', desc = 'Swap with next function' },
  },
  swap_previous = {
    ['<leader>ba'] = { query = '@parameter.inner', desc = 'Swap with previous argument' },
    ['<leader>bf'] = { query = '@function.outer', desc = 'Swap with previous function argument' }
  }
}


local config = function()
  local setup = {
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = maps,
      },
      swap = swap
    },
  }

  require('nvim-treesitter.configs').setup(setup)
end


return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  lazy = true, -- don't load until treesitter asks for it
  config = config
}
