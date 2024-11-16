import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar"

App.start({
    instanceName: 'chanson02-statusbar',
    css: style,
    main() {
        App.get_monitors().map(Bar)
    },
})
