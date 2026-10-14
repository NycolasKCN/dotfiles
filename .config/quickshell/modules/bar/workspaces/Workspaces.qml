import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland

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

    ToolSeparator {
        padding: 0
        spacing: 0
        visible: appName.visible
    }

    FocusedAppWidget {
        id: appName
        visible: true

        Layout.alignment: Qt.AlignVCenter
        Layout.maximumWidth: 300
        Layout.leftMargin: 4
    }
}
