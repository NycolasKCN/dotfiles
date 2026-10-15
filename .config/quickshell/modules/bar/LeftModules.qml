import QtQuick
import QtQuick.Layouts
import "../../config.js" as Config
import "../components"
import "./components/workspaces"
import "./components/focusedApp"

RowLayout {
    spacing: Config.sizes.margin.normal
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
        Layout.leftMargin: Config.sizes.margin.small
    }
}
