import Hyprland from "gi://AstalHyprland";
import { Binding, bind } from "astal";
import Gio from "gi://Gio";
import GLib from "gi://GLib";

const FALLBACK_ICON = Gio.Icon.new_for_string("dialog-information-symbolic");

interface WorkspaceButtonProps {
  workspace: Hyprland.Workspace;
  focused: Binding<Hyprland.Workspace>;
}
const WorkspaceButton = ({ workspace, focused }: WorkspaceButtonProps) => {
  const icon = extractIcon(workspace.get_last_client());

  const cls = focused.as((fw) => (workspace === fw ? "focused" : ""));
  return (
    <button
      className={cls.as((cls) => cls)}
      onClicked={() => workspace.focus()}
    >
      <box>
        {workspace.id}
        <icon gIcon={icon} />
      </box>
    </button>
  );
};

const DESKTOP_DIRS = [
  "/usr/share/applications/",
  "/var/lib/flatpak/exports/share/applications/",
  `${GLib.get_home_dir()}/.local/share/applications/`,
]; // paths where .desktop files can live
function findDesktopFile(client: Hyprland.Client): GLib.KeyFile | undefined {
  const identifiers = [
    client.get_class(),
    client.get_initial_class(),
    client.get_title(),
    client.get_initial_title(),
  ];

  for (const desktop_dir of DESKTOP_DIRS) {
    const dir = Gio.File.new_for_path(desktop_dir);
    try {
      const _enum = dir.enumerate_children(
        "standard::name",
        Gio.FileQueryInfoFlags.NONE,
        null,
      );

      let fileInfo: Gio.FileInfo | null;
      while ((fileInfo = _enum.next_file(null)) !== null) {
        const fname = fileInfo.get_name();
        if (!fname.endsWith(".desktop")) {
          continue;
        } // skip non-.desktop files
        const path = `${desktop_dir}${fname}`;

        const keyFile = new GLib.KeyFile();
        keyFile.load_from_file(path, GLib.KeyFileFlags.NONE);

        var startup = null;
        var name = null;
        try {
          startup = keyFile.get_string("Desktop Entry", "StartupWMClass");
        } catch {}
        try {
          name = keyFile.get_string("Desktop Entry", "Name");
        } catch {}
        const identifierFound =
          (name && identifiers.includes(name)) ||
          (startup && identifiers.includes(startup));
        if (identifierFound) {
          return keyFile;
        }
      }
    } catch (err) {
      console.warn(err);
    }
  }
  console.warn(`No desktop file found for ${identifiers[0]}`);
  return undefined;
}

function extractIcon(client: Hyprland.Client): Gio.Icon {
  const desktopFile = findDesktopFile(client);
  if (!desktopFile) {
    return FALLBACK_ICON;
  }
  const appInfo = Gio.DesktopAppInfo.new_from_keyfile(desktopFile);
  return appInfo.get_icon() || FALLBACK_ICON;
}

export default function Hyprspaces() {
  const hypr = Hyprland.get_default();
  const focused = bind(hypr, "focusedWorkspace");
  const spaces = bind(hypr, "workspaces").as((ws) =>
    ws.sort((a, b) => a.id - b.id),
  );

  return (
    <box className="Workspaces">
      {spaces.as((wss) =>
        wss.map((ws) => <WorkspaceButton workspace={ws} focused={focused} />),
      )}
    </box>
  );
}
