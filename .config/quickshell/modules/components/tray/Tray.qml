import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.modules.utils
import qs.config

WrapperRectangle {
    id: root
    resizeChild: false
    color: Config.colors.bg

    property bool isOpen: false
    property bool menuOpen: false
    property string trayIcon: SystemTray.items.values.length > 0 ? Config.icons.tray.full : Config.icons.tray.empty

    function toggleTray(): void {
        isOpen = !isOpen;
    }

    // ---- bar icon ----
    Text {
        id: icon
        text: root.trayIcon
        font: FontsMetrics.title.font
        color: Config.colors.fg

        MouseArea {
            anchors.fill: parent

            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: root.toggleTray()
        }

        // ---- drawer ----
        PopupWindow {
            id: drawer
            // continua visível durante a animação de fechar
            visible: root.isOpen || card.opacity > 0
            color: "transparent"

            anchor.item: root
            anchor.edges: Edges.Bottom      // use Edges.Top se a barra estiver embaixo
            anchor.gravity: Edges.Bottom    // idem

            implicitWidth: card.implicitWidth
            implicitHeight: card.implicitHeight + 6

            WrapperRectangle {
                id: card
                y: root.isOpen ? 6 : 0      // desliza um pouco para baixo ao abrir
                opacity: root.isOpen ? 1 : 0
                margin: Config.sizes.margins.small * 2

                color: Config.colors.bg
                radius: 6
                border.width: Config.sizes.border 
                border.color: Qt.lighter(Config.colors.bg, 3)

                Behavior on opacity {
                    NumberAnimation {
                        duration: 130
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on y {
                    NumberAnimation {
                        duration: 130
                        easing.type: Easing.OutCubic
                    }
                }

                Row {
                    spacing: Config.sizes.margins.large

                    Repeater {
                        model: SystemTray.items

                        WrapperMouseArea {
                            id: delegate
                            required property SystemTrayItem modelData

                            acceptedButtons: Qt.LeftButton | Qt.RightButton

                            onClicked: event => {
                                if (event.button === Qt.LeftButton)
                                    modelData.activate();
                                else if (event.button === Qt.RightButton && modelData.hasMenu)
                                    menu.open();
                                event.accepted = true;
                            }

                            IconImage {
                                id: itemIcon
                                source: delegate.modelData.icon
                                implicitSize: 18
                            }

                            QsMenuAnchor {
                                id: menu
                                menu: delegate.modelData.menu
                                onVisibleChanged: {
                                    root.menuOpen = visible;
                                    // QsWindow.window.inhibitGrab = visible;
                                }
                                anchor {
                                    item: itemIcon
                                    edges: Edges.Left | Edges.Bottom
                                    gravity: Edges.Right | Edges.Bottom
                                    adjustment: PopupAdjustment.FlipX
                                }
                            }
                        }
                    }
                }
            }
            HyprlandFocusGrab {
                windows: [drawer]
                active: root.isOpen && !root.menuOpen
                onCleared: root.isOpen = false
            }
        }
    }
}
