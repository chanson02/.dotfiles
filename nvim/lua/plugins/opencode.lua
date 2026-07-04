vim.pack.add({ 'https://github.com/nickjvandyke/opencode.nvim' })

vim.g.opencode_opts = {
  events = {
    permissions = {
      enabled = false,    -- use TUI for permissions
    }
  }
}

vim.o.autoread = true

local k = vim.keymap.set
k("n",          "<C-.>", function() require("opencode").ask() end, { desc = "Opencode" })
k({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end, { desc = "Ask opencode" })
k({ "n", "x" }, "<leader>os", function() require("opencode").select() end,       { desc = "Select opencode" })
k({ "n", "x" }, "go",  function() return require("opencode").operator("```@this``` ") end,        { desc = "Append range to OpenCode", expr = true })
k("n",          "goo", function() return require("opencode").operator("```@this``` ") .. "_" end, { desc = "Append line to OpenCode", expr = true })

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if bufname:match("opencode %-%-port") then
      vim.keymap.set("n", "<C-u>", function() require("opencode").command("session.half.page.up") end, { buffer = args.buf })
      vim.keymap.set("n", "<C-d>", function() require("opencode").command("session.half.page.down") end, { buffer = args.buf })
      vim.keymap.set("t", "<C-u>", [[<Cmd>lua require("opencode").command("session.half.page.up")<CR>]], { buffer = args.buf })
      vim.keymap.set("t", "<C-d>", [[<Cmd>lua require("opencode").command("session.half.page.down")<CR>]], { buffer = args.buf })
    end
  end
})
