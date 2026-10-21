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

    property bool centerOpened: true
    // {
    //    id,
    //    summary,
    //    appIcon,
    //    timestamp,
    //    urgency,
    //    body
    // }
    property list<JsonObject> history: []

    NotificationServer {
        id: server

        // Capabilities
        actionsSupported: true
        bodySupported: true
        imageSupported: true
        bodyMarkupSupported: true
        inlineReplySupported: false

        onNotification: n => {
            let notificationJson = {
                summary: n.summary,
                body: n.body,
                appName: n.appName,
                appIcon: n.appIcon,
                urgency: n.urgency,
                timestamp: Qt.formatDateTime(new Date(), "HH:mm")
            };
            root.history = [notificationJson, ...root.history];
            n.tracked = true;
        }
    }

    IpcHandler {
        target: "notifications"

        function toggle(): void {
            root.centerOpened = !root.centerOpened;
        }
    }

    NotificationArea {
        notifications: server.trackedNotifications
    }

    NotificationCenter {
        notifications: root.history
        visible: root.centerOpened
    }
}
