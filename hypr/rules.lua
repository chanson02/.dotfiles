hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

hl.layer_rule({
  name = 'noctalia',
  match = {
    namespace = 'noctalia-background-.*$',
  },
  blur = true,
  blur_popups = true,
  ignore_alpha = 0.5,
})
