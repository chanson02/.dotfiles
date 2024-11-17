import { App } from "astal/gtk3";
import { bind } from "astal";
import { Astal, Gdk, Gtk } from "astal/gtk3";
import Tray from "gi://AstalTray";

function SystemTray() {
  const tray = Tray.get_default();

  return (
    <box>
      {
        bind(tray, "items").as(items => items.map(item => {
          if (item.iconThemePath) { App.add_icons(item.iconThemePath); }
          const menu = item.create_menu()

          return (
            <button
              tooltipMarkup={bind(item, "tooltipMarkup")}
              onDestroy={() => menu?.destroy()}
              onClickRelease={self => {
                menu?.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null)
              }}
            >
              <icon gIcon={bind(item, "gicon")} />
            </button>
          )
        }))
      }
    </box>
  )
}

function onKeyPress(window: Astal.Window, event: Gdk.Event) {
  if (event.get_keyval()[1] === Gdk.KEY_Escape) { window.close(); }
}

export default function OpenTrayWindow() {
  return (
    <window
      onKeyPressEvent={onKeyPress}
      keymode={Astal.Keymode.EXCLUSIVE}
      exclusivity={Astal.Exclusivity.IGNORE}
      application={App}
    >
      <box halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
        <SystemTray />
      </box>
    </window>
  );
}
