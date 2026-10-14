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

        implicitHeight: 32
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

        Rectangle {
            anchors.fill: parent
            color: Colors.background

            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                height: 1
                color: Colors.primary
            }

            RowLayout {
                anchors.fill: parent
                spacing: 4

                Workspaces {
                    Layout.alignment: Qt.AlignCenter
                    Layout.leftMargin: 16
                }

                Item {
                    Layout.fillWidth: true
                }

                ClockWidget {
                    Layout.alignment: Qt.AlignCenter
                    Layout.rightMargin: 16
                }
            }
        }
    }
}
