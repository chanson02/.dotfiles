-- These should be being set automatically?
-- hl.env("XDG_SESSION_TYPE", "wayland")
-- hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
-- hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("GDK_BACKEND", "wayland,x11")     -- default to Wayland for GTK apps
hl.env("QT_QPA_PLATFORM", "wayland;xcb") -- default to Wayland for QT apps
hl.env("SDL_VIDEODRIVER", "wayland,x11") -- default to Wayland for SDL games

hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- hl.env("GTK_THEME")
-- hl.env("XCURSOR_THEME")
hl.env("XCURSOR_SIZE", "30")

-- sudo grubby --update-kernel=ALL --args="nvidia-drm.modeset=1" to enable nvidia DRM
hl.env("GBM_BACKEND", "nvidia-drm")           -- NVIDIA Generic Buffer Management
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")         -- Hardware acceleration
hl.env("__GL_GSYNC_ALLOWED", "1")             -- Use GSYNC
hl.env("__GL_VRR_ALLOWED", "1")               --
