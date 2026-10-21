import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import qs.modules.utils
import qs.config

Rectangle {
    id: root

    required property var n
    property string highlightColor: n.urgency === NotificationUrgency.Critical ? Config.colors.error : Config.colors.primary
    property bool isNotificationObject: isNotification(n)

    function isNotification(n) {
        return n !== null && n !== undefined
            && typeof n.summary === "string"
            && typeof n.dismiss === "function"
    }

    implicitHeight: content.implicitHeight + Config.sizes.margins.medium * 2
    radius: Config.sizes.radius.normal
    color: Config.colors.bg
    border {
        width: Config.sizes.border
        color: highlightColor
    }

    ColumnLayout {
        id: content
        anchors {
            fill: parent
            margins: Config.sizes.margins.medium
        }
        spacing: 2

        RowLayout {
            Layout.fillWidth: true

            Image {
                Layout.preferredHeight: 24
                Layout.preferredWidth: 24
                Layout.alignment: Qt.AlignLeft
                fillMode: Image.PreserveAspectFit
                visible: source.toString() !== ""
                source: root.n.image || root.n.appIcon || ""
            }

            Text {
                text: root.n.summary
                Layout.horizontalStretchFactor: 1
                Layout.fillWidth: true
                elide: Text.ElideRight
                color: root.highlightColor
                font: FontsMetrics.title.font
            }

            Text {
                visible: root.isNotificationObject
                text: root.n.timestamp
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                color: Config.colors.muted
                font: FontsMetrics.title.small
            }
        }

        Text {
            Layout.fillWidth: true

            text: root.n.body
            visible: text !== ""

            wrapMode: Text.Wrap
            textFormat: Text.StyledText
            color: Config.colors.fg
            font: FontsMetrics.normal.font
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.n.dismiss()
    }

    Timer {
        running: n.urgency !== NotificationUrgency.Critical
        interval: Config.notifications.timeout
        onTriggered: root.n.expire()
    }
}
