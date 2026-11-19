import QtQuick
import QtQuick.Layouts
import qs.config
import qs.modules.components
import qs.modules.components.workspaces
import qs.modules.components.focusedApp

RowLayout {
    spacing: Config.sizes.margins.normal
    layoutDirection: Qt.LeftToRight

    Workspaces {}

    LineSeparator {
        Layout.alignment: Qt.AlignVCenter
        visible: appName.visible
    }

    FocusedAppWidget {
        id: appName

        Layout.alignment: Qt.AlignVCenter
        Layout.maximumWidth: 160
        Layout.leftMargin: Config.sizes.margins.small
    }
}
