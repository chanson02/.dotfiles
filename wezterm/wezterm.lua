local wezterm = require 'wezterm'
local config = wezterm.config_builder()


local function file_exists(path)
  local f = io.open(path, 'r')
  if f ~= nil then
    io.close(f)
    return true
  end
  return false
end

local color_path = os.getenv("HOME") .. "/.local/share/nvim/lazy/cyberdream.nvim/extras/wezterm/cyberdream.lua"
if file_exists(color_path) then
  config.colors = dofile(color_path)
end

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 1
config.font = wezterm.font_with_fallback({'MesloLGL Nerd Font Mono'})
config.window_background_gradient = {
  orientation = { Linear = { angle = 25.0 } },
  colors = {
    '#0f0c29',
    '#302b63',
    '#24243e',
  },
  interpolation = 'CatmullRom',
}

return config
