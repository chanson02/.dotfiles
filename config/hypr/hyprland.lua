-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Load Omarchy defaults.
require("default.hypr.omarchy")

require("hypr.monitors")
require("hypr.bindings")
require("hypr.looknfeel")

-- Toggle config flags dynamically.
require("default.hypr.toggles")
