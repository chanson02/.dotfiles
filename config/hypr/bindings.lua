local mainMod  = "SUPER + "
local shftMod  = "SUPER + SHIFT + "
local altMod   = "SUPER + ALT + "
local ctrlMod  = "SUPER + CTRL + "
local cmboMod = "SUPER + CTRL + SHIFT + "

local numberBinds = { "q", "w", "e", "r", "t", "y", "u", "i", "o", "p" }
local directionBinds = {
  left  = "H",
  down  = "J",
  up    = "K",
  right = "L",
}

-- Rebind a key: drop any existing default binding, then apply the override.
local function rebind(keys, description, dispatcher, options)
  pcall(hl.unbind, keys)
  o.bind(keys, description, dispatcher, options)
end

-- Launchers
rebind(mainMod .. "SUPER_L", "App Launcher", "omarchy-menu toggle", { release = true })
rebind(mainMod .. "RETURN", "Terminal", { omarchy = "terminal" })
rebind(ctrlMod .. "RETURN", "Browser", { omarchy = "browser" })
rebind(shftMod .. "RETURN", "File Explorer", { omarchy = "nautilus" })
rebind(altMod .. "K", "Keybindings", "omarchy-menu-keybindings")
rebind(altMod .. "L", "Keybindings", "omarchy-menu-tmux-keybindings")

-- Workspace Operations
local smw = require("plugins.smw")
for i, key in ipairs(numberBinds) do
  local ws = tostring(i == 10 and 0 or i)
  rebind(mainMod .. key, "Focus workspace " .. ws, smw.workspace(ws))
  rebind(shftMod .. key, "Move window to workspace " .. ws, smw.move_to_workspace(ws))
end

-- Window Operations
rebind(mainMod .. "C", "Close Window", hl.dsp.window.close())
rebind(mainMod .. "F", "Maximize", hl.dsp.window.fullscreen({ mode = "maximized" }))
rebind(ctrlMod .. "F", "Fullscreen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
rebind(shftMod .. "F", "Toggle floating", hl.dsp.window.float({ action = "toggle" }))

rebind(mainMod .. "comma", "Shrink window size", hl.dsp.layout("colresize -conf"))
rebind(mainMod .. "period", "Grow window size", hl.dsp.layout("colresize +conf"))
rebind(cmboMod .. "Return", "Move window to its own column", hl.dsp.layout("promote"))

for direction, bind in pairs(directionBinds) do
  rebind(mainMod .. bind, "Focus window " .. direction, hl.dsp.layout("focus " .. direction))
  rebind(ctrlMod .. bind, "Focus monitor " .. direction, hl.dsp.focus({ monitor = direction }))
  rebind(shftMod .. bind, "Move window " .. direction, hl.dsp.window.move({ direction = direction }))
  rebind(cmboMod .. bind, "Move window to " .. direction .. " monitor", hl.dsp.window.move({ monitor = direction }))
end
