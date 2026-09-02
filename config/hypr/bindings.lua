local mainMod  = "SUPER + "
local shftMod  = "SUPER + SHIFT + "
-- local altMod   = "SUPER + ALT + "
local ctrlMod  = "SUPER + CTRL + "

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
rebind(shftMod .. "RETURN", "Browser", { omarchy = "browser" })
rebind(ctrlMod .. "RETURN", "File Explorer", { omarchy = "nautilus" })

-- Window Operations
rebind(mainMod .. "C", "Close Window", hl.dsp.window.close())
rebind(mainMod .. "F", "Maximize", hl.dsp.window.fullscreen({ mode = "maximized" }))
rebind(ctrlMod .. "F", "Fullscreen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
rebind(shftMod .. "F", "Toggle floating", hl.dsp.window.float({ action = "toggle" }))

for direction, bind in pairs(directionBinds) do
  rebind(mainMod .. bind, "Focus window " .. direction, hl.dsp.focus({ direction = direction }))
  rebind(ctrlMod .. bind, "Move window " .. direction, hl.dsp.window.move({ direction = direction }))
end

rebind(mainMod .. "comma", "Shrink column size", hl.dsp.layout("colresize -conf"))
rebind(mainMod .. "period", "Grow column size", hl.dsp.layout("colresize +conf"))
--rebind(mainMod .. "Return", "Move window to its own column", hl.dsp.layout("promote"))

-- Workspace Operations
for i, key in ipairs(numberBinds) do
  rebind(mainMod .. key, "Focus workspace " .. i, hl.dsp.focus({ workspace = i }))
  rebind(ctrlMod .. key, "Move window to workspace " .. i, hl.dsp.window.move({ workspace = i }))
end
for direction, bind in pairs(directionBinds) do
  rebind(shftMod .. bind, "Move workspace to " .. direction .. " monitor", hl.dsp.workspace.move({ monitor = direction }))
end
