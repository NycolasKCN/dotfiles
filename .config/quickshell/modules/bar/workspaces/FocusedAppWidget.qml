import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../theme"

Text {
    id: root

    readonly property HyprlandToplevel toplevel: Hyprland.activeToplevel
    readonly property string appId: toplevel?.lastIpcObject.class ?? ""

    readonly property bool onCurrentWorkspace: toplevel?.workspace !== null && toplevel?.workspace === Hyprland.focusedWorkspace

    visible: onCurrentWorkspace && appId !== ""

    text: appId
    elide: Text.ElideRight
    color: Colors.foreground
    font.family: Fonts.primary
    font.pixelSize: Fonts.normal
    font.weight: Fonts.mediumWeight
}
