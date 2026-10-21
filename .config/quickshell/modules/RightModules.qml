import QtQuick
import QtQuick.Layouts
import qs.config
import qs.modules
import qs.modules.components
import qs.modules.components.clock
import qs.modules.components.pipewire

RowLayout {
    spacing: Config.sizes.margin.large
    layoutDirection: Qt.RightToLeft

    ClockWidget {
        Layout.alignment: Qt.AlignVCenter
    }

    LineSeparator {
        Layout.alignment: Qt.AlignVCenter
    }

    AudioSink {
        Layout.alignment: Qt.AlignVCenter
    }

    AudioSource {
        Layout.alignment: Qt.AlignVCenter
    }
}
