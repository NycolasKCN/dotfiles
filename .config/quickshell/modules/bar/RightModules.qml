import QtQuick
import QtQuick.Layouts
import "./components/clock"
import "../../config.js" as Config

RowLayout {
    spacing: Config.sizes.margin.normal
    layoutDirection: Qt.RightToLeft

    ClockWidget {}
}
