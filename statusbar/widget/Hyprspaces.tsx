import Hyprland from "gi://AstalHyprland";
import { bind } from "astal";

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
            <button
              className={focused.as((fw) =>
                ws === fw ? "focused" : "",
              )}
              onClicked={() => ws.focus()}
            >
              {ws.id}
            </button>
          )),
      )}
    </box>
  );
}
