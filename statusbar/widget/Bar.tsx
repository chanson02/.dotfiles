import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable } from "astal"
import Hyprspaces from "./Hyprspaces"
import Gio from "gi://Gio";
import OpenTrayWindow from "./SystemTray"

const time = Variable("").poll(1000, "date")
const TRAY_ICON = Gio.Icon.new_for_string("dialog-information-symbolic");

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return <window
        className="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.LEFT
            | Astal.WindowAnchor.RIGHT}
        application={App}>
        <centerbox>
            <button
                onClicked="echo hello"
                halign={Gtk.Align.CENTER} >
                Welcome to AGS!
            </button>
            <box>
              <Hyprspaces />
              <button
                  onClick={OpenTrayWindow}>
                  <icon gIcon={TRAY_ICON} />
                </button>
            </box>
            <button
                onClick={() => print("hello")}
                halign={Gtk.Align.CENTER} >
                <label label={time()} />
            </button>
        </centerbox>
    </window>
}
