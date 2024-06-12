--[[
Language server tools for java
Make sure to install jdtls from mason first
]]

local config = function()
  local config = {
    cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1])
  }
  require('jdtls').start_or_attach(config)
end

return {
  'mfussenegger/nvim-jdtls',
  config = config,
  lazy = true,
  ft = 'java' -- only load in java files
}
