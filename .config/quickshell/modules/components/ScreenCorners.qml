import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config

PanelWindow {
    id: root
    property int barHeight: Config.sizes.bar.height

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Top
    mask: Region {}

    // top left
    RoundCorner {
        corner: 0
        anchors {
            top: parent.top
            left: parent.left
            topMargin: root.barHeight
        }
    }

    // top right
    RoundCorner {
        corner: 1
        anchors {
            top: parent.top
            right: parent.right
            topMargin: root.barHeight
        }
    }
    // bottom left
    RoundCorner {
        corner: 3
        anchors {
            bottom: parent.bottom
            left: parent.left
        }
    }

    // bottom right
    RoundCorner {
        corner: 2
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
    }
}
