import Hyprland from "gi://AstalHyprland";
import { Binding, bind } from "astal";
import Gio from "gi://Gio";
import GLib from "gi://GLib";

const FALLBACK_ICON = Gio.Icon.new_for_string("dialog-information-symbolic");

/**
  * Directories where .desktop files are found
*/
const DESKTOP_DIRS = [
  "/usr/share/applications/",
  "/var/lib/flatpak/exports/share/applications/",
  `${GLib.get_home_dir()}/.local/share/applications/`,
];

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

function clientIdentifiers(c: Hyprland.Client) {
  return [
    c.get_class(),
    c.get_initial_class(),
    c.get_title(),
    c.get_initial_title(),
  ];

}

function loadKeyFile(path: string) {
  const result = new GLib.KeyFile();
  result.load_from_file(path, GLib.KeyFileFlags.NONE);
  return result;
}

function isIdentifierMatch(file: GLib.KeyFile, identifiers: string[]) {
  var startup = null;
  var name = null;
  try { startup = file.get_string("Desktop Entry", "StartupWMClass"); }
  catch {}
  try { name = file.get_string("Desktop Entry", "Name"); }
  catch {}
  return (name && identifiers.includes(name)) || (startup && identifiers.includes(startup));
}

function clientDesktopFile(client: Hyprland.Client): GLib.KeyFile | undefined {
  const identifiers = clientIdentifiers(client);

  for (const desktop_dir of DESKTOP_DIRS) {
    const dir = Gio.File.new_for_path(desktop_dir);
    const _enum = dir.enumerate_children(
      "standard::name",
      Gio.FileQueryInfoFlags.NONE,
      null,
    );

    let fileInfo: Gio.FileInfo | null;
    while ((fileInfo = _enum.next_file(null)) !== null) {
      const fname = fileInfo.get_name();
      if (!fname.endsWith(".desktop")) { continue; } // skip non-.desktop files
      const path = `${desktop_dir}${fname}`;
      const keyFile = loadKeyFile(path);

      if (isIdentifierMatch(keyFile, identifiers)) { return keyFile; }
    }
  }
  console.warn(`No desktop file found for ${identifiers[0]}`);
  return undefined;
}

function extractIcon(client: Hyprland.Client): Gio.Icon {
  if (!client) { return FALLBACK_ICON; }
  const desktopFile = clientDesktopFile(client);
  if (!desktopFile) { return FALLBACK_ICON; }
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
