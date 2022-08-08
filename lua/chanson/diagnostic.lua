
-- options for if enabled vs diabled
local diag_disable = {virtual_text = false, underline = false}
local diag_enable = {virtual_text = true, underline = true, sign = true}

-- Default on startup
vim.diagnostic.config(diag_disable)
vim.g.diagnostics_active = false

-- Function for changing diagnostic mode
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.diagnostic.config(diag_disable)
  else
    vim.diagnostic.config(diag_enable)
  end
  vim.g.diagnostics_active = not vim.g.diagnostics_active
end
