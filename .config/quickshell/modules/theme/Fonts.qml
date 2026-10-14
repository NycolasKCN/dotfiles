pragma Singleton
import QtQuick

QtObject {
    component Sizes: QtObject {
        readonly property int verySmall: 9
        readonly property int small: 10
        readonly property int normal: 11
        readonly property int big: 13
    }

    component Weights: QtObject {
        readonly property int medium: 600
        readonly property int bold: 700
    }

    readonly property string primary: "NotoSans Nerd Font"
    readonly property string secondary: "Inter"

    readonly property Sizes size: Sizes {}
    readonly property Weights weight: Weights {}
}
