import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../time"
import "./workspaces"
import "../theme"

Variants {
    model: Quickshell.screens.filter(screen => ["eDP-1", "DP-1"].includes(screen.name))

    PanelWindow {
        required property var modelData
        screen: modelData
        WlrLayershell.namespace: "bar"

        implicitHeight: 30
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
                    // spacer
                    Layout.fillWidth: true
                }

                ClockWidget {
                    Layout.alignment: Qt.AlignCenter
                    Layout.rightMargin: 16

                    color: Colors.foreground
                    font.weight: Fonts.mediumWeight
                    font.family: Fonts.primary
                }
            }
        }
    }
}
