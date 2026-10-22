import Quickshell.Services.Notifications
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
        notifications: NotificationState.notClosed
        visible: NotificationState.isCenterOpen
    }

    Component {
        id: notifComp
        NotificationData {}
    }
}
