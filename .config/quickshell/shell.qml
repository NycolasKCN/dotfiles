//@ pragma UseQApplication

import QtQuick
import Quickshell
import qs.modules
import qs.modules.components.notifications
import qs.modules.components.osd

ShellRoot {
    id: shellRoot

    // Status Bar
    Loader {
        active: true
        sourceComponent: Bar {}
    }

    Loader {
        active: true
        sourceComponent: NotificationManager {}
    }

    Loader {
        active: true
        sourceComponent: Osd {}
    }
}
