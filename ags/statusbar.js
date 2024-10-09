import { Workspaces } from './widgets/hyprspaces.js';
import { AudioIndicator } from './widgets/audio-indicator.js';
const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S %b %e."'],
});

function Left() {
  return Widget.Box({
    spacing: 8,
    children: [
      Workspaces(),
    ],
  });
}

function Clock() {
  return Widget.Label({
    class_name: "clock",
    label: date.bind(),
  });
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [
      AudioIndicator(),
      Clock(),
    ],
  });
}


/**
 * @param {number} monitor
 */
function StatusBar(monitor) {
  return Widget.Window({
    class_name: 'bar',
    monitor: monitor,
    name: `StatusBar(${monitor})`,
    anchor: ['top', 'left', 'right'],
    layer: 'top',
    keymode: 'none',
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      end_widget: Right(),
    }),
  });
}


App.config({
  style: "./statusbar.css",
  windows: [
    StatusBar(0),
    StatusBar(1),
    StatusBar(2)
  ],
});
export { };
