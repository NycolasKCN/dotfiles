import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
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

    implicitWidth: Config.notifications.width
    implicitHeight: column.implicitHeight
    visible: root.notifications.length > 0
    color: "transparent"
    exclusionMode: ExclusionMode.Auto
    WlrLayershell.namespace: "quickshell:notification_area"

    ColumnLayout {
        id: column
        width: parent.width
        spacing: Config.sizes.margins.small

        Repeater {
            model: root.notifications

            NotificationCard {
                Layout.fillWidth: true
                required property NotificationData modelData
                n: modelData
            }
        }
    }
}
