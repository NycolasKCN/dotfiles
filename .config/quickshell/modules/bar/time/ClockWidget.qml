import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../../theme/components"
import "../../theme"

RowLayout {
    spacing: 8
    Text {
        Layout.alignment: Qt.AlignVCenter

        color: Colors.foreground
        font.weight: Fonts.weight.medium
        font.family: Fonts.primary
        font.pointSize: Fonts.size.normal
        text: Time.time
    }

    DotSeparator {
        Layout.alignment: Qt.AlignVCenter
    }

    Text {
        Layout.alignment: Qt.AlignVCenter

        color: Colors.primary
        font.weight: Fonts.weight.medium
        font.family: Fonts.primary
        font.pointSize: Fonts.size.small
        text: Time.weekDay
    }
}
