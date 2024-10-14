const hyprland = await Service.import('hyprland');
const Gio = imports.gi.Gio;

const ICON_SIZE = 20;
const FALLBACK_ICON = 'dialog-information-symbolic';
const NO_APPLICATIONS_ICON = 'dialog-information-symbolic';

const MANUAL_OVERRIDES = {
  'zen-alpha': 'zen browser'
}
const iconCache = new Map();

/**
 * @param {string} input
 */
function normalize(input) {
  return input.toLowerCase().replace(/-/g, ' ');
}

/**
 * @param {number} workspaceId
 * Returns the icon of the first client open in this workspace
 */
function WorkspaceIcon(workspaceId) {
  const clients = hyprland.clients.filter(client => client.workspace.id === workspaceId);
  if (clients.length === 0) { return Widget.Icon({ icon: NO_APPLICATIONS_ICON, size: ICON_SIZE }); }

  const cachedIcon = iconCache.get(clients[0].class)
  if (cachedIcon) { return Widget.Icon({ icon: cachedIcon, size: ICON_SIZE}); }

  const app = MANUAL_OVERRIDES[clients[0].class] || normalize(clients[0].class);
  const appinfo = Gio.AppInfo.get_all().find(info => normalize(info.get_name()).includes(app))
  const icon = appinfo?.get_icon()?.to_string() || FALLBACK_ICON;
  iconCache.set(clients[0].class, icon);
  return Widget.Icon({ icon: icon, size: ICON_SIZE });
}

/**
 * @param {number} workspaceId
 * @param {import("../types/service").Binding<import("../types/service/hyprland").ActiveID, "id", number>} active
 */
function WorkspaceButton(workspaceId, active) {
  const container = Widget.Box({
    children: [
      Widget.Label({ label: `${workspaceId}` }),
      WorkspaceIcon(workspaceId),
    ],
  });

  return Widget.Button({
    on_clicked: () => hyprland.messageAsync(`dispatch workspace ${workspaceId}`),
    child: container,
    class_name: active.as(id => id === workspaceId ? 'active' : ''),
  });
}

function Workspaces() {
  const activeId = hyprland.active.workspace.bind('id');
  const workspaces = hyprland.bind('workspaces')
    .as(ws => {
      return ws
        .sort((a, b) => a.id - b.id)
        .map(({ id }) =>
          WorkspaceButton(id, activeId)
        )
    });

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
}
export { Workspaces };

