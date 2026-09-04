-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Load Omarchy defaults.
require("default.hypr.omarchy")

package.path = package.path .. ";./?.lua;./?/init.lua"
require("plugins.smw").setup({
  workspace_count = 10,
  enable_persistent_workspaces = true,
  link_monitors = true,
})
require("hypr.monitors")
require("hypr.bindings")
require("hypr.looknfeel")

-- Toggle config flags dynamically.
require("default.hypr.toggles")
