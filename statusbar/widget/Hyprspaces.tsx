import Hyprland from "gi://AstalHyprland";
import { bind } from "astal";

const WorkspaceButton = ({ workspace, focusedSpace }) => {
  const cls = workspace === focusedSpace ? "focused" : "";
  return (
    <button className={cls} onClicked={() => workspace.focus()}>
      {workspace.id}
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
      {spaces.as((ws) =>
        ws.map((ws) => (
          <WorkspaceButton workspace={ws} focusedSpace={focused} />
        )),
      )}
    </box>
  );
}
