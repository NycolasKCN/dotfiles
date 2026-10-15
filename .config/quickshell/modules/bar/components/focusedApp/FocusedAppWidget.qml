import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../../../config.js" as Config

Text {
    id: root

    property string appClass: ""

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name === "activewindow")
                root.appClass = event.parse(2)[0]
        }
    }

    Component.onCompleted: {
        const top = Hyprland.activeToplevel
        appClass = top?.wayland?.appId ?? top?.lastIpcObject?.class ?? ""
    }

    visible: appClass !== ""
    text: appClass
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter

    color: Config.colors.foreground
    font.family: Config.fonts.primary
    font.pointSize: Config.fonts.size.small
    font.weight: Config.fonts.weight.medium
    font.capitalization: Font.AllLowercase
}
