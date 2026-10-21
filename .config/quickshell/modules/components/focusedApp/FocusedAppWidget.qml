import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config

Text {
    id: root

    property string appId: ""
    readonly property string appName: appId !== ""
        ? (DesktopEntries.heuristicLookup(appId)?.name ?? appId)
        : ""
    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name === "activewindow")
                root.appId = event.parse(2)[0];
        }
    }

    Component.onCompleted: {
        const top = Hyprland.activeToplevel;
        appId = top?.wayland?.appId ?? top?.lastIpcObject?.class ?? "";
    }

    visible: appId !== ""
    text: appName
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter

    color: Config.colors.foreground
    font.family: Config.fonts.primary
    font.pointSize: Config.fonts.size.small
    font.weight: Config.fonts.weight.medium
    font.capitalization: Font.AllLowercase
}
