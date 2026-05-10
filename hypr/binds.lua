local terminal = 'ghostty'
local fileManager = 'dolphin'
local menu = 'wofi --show drun'

local function get_monitor(direction)
  local monitors = hl.get_monitors()
  local current = hl.get_active_monitor()
  if not current or #monitors < 2 then return current end

  table.sort(monitors, function(a, b) return a.x < b.x end)
  for i, m in ipairs(monitors) do
    if m.name == current.name then
      if direction == 'l' then
        return monitors[i > 1 and i - 1 or #monitors]
      else
        return monitors[i < #monitors and i + 1 or 1]
      end
    end
  end

  return current
end

-- Launchers
hl.bind(
  "SUPER + SUPER_L",
  hl.dsp.exec_cmd(menu),
  { release = true }
)
hl.bind(
  "SUPER + SHIFT + 1",
  hl.dsp.exec_cmd(terminal),
  { description = 'Launch Terminal' }
)

-- Window Operations
hl.bind(
  "SUPER + C",
  hl.dsp.window.close(),
  { description = 'Close Window' }
)
hl.bind(
  "SUPER + V",
  hl.dsp.window.float({ action = 'toggle' }),
  { description = 'Window: toggle floating' }
)

-- Window focus
hl.bind(
  "SUPER + H",
  hl.dsp.focus({ direction = 'left' }),
  { description = 'Focus: move left' }
)
hl.bind(
  "SUPER + J",
  hl.dsp.focus({ direction = 'down' }),
  { description = 'Focus: move down' }
)
hl.bind(
  "SUPER + K",
  hl.dsp.focus({ direction = 'up' }),
  { description = 'Focus: move up' }
)
hl.bind(
  "SUPER + L",
  hl.dsp.focus({ direction = 'right' }),
  { description = 'Focus: move right' }
)

-- Window movement
local keys = { 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'}
for i, key in ipairs(keys) do
  hl.bind(
    "SUPER + " .. key,
    hl.dsp.focus({ workspace = i }),
    { description = 'Focus: workspace ' .. i }
  )
  hl.bind(
    "SUPER + SHIFT + " .. key,
    hl.dsp.window.move({ workspace = i }),
    { description = 'Move window to workspace ' .. i }
  )
end
hl.bind(
  "SUPER + SHIFT + H",
  hl.dsp.window.move({ direction = 'l' }),
  { description = 'Move window left' }
)
hl.bind(
  "SUPER + SHIFT + L",
  hl.dsp.window.move({ direction = 'r' }),
  { description = 'Move window right' }
)
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspace movement
hl.bind(
  "SUPER + CTRL + H",
  function()
    hl.dispatch(hl.dsp.workspace.move({ monitor = get_monitor('l').name }))
  end,
  { description = 'Move workspace left' }
)
hl.bind(
  "SUPER + CTRL + L",
  hl.dsp.workspace.move({ monitor = get_monitor('r').name }),
  { description = 'Move workspace right' }
)


-- Multimedia
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
  { repeating = true, description = 'Raise volume', locked = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { repeating = true, description = 'Lower volume', locked = true }
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { description = 'Mute audio', locked = true }
)
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { description = 'Mute microphone', locked = true }
)

hl.bind(
  "XF86AudioPlay",
  hl.dsp.exec_cmd("playerctl play-pause"),
  { description = 'Play media', locked = true }
)
hl.bind(
  "XF86AudioPrev",
  hl.dsp.exec_cmd("playerctl previous"),
  { description = 'Rewind media', locked = true }
)
hl.bind(
  "XF86AudioNext",
  hl.dsp.exec_cmd("playerctl next"),
  {  description = 'Skip media', locked = true }
)

hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd("brightnessctl s 10%+"),
  { repeating = true, description = 'Raise brightness', locked = true }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd("brightnessctl s 10%-"),
  { repeating = true, description = 'Lower brightness', locked = true }
)
