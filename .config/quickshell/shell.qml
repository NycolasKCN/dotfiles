//@ pragma UseQApplication

import QtQuick
import Quickshell
import qs.modules

ShellRoot {
    id: shellRoot

    // Status Bar
    Loader {
        active: true
        sourceComponent: Bar {}
    }
}
