local mainMod   = "SUPER + "
local secondMod = "SUPER + SHIFT + "

local terminal    = "ghostty"
local fileManager = "dolphin"
local noctalia    = "qs -c noctalia-shell ipc call "
local menu        = noctalia .. "launcher toggle"

local numberBinds = { "q", "w", "e", "r", "t", "y", "u", "i", "o", "p" }

-- Launchers
hl.bind(
  mainMod .. "SUPER_L",
  hl.dsp.exec_cmd(menu),
  { description = "App Launcher", release = true }
)
hl.bind(secondMod .. "1",  hl.dsp.exec_cmd(terminal), { description = "Launch Terminal" })
hl.bind(secondMod .. "3", hl.dsp.exec_cmd(fileManager), { description = "Launch file navigator" })

-- Window Operations
hl.bind(mainMod .. "C", hl.dsp.window.close(),                            { description = "Close Window" })
hl.bind(mainMod .. "V", hl.dsp.window.float({ action = "toggle" }),       { description = "Window: toggle floating" })
hl.bind(mainMod .. "F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), { description = "Window: toggle maximized" })
hl.bind(secondMod .. "F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "WIndow: toggle fullscreen" })

hl.bind(mainMod .. "H", hl.dsp.focus({ direction = "left" }),  { description = "Focus: move left" })
hl.bind(mainMod .. "J", hl.dsp.focus({ direction = "down" }),  { description = "Focus: move down" })
hl.bind(mainMod .. "K", hl.dsp.focus({ direction = "up" }),    { description = "Focus: move up" })
hl.bind(mainMod .. "L", hl.dsp.focus({ direction = "right" }), { description = "Focus: move right" })

hl.bind(secondMod .. "H", hl.dsp.window.move({ direction = "l" }), { description = "Move window left" })
hl.bind(secondMod .. "L", hl.dsp.window.move({ direction = "r" }), { description = "Move window right" })

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.config({
  scrolling = {
    explicit_column_widths = "0.25, 0.333, 0.5, 0.667, 0.75, 1.0"
  }
})
hl.bind(mainMod .. "comma", hl.dsp.layout("colresize -conf"), { description = "Shrink column size" })
hl.bind(mainMod .. "period", hl.dsp.layout("colresize +conf"), { description = "Grow column size" })

-- Workspace Operations
for i, key in ipairs(numberBinds) do
  hl.bind(
    mainMod .. key,
    hl.dsp.focus({ workspace = i }),
    { description = "Focus: workspace " .. i }
  )
  hl.bind(
    secondMod .. key,
    hl.dsp.window.move({ workspace = i }),
    { description = "Move window to workspace " .. i }
  )
  hl.bind(
    "SUPER + CTRL + " .. key,
    function()
      local monitors = hl.get_monitors()
      table.sort(monitors, function(a, b) return a.x < b.x end)

      local target = monitors[i]
      if target then hl.dispatch(hl.dsp.workspace.move({ monitor = target })) end
    end,
    { description = "Move workspace to monitor " .. i }
  )
end


-- Audio Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, description = "Raise volume", locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, description = "Lower volume", locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { description = "Mute audio", locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { description = "Mute microphone", locked = true })

-- Media Control
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { description = "Play media", locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { description = "Rewind media", locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { description = "Skip media", locked = true })

-- Backlight
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true, description = "Raise brightness", locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true, description = "Lower brightness", locked = true })
