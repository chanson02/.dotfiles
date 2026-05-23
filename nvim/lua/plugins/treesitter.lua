vim.pack.add({{
  src = "https://github.com/nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
}})

local function detect_parser()
  local language = vim.treesitter.language.get_lang(vim.bo.filetype)
  local parsers = require("nvim-treesitter.parsers")

  if parsers[language] then return language end
  return nil
end

local function enable_for_buffer()
  if pcall(vim.treesitter.start) then
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.wo[0][0].foldlevel = 99
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    -- ^ did not work well with lua
  end
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local parser = detect_parser()
    if not parser then return end

    local is_installed = #vim.api.nvim_get_runtime_file("parser/" .. parser .. ".so", false) > 0
    if not is_installed then
      require("nvim-treesitter.install").install({ parser })
    end
    enable_for_buffer()
  end,
})
