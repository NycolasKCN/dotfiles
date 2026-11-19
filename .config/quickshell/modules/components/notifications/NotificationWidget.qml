import QtQuick
import Quickshell
import qs.config
import qs.modules.components.notifications

MouseArea {
    id: root
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    Text {
        id: label
        anchors.centerIn: parent
        font.family: Config.fonts.primary
        font.pointSize: Config.fonts.size.small
        color: Config.colors.primary
        text: {
            if (NotificationState.dnd) {
                return Config.notifications.icons.dnd;
            }
            return NotificationState.hasNotifications() ? Config.notifications.icons.notification : Config.notifications.icons.def;
        }
    }

    onClicked: mouse => {
        if (mouse.button == Qt.LeftButton) {
            NotificationState.toggle_dnd();
        } else if (mouse.button == Qt.RightButton) {
            NotificationState.toggle_center();
        }
    }
}
