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

/**
  * Extracts data that can be used to identify a Hyprland Client
*/
function clientIdentifiers(c: Hyprland.Client) {
  return [
    c.get_class(),
    c.get_initial_class(),
    c.get_title(),
    c.get_initial_title(),
  ];
}

/**
  * Load a keyfile from a specified path
*/
function loadKeyFile(path: string) {
  const result = new GLib.KeyFile();
  result.load_from_file(path, GLib.KeyFileFlags.NONE);
  return result;
}

/**
  * Checks if the identifiers match either the `Name` or `StartupWMClass` in the .desktop file
  * @param {GLib.KeyFile} file - The .desktop file
  * @param {string[]} identifiers - names or startup classes to look for
  * @returns {boolean} whether the identifiers match this desktop file
*/
function isIdentifierMatch(file: GLib.KeyFile, identifiers: string[]): boolean {
  var startup = null;
  var name = null;
  try { startup = file.get_string("Desktop Entry", "StartupWMClass"); }
  catch {}
  try { name = file.get_string("Desktop Entry", "Name"); }
  catch {}
  return (name !== null && identifiers.includes(name)) || (startup !== null && identifiers.includes(startup));
}

/**
  * Searches for a .desktop file related to the client
  * @param {Hyprland.Client} client - The client to find the desktop file for
  * @returns {GLib.KeyFile | undefined} The matching desktop file, if any
*/
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

/**
  * Finds the icon for the client
*/
function extractIcon(client: Hyprland.Client): Gio.Icon {
  if (!client) { return FALLBACK_ICON; }
  const desktopFile = clientDesktopFile(client);
  if (!desktopFile) { return FALLBACK_ICON; }
  const appInfo = Gio.DesktopAppInfo.new_from_keyfile(desktopFile);
  return appInfo.get_icon() || FALLBACK_ICON;
}

/**
  *** COMPONENTS ***
*/

/**
  * Component which displays the workspace and an icon
*/
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
