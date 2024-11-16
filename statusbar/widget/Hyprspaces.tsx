import Hyprland from "gi://AstalHyprland";
import { Binding, bind } from "astal";

interface WorkspaceButtonProps {
  workspace: Hyprland.Workspace;
  focused: Binding<Hyprland.Workspace>;
}
const WorkspaceButton = ({ workspace, focused }: WorkspaceButtonProps) => {
  return (
    <button
      className={focused.as(fw => workspace === fw ? "focused" : "")}
      onClicked={() => workspace.focus()}
    >
      {workspace.id}
    </button>
  );
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
        wss.map((ws) => (
          <WorkspaceButton workspace={ws} focused={focused} />
          )),
      )}
    </box>
  );
}
