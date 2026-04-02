--[[
This isn't exactly an LSP extension, but I have it working with the LSP
Tree Sitter takes in a language and some source code and can parse out the meaning using text queries
It's most famous use case is highlighting and text colors
TODO: nvim-treesitter/nvim-treesitter-context
]]

local function detect_parser()
  local language = vim.treesitter.language.get_lang(vim.bo.filetype)
  local parsers = require("nvim-treesitter.parsers")

  if parsers[language] then return language end
  return nil
end

local function enable_ts_for_buffer()
  pcall(vim.treesitter.start)
  vim.opt_local.foldmethod = "expr"
  vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt_local.foldlevel = 99 -- start with everything open
end

local config = function()
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      local parser = detect_parser()
      if not parser then return end

      local is_installed = #vim.api.nvim_get_runtime_file("parser/" .. parser .. ".so", false) > 0
      if not is_installed then
        vim.schedule(function()
          require("nvim-treesitter.install").install({ parser })
          vim.defer_fn(enable_ts_for_buffer, 200)
        end)
      else
        enable_ts_for_buffer()
      end
    end,
  })
end

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',       -- Master deprecated
  build = ':TSUpdate',
  -- dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' }, -- configured in it's own file
  config = config,
  -- event = { 'BufReadPre', 'BufNewfile' }
  lazy = false
}
