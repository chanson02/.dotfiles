local dependencies = {
  "nvim-telescope/telescope.nvim",
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim"
}

return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = dependencies,
  opts = {
    lang = 'java'
  },
  lazy = "leetcode.nvim" ~= vim.fn.argv(0, -1)
}
