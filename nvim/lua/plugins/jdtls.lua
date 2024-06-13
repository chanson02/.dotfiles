--[[
Language server tools for java
Make sure to install jdtls from mason first
]]

local config = function()
  local dap_dir = vim.fn.expand('~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/')
  local dap_server = vim.fn.glob(dap_dir .. 'com.microsoft.java.debug.plugin-*.jar', 1)

  local config = {
    cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    init_options = {
      bundles = { dap_server }
    }
  }
  require('jdtls').start_or_attach(config)
end

return {
  'mfussenegger/nvim-jdtls',
  config = config,
  lazy = true,
  ft = 'java', -- only load in java files
  dependencies = { 'mfussenegger/nvim-dap' }
}
