import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import qs.config

QtObject {
    id: notificationData

    property bool isPopupOpen
    property bool isClosed
    property date time: new Date()

    property Notification notification

    property real expireTimeout: Config.notifications.timeout
    property int notificationId
    property string summary
    property string body
    property string appIcon
    property string image
    property string urgency
    property string desktopEntry
    property string appName
    property bool resident
    property bool hasActionIcons
    property list<var> actions

    readonly property Connections conn: Connections {
        function onClosed(): void {
            notificationData.close();
        }

        function onSummaryChanged(): void {
            notificationData.summary = notificationData.notification.summary;
        }

        function onBodyChanged(): void {
            notificationData.body = notificationData.notification.body;
        }

        function onAppIconChanged(): void {
            notificationData.appIcon = notificationData.notification.appIcon;
        }

        function onAppNameChanged(): void {
            notificationData.appName = notificationData.notification.appName;
        }

        function onImageChanged(): void {
            notificationData.image = notificationData.notification.image;
        }

        function onExpireTimeoutChanged(): void {
            notificationData.expireTimeout = notificationData.notification.expireTimeout;
        }

        function onUrgencyChanged(): void {
            notificationData.urgency = notificationData.notification.urgency;
        }

        function onResidentChanged(): void {
            notificationData.resident = notificationData.notification.resident;
        }

        function onHasActionIconsChanged(): void {
            notificationData.hasActionIcons = notificationData.notification.hasActionIcons;
        }

        function onActionsChanged(): void {
            notificationData.actions = (notificationData.notification.actions as Array).map(a => ({
                        identifier: a.identifier,
                        text: a.text,
                        invoke: () => a.invoke()
                    }));
        }

        function onHintsChanged(): void {
            notificationData.hints = notificationData.notification.hints;
        }

        target: notificationData.notification
    }

    readonly property Timer timer: Timer {
        running: notificationData.isPopupOpen && notificationData.urgency != NotificationUrgency.Critical
        interval: notificationData.expireTimeout > 0 ? notificationData.expireTimeout : Config.notifications.timeout
        onTriggered: {
            notificationData.isPopupOpen = false;
        }
    }

    function closePopup() {
        notificationData.isPopupOpen = false;
    }

    function close(): void {
        notificationData.isClosed = true;
        if (NotificationState.hasNotification(this)) {
            NotificationState.removeNotification(this);
            notification?.dismiss();
            destroy();
        }
    }

    Component.onCompleted: {
        if (!notification)
            return;

        notificationId = notification.id;
        summary = notification.summary;
        body = notification.body;
        appIcon = notification.appIcon;
        appName = notification.appName;
        image = notification.image;
        expireTimeout = notification.expireTimeout;
        urgency = notification.urgency;
        resident = notification.resident;
        hasActionIcons = notification.hasActionIcons;

        actions = (notification.actions as Array).map(a => ({
                    identifier: a.identifier,
                    text: a.text,
                    invoke: () => a.invoke()
                }));
    }
}
