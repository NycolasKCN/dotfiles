pragma Singleton

import QtQuick
import qs.config

QtObject {
    readonly property FontMetrics normal: FontMetrics {
        font.family: Config.fonts.primary
        font.pointSize: Config.fonts.size.small
        font.weight: Config.fonts.weight.medium
    }

    readonly property FontMetrics title: FontMetrics {
        font.family: Config.fonts.primary
        font.pointSize: Config.fonts.size.normal
        font.bold: true
    }

    readonly property FontMetrics small: FontMetrics {
        font.family: Config.fonts.primary
        font.pointSize: Config.fonts.size.verySmall - 1
        font.weight: Config.fonts.weight.medium
    }
}
