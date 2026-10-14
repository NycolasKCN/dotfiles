pragma Singleton
import QtQuick

QtObject {
    component BarSizes: QtObject {
        property int height: 28
        property int width: 1000
    }

    component RadiusSizes: QtObject {
        property int small: 4
        property int medium: 6
        property int normal: 8
    }

    component Margins: QtObject {
        property int small: 4
        property int normal: 6
        property int medium: 8
        property int big: 16
    }

    property BarSizes bar: BarSizes {}
    property Margins margin: Margins {}
    property RadiusSizes radius: RadiusSizes {}
}
