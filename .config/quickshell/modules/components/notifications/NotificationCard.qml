import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import qs.modules.utils
import qs.config

Rectangle {
    id: root

    required property NotificationData n
    property string highlightColor: n.urgency == NotificationUrgency.Critical ? Config.colors.error : Config.colors.primary

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
                text: Qt.formatDateTime(n.time, "HH:mm")
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
        onClicked: {
            if (root.n.isPopupOpen) {
                root.n.closePopup()
            } else {
                root.n.close()
            }
        }
    }
}
