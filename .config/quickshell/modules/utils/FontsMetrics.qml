pragma Singleton

import QtQuick
import qs.config

QtObject {
    readonly property FontMetrics normal: FontMetrics {
        id: fm
        font.family: Config.fonts.primary
        font.pointSize: Config.fonts.size.small
        font.weight: Config.fonts.weight.medium
    }
}
