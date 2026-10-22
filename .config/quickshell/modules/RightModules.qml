import QtQuick
import QtQuick.Layouts
import qs.config
import qs.modules
import qs.modules.components
import qs.modules.components.clock
import qs.modules.components.pipewire
import qs.modules.components.notifications

RowLayout {
    spacing: Config.sizes.margins.large
    layoutDirection: Qt.RightToLeft

    ClockWidget {
        Layout.alignment: Qt.AlignVCenter
    }

    NotificationWidget {
        Layout.alignment: Qt.AlignCenter
        Layout.leftMargin: -2
        Layout.rightMargin: -2
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
