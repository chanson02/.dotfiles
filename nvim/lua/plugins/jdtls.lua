--[[
Language server tools for java
Make sure to install jdtls from mason first
]]

local function file_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == 'file' or false
end

local function copy_file(src, dst)
  local source = vim.loop.fs_open(src, "r", 438, nil)
  local stat = vim.loop.fs_fstat(source)
  local data = vim.loop.fs_read(source, stat.size, 0)
  vim.loop.fs_close(source)

  local destination = vim.loop.fs_open(dst, "w", 438)
  vim.loop.fs_write(destination, data, 0)
  vim.loop.fs_close(destination)
end

local function find_build_file(project_directory)
  local files = vim.fs.find(
  { 'settings.gradle', 'settings.gradle.kts' },
  { path = project_directory }
  )
  if #files > 0 then
    return files[1]
  end
  return nil
end

-- Copies build.gradle(.kts) to where jdtls can use it
local function init_gradle(project_directory)
  local actual = find_build_file(project_directory)
  local expected = project_directory .. '/app/' .. vim.fs.basename(actual)
  if not file_exists(expected) and actual then
    copy_file(actual, expected)
  end
end

local config = function()
  local project_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1])
  init_gradle(project_dir)

  local jdtls_exe = vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')

  local dap_dir = vim.fn.expand('~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/')
  local dap_server = vim.fn.glob(dap_dir .. 'com.microsoft.java.debug.plugin-*.jar', 1)

  -- local java_version = '11.0.12' -- throws "jdtls requires at least Java 17"
  -- local java_version = '17.0.1'
  -- local java_exe = '/home/chanson/.sdkman/candidates/java/' .. java_version .. '-open/bin/java'

  local config = {
    -- cmd = { jdtls_exe, '-data', workspace_dir, '--java-executable', java_exe },
    cmd = { jdtls_exe },
    root_dir = project_dir,
    init_options = {
      bundles = { dap_server }
    },
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
