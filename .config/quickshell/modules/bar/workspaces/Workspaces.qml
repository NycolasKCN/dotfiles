import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../theme"
import "../../theme/components"

RowLayout {
    id: workspacesRow
    spacing: 6

    Repeater {
        model: Hyprland.workspaces

        WorkspaceButton {
            required property var modelData
            workspace: modelData
        }
    }

    LineSeparator {
        Layout.alignment: Qt.AlignVCenter
        visible: appName.visible
    }

    FocusedAppWidget {
        id: appName
        visible: false

        Layout.alignment: Qt.AlignVCenter
        Layout.maximumWidth: 160
        Layout.leftMargin: Sizes.margin.small
    }
}
