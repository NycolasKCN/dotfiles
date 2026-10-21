import Quickshell
import Quickshell.Wayland
import QtQuick.Layouts
import QtQuick
import qs.modules.utils
import qs.modules.components
import qs.config

PanelWindow {
    id: root
    required property var notifications

    anchors {
        right: true
        top: true
    }
    margins {
        right: Config.sizes.margins.medium
        top: Config.sizes.margins.medium
    }

    implicitWidth: Config.notifications.centerWidth
    implicitHeight: column.implicitHeight + 20
    visible: root.notifications.values.length > 0
    exclusionMode: ExclusionMode.Auto
    color: "transparent"
    WlrLayershell.namespace: "quickshell:notification_center"

    // Background
    Rectangle {
        anchors.fill: parent
        color: Config.colors.bg
        radius: Config.sizes.radius.big
    }

    ColumnLayout {
        id: column
        width: parent.width
        spacing: Config.sizes.margins.normal

        // 'Notifications' text and Clear all button
        RowLayout {
            Layout.topMargin: Config.sizes.margins.big
            Layout.leftMargin: Config.sizes.margins.big
            Layout.rightMargin: Config.sizes.margins.big

            Text {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                color: Config.colors.primary

                font: FontsMetrics.title.font
                text: "Notifications"
            }

            Text {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                text: "clear"
                font: FontsMetrics.small.font
                color: Config.colors.muted

                visible: root.notifications.length !== 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: () => {
                        console.log('clear all notifications');
                    }
                }
            }
        }

        HLineSeparator {
            Layout.leftMargin: Config.sizes.margins.big
            Layout.rightMargin: Config.sizes.margins.big
            Layout.fillWidth: true
        }

        Text {
            Layout.margins: Config.sizes.margins.big
            Layout.alignment: Qt.AlignCenter
            font: FontsMetrics.title.font
            color: Config.colors.muted
            text: "No notifications"

            visible: root.notifications.length === 0
        }

        Repeater {
            model: root.notifications

            NotificationCard {
                Layout.margins: Config.sizes.margins.big
                Layout.fillWidth: true
                required property var modelData
                n: modelData
            }
        }
    }
}
