import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.config

Scope {
    id: root

    property real value: 0
    property real maxValue: 100
    property string icon: ""
    property int timeout: 1200
    property bool showBar: true

    property bool overflowWrap: true

    property int barWidth: 380
    property int barHeight: 32
    property int innerBarHeight: 18
    property int iconSize: 20
    property int paddingX: 14
    property int gap: 10
    property real borderSize: Config.sizes.border
    property real cornerRadius: barHeight / 2

    property bool atTop: false
    property bool atBottom: true
    property bool atLeft: false
    property bool atRight: false
    property int margin: 24

    property color backgroundColor: Config.colors.bg
    property color borderColor: Qt.lighter(Config.colors.bg, 3)
    property color trackColor: Qt.lighter(Config.colors.bg, 4)
    property color barColor: Config.colors.fg

    property color overflowBackgroundColor: backgroundColor
    property color overflowBorderColor: borderColor
    property color overflowTrackColor: trackColor
    property color overflowBarColor: Config.colors.error

    property bool shown: false

    readonly property real ratio: maxValue > 0 ? value / maxValue : 0
    readonly property bool wrapped: showBar && overflowWrap && ratio > 1
    readonly property real fillRatio: {
        if (ratio > 1)
            return overflowWrap ? Math.min(ratio - 1, 1) : 1;
        return Math.max(ratio, 0);
    }

    function show() {
        shown = true;
        hideTimer.restart();
    }

    function hide() {
        shown = false;
        hideTimer.stop();
    }

    Timer {
        id: hideTimer
        interval: root.timeout
        onTriggered: root.shown = false
    }

    LazyLoader {
        active: root.shown

        PanelWindow {
            anchors {
                top: root.atTop
                bottom: root.atBottom
                left: root.atLeft
                right: root.atRight
            }
            margins {
                top: root.margin
                bottom: root.margin
                left: root.margin
                right: root.margin
            }
            exclusiveZone: 0

            implicitWidth: root.showBar ? root.barWidth : root.barHeight
            implicitHeight: root.barHeight
            color: "transparent"
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: root.cornerRadius
                color: root.wrapped ? root.overflowBackgroundColor : root.backgroundColor
                border.width: root.borderSize
                border.color: root.wrapped ? root.overflowBorderColor : root.borderColor

                // Sem margem vertical: ícone e trilha se centralizam sozinhos na altura.
                // Só há margem horizontal, e só no modo com barra.
                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: root.showBar ? root.paddingX : 0
                        rightMargin: root.showBar ? root.paddingX : 0
                    }
                    spacing: root.gap

                    IconImage {
                        visible: root.icon !== ""
                        Layout.alignment: Qt.AlignCenter
                        implicitSize: root.iconSize
                        source: root.icon !== "" ? Quickshell.iconPath(root.icon) : ""
                    }

                    Rectangle {
                        visible: root.showBar
                        Layout.fillWidth: true
                        Layout.preferredHeight: root.innerBarHeight
                        Layout.alignment: Qt.AlignVCenter
                        radius: height / 2
                        color: root.wrapped ? root.overflowTrackColor : root.trackColor

                        Rectangle {
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }
                            width: parent.width * root.fillRatio
                            radius: parent.radius
                            color: root.wrapped ? root.overflowBarColor : root.barColor
                        }
                    }
                }
            }
        }
    }
}
