//@ pragma UseQApplication

import QtQuick
import Quickshell
import qs.modules
import qs.modules.components.notifications

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
}
