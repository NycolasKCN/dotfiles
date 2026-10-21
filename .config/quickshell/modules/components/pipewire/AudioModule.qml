import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.config
import qs.modules.utils

Rectangle {
    id: root
    color: "transparent"
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    required property PwNode node
    required property var getIcon
    property bool showPercentage: true
    property string controlCommand: ""

    readonly property bool ready: node !== null && node.ready && node.audio !== null
    readonly property PwNodeAudio audioInfo: ready ? node.audio : null
    readonly property real level: ready ? node.audio.volume : 0
    readonly property bool muted: ready ? node.audio.muted : false
    readonly property int percent: Math.round(level * 100)

    PwObjectTracker {
        objects: root.node !== null ? [root.node] : []
    }

    function setVolume(v: real): void {
        if (!ready)
            return;
        node.audio.volume = Math.max(0, Math.min(1, v));
    }

    function step(dir: int): void {
        setVolume((dir * Config.volume.stepSize) + level);
    }

    function toggleMute(): void {
        if (ready)
            node.audio.muted = !node.audio.muted;
    }

    function execControlCommand() {
        if (controlCommand !== "")
            Quickshell.execDetached(["bash", "-c", root.controlCommand]);
    }

    RowLayout {
        id: row
        anchors.right: parent.right
        spacing: Config.sizes.margins.small
        anchors.verticalCenter: parent.verticalCenter
        layoutDirection: Qt.RightToLeft

        // Label
        Text {
            text: root.percent
            visible: root.showPercentage

            Layout.preferredWidth: FontsMetrics.normal.advanceWidth(root.percent)
            horizontalAlignment: Text.AlignRight

            color: Config.colors.fg
            font: FontsMetrics.normal.font
        }

        // Icon
        Text {
            text: root.getIcon(root.percent, root.muted)
            horizontalAlignment: Text.AlignLeft

            color: Config.colors.fg
            font: FontsMetrics.normal.font
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: event => {
            switch (event.button) {
            case Qt.LeftButton:
                root.toggleMute();
                break;
            case Qt.RightButton:
                root.execControlCommand();
                break;
            }
        }

        onWheel: event => root.step(event.angleDelta.y > 0 ? 1 : -1)
    }
}
