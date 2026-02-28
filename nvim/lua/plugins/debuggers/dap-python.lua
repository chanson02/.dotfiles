local function config()
  require("dap-python").setup("uv")
end

return {
  'mfussenegger/nvim-dap-python',
  config = config,
  lazy = true,
  ft = 'python',
  dependencies = { 'mfussenegger/nvim-dap' }
}
