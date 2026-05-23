local colors = require('colors')

hl.config({
  general = {
    gaps_in = 8,
    gaps_out = 20,
    border_size = 2,
    allow_tearing = false,
    layout = "scrolling",
    no_focus_fallback = true,

    col = {
      active_border   = colors.blue,
      inactive_border = colors.bg_highlight,
    },
  },

  decoration = {
    rounding = 12,
    blur = {
      size = 5,
      passes = 3,
    },

    shadow = {
      range = 25,
      render_power = 4,
      color = colors.transparent.black,
      color_inactive = colors.transparent.shadow,
    },

    glow = {
      enabled = true,
      color = colors.transparent.blue,
    },
  },

  misc = {
    font_family = 'MesloLGL Nerd Font',
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    vrr = 2, -- variable refresh rate only fullscreen
  }
})

-- animations provided by Gemini
-- Define a custom, aggressive snappy bezier curve
hl.curve("snappy", { type = "bezier", points = { {0.25, 1}, {0.5, 1} } })

-- Define a hyper-responsive spring for tiling window snaps
hl.curve("responsiveSpring", { type = "spring", mass = 1, stiffness = 110, dampening = 19 })

-- Master Window Settings (Fades and Moves)
hl.animation({ leaf = "windows",    enabled = true, speed = 4.5, spring = "responsiveSpring" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 3.8, spring = "responsiveSpring", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.0, bezier = "snappy",           style = "popin 90%" })

-- Fast Fades for Layers and Elements
hl.animation({ leaf = "fade",       enabled = true, speed = 2.5, bezier = "snappy" })
hl.animation({ leaf = "layers",     enabled = true, speed = 3.0, bezier = "snappy",           style = "fade" })

-- Sleek Workspace Slide
-- Removing 'style = "fade"' lets workspaces physically slide left/right on screen
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.5, bezier = "snappy" })
