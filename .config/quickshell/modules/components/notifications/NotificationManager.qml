import Quickshell.Services.Notifications
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell
import QtQuick

// NOTIFICATION TODO'S
// TODO: Add DND
// TODO: Add button for actions
// FIX: new notifications show on top of the center

Scope {
    id: root

    NotificationServer {
        id: server

        // Capabilities
        bodySupported: true
        imageSupported: true
        bodyMarkupSupported: true
        actionsSupported: true
        inlineReplySupported: false

        onNotification: notif => {
            notif.tracked = true;

            const comp = notifComp.createObject(root, {
                isPopupOpen: NotificationState.shouldShowPopup(),
                notification: notif
            });
            NotificationState.add(comp);

            console.log(comp);
            console.log("Lista: ", NotificationState.list);
            console.log("Popup: ", NotificationState.popups);
        }
    }

    NotificationArea {
        notifications: NotificationState.popups
        visible: !NotificationState.isCenterOpen
    }

    NotificationCenter {
        id: notificationCenter

        notifications: NotificationState.notClosed
        visible: NotificationState.isCenterOpen
        HyprlandFocusGrab {
            windows: [notificationCenter]
            active: NotificationState.isCenterOpen
            onCleared: {
                NotificationState.toggle_center();
            }
        }
    }

    Component {
        id: notifComp
        NotificationData {}
    }
}
