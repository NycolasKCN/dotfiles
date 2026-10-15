import QtQuick
import QtQuick.Layouts
import "../../../components"
import "../../../../config.js" as Config

RowLayout {
    spacing: 8

    Text {
        Layout.alignment: Qt.AlignVCenter

        color: Config.colors.primary
        font.weight: Config.fonts.weight.medium
        font.family: Config.fonts.primary
        font.pointSize: Config.fonts.size.small
        text: Time.weekDay
    }
    DotSeparator {
        Layout.alignment: Qt.AlignVCenter
    }
    Text {
        Layout.alignment: Qt.AlignVCenter

        color: Config.colors.foreground
        font.weight: Config.fonts.weight.medium
        font.family: Config.fonts.primary
        font.pointSize: Config.fonts.size.normal
        text: Time.time
    }
}
