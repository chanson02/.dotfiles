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
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    vrr = 2, -- variable refresh rate only fullscreen
  }
})
