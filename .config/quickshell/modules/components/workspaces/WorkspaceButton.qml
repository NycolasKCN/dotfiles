import QtQuick
import Quickshell.Hyprland
import qs.config

Rectangle {
    id: root
    required property HyprlandWorkspace workspace

    property string activeSpecial: ""

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activespecial") {
                // Gets the name (e.g., "special:magic")
                root.activeSpecial = event.parse(2)[0];
            }

            if (event.name === "workspace") {
                root.activeSpecial = "";
            }
        }
    }

    readonly property bool isActive: workspace.focused || activeSpecial === workspace.name
    implicitWidth: 24
    implicitHeight: 20
    radius: Config.sizes.radius.normal
    color: isActive ? Config.colors.primary : Config.colors.bg

    Behavior on color {
        ColorAnimation {
            duration: 120
        }
    }

    Text {
        anchors.centerIn: parent
        text: Config.icons.workspace(root.workspace.name, root.workspace.id)
        color: root.isActive ? Config.colors.bg : Config.colors.primary

        font.family: Config.fonts.primary
        font.pointSize: Config.fonts.size.small
        font.weight: Config.fonts.weight.medium

        Behavior on color {
            ColorAnimation {
                duration: 120
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.workspace.activate()
    }
}
