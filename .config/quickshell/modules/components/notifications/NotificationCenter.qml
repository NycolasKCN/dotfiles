import Quickshell
import Quickshell.Wayland
import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import qs.modules.utils
import qs.modules.components
import qs.config

PanelWindow {
    id: root
    required property list<NotificationData> notifications

    anchors {
        right: true
        top: true
    }
    margins {
        right: Config.sizes.margins.medium
        top: Config.sizes.margins.medium
    }

    implicitWidth: Config.notifications.centerWidth
    implicitHeight: Math.min(column.implicitHeight + 20, Config.notifications.centerHeight)
    exclusionMode: ExclusionMode.Auto
    color: "transparent"
    WlrLayershell.namespace: "quickshell:notification_center"

    // Background
    Rectangle {
        anchors.fill: parent
        color: Config.colors.bg
        radius: Config.sizes.radius.big
        border {
            color: Qt.lighter(Config.colors.bg, 3)
            width: 0.5
        }
    }

    ColumnLayout {
        id: column
        anchors.fill: parent
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
                        NotificationState.clearHistory();
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
            Layout.leftMargin: Config.sizes.margins.big
            Layout.rightMargin: Config.sizes.margins.big
            Layout.bottomMargin: Config.sizes.margins.big
            Layout.alignment: Qt.AlignCenter
            font: FontsMetrics.title.font
            color: Config.colors.muted
            text: "No notifications"

            visible: root.notifications.length === 0
        }

        // Content
        ListView {
            id: list
            visible: root.notifications.length > 0
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: contentHeight
            Layout.leftMargin: Config.sizes.margins.big
            Layout.rightMargin: Config.sizes.margins.big
            // Layout.bottomMargin: Config.sizes.margins.big

            clip: true
            spacing: Config.sizes.margins.normal
            boundsBehavior: Flickable.StopAtBounds
            model: root.notifications

            delegate: NotificationCard {
                required property NotificationData modelData
                width: ListView.view.width
                n: modelData
            }
        }
    }
}
