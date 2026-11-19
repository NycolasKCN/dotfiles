import Quickshell
import QtQuick
import QtQuick.Controls
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

    // Tooltip
    property bool tooltipVisible: false
    readonly property string nodeName: node !== null ? (node.nickname || node.description || node.name) : ""

    PwObjectTracker {
        objects: root.node !== null ? [root.node] : []
    }

    Timer {
        id: showTimer
        interval: 400
        onTriggered: root.tooltipVisible = true
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

    // Linha reutilizável do tooltip: ícone + texto
    component InfoRow: RowLayout {
        property string glyph
        property string label
        property color glyphColor: Config.colors.fg

        spacing: Config.sizes.margins.small

        Text {
            text: parent.glyph
            color: parent.glyphColor
            font: FontsMetrics.normal.font
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: 20
        }

        Text {
            text: parent.label
            color: Config.colors.fg
            font: FontsMetrics.normal.font
            elide: Text.ElideRight
            Layout.maximumWidth: 260
        }
    }

    PopupWindow {
        id: tooltip
        visible: root.tooltipVisible && root.ready
        color: "transparent"

        anchor.item: root
        anchor.edges: Edges.Bottom      // use Edges.Top se a barra estiver embaixo
        anchor.gravity: Edges.Bottom    // idem

        implicitWidth: card.implicitWidth
        implicitHeight: card.implicitHeight + 6

        Rectangle {
            id: card
            y: 6    // pequeno respiro entre a barra e o tooltip
            color: Config.colors.bg     // ajuste para o nome da sua cor de fundo
            radius: 6
            border.width: 1
            border.color: Qt.alpha(Config.colors.fg, 0.15)

            implicitWidth: col.implicitWidth + Config.sizes.margins.small * 4
            implicitHeight: col.implicitHeight + Config.sizes.margins.small * 4

            ColumnLayout {
                id: col
                anchors.centerIn: parent
                spacing: Config.sizes.margins.small

                // 1) Nome do dispositivo (alto-falante p/ saída, microfone p/ entrada)
                InfoRow {
                    glyph: root.node.isSink ? Config.icons.pipewire.volume.medium : Config.icons.pipewire.mic.unmuted
                    label: root.nodeName
                }

                // 2) Volume atual
                InfoRow {
                    glyph: root.getIcon(root.percent, root.muted)
                    label: root.percent + "%"
                }
            }
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onContainsMouseChanged: {
            if (containsMouse) {
                showTimer.restart();
            } else {
                showTimer.stop();
                root.tooltipVisible = false;
            }
        }

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
