vim.pack.add({ 'https://github.com/b0o/SchemaStore.nvim' })

local schemas = vim.tbl_deep_extend(
  'force',
  require('schemastore').json.schemas(), -- default schemas
  {
    {
      description = "OpenCode AI coding agent theme file",
      fileMatch = { "opencode-theme.json", ".opencode/theme.json", "theme.json" },
      name = "opencode-theme",
      url = "https://gttps://opencode.ai/theme.json",
    },
  }
)

return {
  settings = {
    json = {
      schemas = schemas,
      validate = { enable = true },
    },
  },
}
