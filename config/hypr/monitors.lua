hl.monitor({
  output = 'HDMI-A-1',
  mode = '1920x1080@60',
  position = '4480x180',
  scale = '1',
})

hl.monitor({
  output = 'DP-1',
  mode = '1920x1080@60',
  position = '0x180',
  scale = '1',
})

hl.monitor({
  output = 'DP-2',
  mode = '2560x1440@144',
  position = '1920x0',
  scale = '1',
})

hl.config({
  input = {
    kb_layout = "us",
    sensitivity = -0.5,
  }
})

-- NVIDIA env vars (per Hyprland wiki)
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("XCURSOR_SIZE", "30")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("__GL_VRR_ALLOWED", "1")
