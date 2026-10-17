import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.config
import qs.modules.components

Variants {
    model: Quickshell.screens.filter(screen => ["eDP-1", "DP-1"].includes(screen.name))
    // Bar
    PanelWindow {
        required property var modelData
        screen: modelData
        WlrLayershell.namespace: "bar"

        implicitHeight: Config.sizes.bar.height
        color: Config.colors.background
        anchors {
            top: true
            left: true
            right: true
        }

        // Bottom border
        // Rectangle {
        //     anchors {
        //         left: parent.left
        //         right: parent.right
        //         bottom: parent.bottom
        //     }
        //     height: 1
        //     color: Config.colors.primary
        // }

        // Bar Widgets
        Item {
            anchors {
                fill: parent
                leftMargin: Config.sizes.bar.leftMargin
                rightMargin: Config.sizes.bar.rightMargin
            }

            LeftModules {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
            }
            CenterModules {
                anchors {
                    centerIn: parent
                }
            }
            RightModules {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        // Corner decorations
        ScreenCorners {}
    }
}
