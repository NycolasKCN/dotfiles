import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.config
import qs.modules.components

Variants {
    model: Quickshell.screens.filter(screen => ["eDP-1", "DP-1"].includes(screen.name))

    PanelWindow {
        required property var modelData
        screen: modelData
        WlrLayershell.namespace: "quickshell:bar"

        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: modelData.height
        exclusiveZone: Config.bar.height
        color: "transparent"
        mask: Region {
            item: barBackground
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

        // Bar background
        Rectangle {
            id: barBackground
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            height: Config.bar.height
            color: Config.colors.bg

            // Bar Widgets
            Item {
                anchors {
                    fill: parent
                    leftMargin: Config.bar.leftMargin
                    rightMargin: Config.bar.rightMargin
                }

                LeftModules {
                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                }
                CenterModules {
                    anchors.centerIn: parent
                }
                RightModules {
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        // Corner decorations
        RoundCorner {
            corner: 0
            visible: Config.bar.corners.top
            anchors {
                top: barBackground.bottom
                left: parent.left
            }
        }
        RoundCorner {
            corner: 1
            visible: Config.bar.corners.top
            anchors {
                top: barBackground.bottom
                right: parent.right
            }
        }
        RoundCorner {
            corner: 3
            visible: Config.bar.corners.bottom
            anchors {
                bottom: parent.bottom
                left: parent.left
            }
        }
        RoundCorner {
            corner: 2
            visible: Config.bar.corners.bottom
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
        }
    }
    }
