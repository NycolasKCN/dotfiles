import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.components
import qs.config

RowLayout {
    id: root
    spacing: Config.sizes.margin.small

    readonly property var time: {
        Qt.formatDateTime(clock.date, "hh:mm");
    }

    readonly property var weekDay: {
        Qt.formatDateTime(clock.date, "ddd dd MMM");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
    Text {
        Layout.alignment: Qt.AlignCenter

        color: Config.colors.primary
        font.weight: Config.fonts.weight.medium
        font.family: Config.fonts.primary
        font.pointSize: Config.fonts.size.small
        text: root.weekDay
    }

    DotSeparator {
        Layout.alignment: Qt.AlignVCenter
    }

    Text {
        Layout.alignment: Qt.AlignCenter
        Layout.leftMargin: 1

        color: Config.colors.foreground
        font.weight: Config.fonts.weight.medium
        font.family: Config.fonts.primary
        font.pointSize: Config.fonts.size.normal
        text: root.time
    }
}
