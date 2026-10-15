// Time.qml
pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property string time: {
    Qt.formatDateTime(clock.date, "hh:mm")
  }

  readonly property string weekDay: {
    Qt.formatDateTime(clock.date, "ddd dd MMM")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
