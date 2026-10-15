import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../../../config.js" as Config

RowLayout {
    id: workspacesRow
    spacing: Config.sizes.margin.normal

    Repeater {
        model: Hyprland.workspaces

        WorkspaceButton {
            required property var modelData
            workspace: modelData
        }
    }

}
