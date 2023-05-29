local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  print('Failed to load Null-LS')
  return
end

local formatters = null_ls.builtins.formatting
--local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    formatters.blue
  }
})
