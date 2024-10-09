const hyprland = await Service.import('hyprland');

App.applyCss(`
  .workspaces button.focused {
    border-bottom: 3px solid @theme_selected_bg_color;
  }
  `);

function Workspaces() {
  const activeId = hyprland.active.workspace.bind('id');
  const workspaces = hyprland.bind('workspaces')
    .as(ws => {
      return ws
        .sort((a, b) => a.id - b.id)
        .map(({ id }) =>
          Widget.Button({
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
            child: Widget.Label(`${id}`),
            class_name: activeId.as(i => `${i === id ? 'focused' : ''}`)
          })
        )
    });

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
}
export { Workspaces };

