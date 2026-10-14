import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../theme"
import "./time"
import "./workspaces"

Variants {
    model: Quickshell.screens.filter(screen => ["eDP-1", "DP-1"].includes(screen.name))

    PanelWindow {
        required property var modelData
        screen: modelData
        WlrLayershell.namespace: "bar"

        implicitHeight: Sizes.bar.height
        color: Colors.background
        anchors {
            top: true
            left: true
            right: true
        }
        margins {
            top: 0
            left: 0
            right: 0
        }

        // Bottom border
        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 1
            color: Colors.primary
        }

        // Bar Widgets
        RowLayout {
            anchors.fill: parent
            spacing: Sizes.margin.small

            Workspaces {
                Layout.alignment: Qt.AlignCenter
                Layout.leftMargin: Sizes.margin.big
            }

            Item {
                Layout.fillWidth: true
            }

            ClockWidget {
                Layout.alignment: Qt.AlignCenter
                Layout.rightMargin: Sizes.margin.big
            }
        }
    }
}
