import QtQuick
import QtQuick.Shapes
import qs.config

Item {
    id: root
    
    property int corner: 0
    property int radius: 24
    property color color: Config.colors.background

    implicitWidth: radius
    implicitHeight: radius
    rotation: corner * 90

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            strokeWidth: 0
            fillColor: root.color
            startX: 0; startY: 0
            PathLine { x: root.radius; y: 0 }
            PathArc {
                x: 0; y: root.radius
                radiusX: root.radius; radiusY: root.radius
                direction: PathArc.Counterclockwise
            }
            PathLine { x: 0; y: 0 }
        }
    }
}
