import QtQuick
import Quickshell.Hyprland
import "../../theme"

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
    implicitWidth: 26
    implicitHeight: 20
    radius: 6
    color: isActive ? Colors.primary : Colors.background
    Behavior on color {
        ColorAnimation {
            duration: 120
        }
    }

    Text {
        anchors.centerIn: parent
        text: Icons.workspace(root.workspace.name, root.workspace.id)
        color: isActive ? Colors.background : Colors.primary

        font.family: Fonts.primary
        font.pointSize: Fonts.small
        font.weight: Fonts.mediumWeight

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
