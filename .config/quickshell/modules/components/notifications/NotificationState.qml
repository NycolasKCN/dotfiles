// NotificationState.qml
pragma Singleton
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Singleton {
    id: state
    // ------------ Notification history
    property list<NotificationData> list: []
    readonly property list<NotificationData> notClosed: list.filter(n => !n.isClosed)
    readonly property list<NotificationData> popups: list.filter(n => n.isPopupOpen)

    function removeNotification(n): void {
        list = list.filter(notif => notif !== n);
    }

    function add(n): void {
        list = [n, ...list];
    }

    function hasNotification(n): bool {
        return list.includes(n);
    }

    function hasNotifications(): bool {
        return list.length > 0;
    }

    function clearHistory(): void {
        for (const notif of list.slice())
            notif.close();
    }

    // ------------ Notification state properties
    PersistentProperties {
        id: persist
        reloadableId: "persistedNotifStates"
        property bool isCenterOpen: false
        property bool dnd: false
    }
    property alias isCenterOpen: persist.isCenterOpen
    property alias dnd: persist.dnd

    function toggle_center() {
        persist.isCenterOpen = !persist.isCenterOpen;
    }

    function toggle_dnd() {
        persist.dnd = !persist.dnd;
    }

    function shouldShowPopup() {
        if (persist.dnd || persist.isCenterOpen)
            return false;
        if (hasFullscreen())
            return false;
        return true;
    }

    function hasFullscreen(): bool {
        for (const monitor of Hyprland.monitors.values) {
            if (monitor?.activeWorkspace?.toplevels.values.some(t => t.lastIpcObject.fullscreen > 1))
                return true;
        }
        return false;
    }

    IpcHandler {
        target: "notifications"

        function toggle(): void {
            state.toggle_center();
        }

        function toggleDnd(): void {
            state.toggle_dnd();
        }
    }
}
