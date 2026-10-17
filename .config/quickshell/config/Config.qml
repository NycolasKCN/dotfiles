pragma Singleton

import QtQuick

QtObject {
    id: root
    readonly property QtObject colors: QtObject {
        readonly property string primary: "#9DCBFB"
        readonly property string secondary: "#B9C8DA"
        readonly property string terciary: "#C8B7DD"
        readonly property string error: "#FFB4AB"
        readonly property string background: "#070808"
        readonly property string foreground: "#FAFAFA"
    }

    readonly property QtObject fonts: QtObject {
        readonly property string primary: "NotoSans Nerd Font"
        readonly property string secondary: "Inter"
        readonly property QtObject size: QtObject {
            readonly property int verySmall: 9
            readonly property int small: 10
            readonly property int normal: 11
            readonly property int big: 13
        }
        readonly property QtObject weight: QtObject {
            readonly property int medium: 600
            readonly property int bold: 700
        }
    }

    readonly property QtObject sizes: QtObject {
        readonly property QtObject bar: QtObject {
            readonly property int height: 28
            readonly property int width: 1000
            readonly property int leftMargin: 24
            readonly property int rightMargin: 24
        }
        readonly property QtObject radius: QtObject {
            readonly property int small: 4
            readonly property int medium: 6
            readonly property int normal: 8
        }
        readonly property QtObject margin: QtObject {
            readonly property int none: 0
            readonly property int small: 4
            readonly property int normal: 6
            readonly property int medium: 8
            readonly property int large: 10
            readonly property int big: 16
        }
        readonly property QtObject modules: QtObject {
            readonly property QtObject normal: QtObject {
                readonly property int width: 26
                readonly property int height: 24
            }
        }
    }

    readonly property QtObject icons: QtObject {
        readonly property var workspaces: ({
                "1": "一",
                "2": "二",
                "3": "三",
                "4": "四",
                "5": "五",
                "6": "六",
                "7": "七",
                "8": "八",
                "9": "九",
                "10": "十",
                "special:notes": "󰺿",
                "special:music": "",
                "special:terminal": "",
                "special:magic": "",
                "special:magic2": ""
            })

        readonly property QtObject pipewire: QtObject {
            readonly property QtObject volume: QtObject {
                readonly property string off: ""
                readonly property string low: ""
                readonly property string medium: "\uefcf"
                readonly property string high: ""
                readonly property string muted: ""
            }
            readonly property QtObject mic: QtObject {
                readonly property string unmuted: ""
                readonly property string muted: ""
            }
        }
        readonly property QtObject notification: QtObject {
            readonly property string def: "󰂚"
            readonly property string notification: "󱅫"
            readonly property string danger: "󰵙"
            readonly property string dnd: "󰂛"
        }
        readonly property string controlCenter: ""

        function workspace(name, fallback) {
            return this.workspaces[name] ?? fallback;
        }

        function volumeIcon(volume, muted) {
            const v = root.icons.pipewire.volume;

            if (muted)
                return v.muted;
            if (volume === 0)
                return v.off;
            if (volume < 34)
                return v.low;
            if (volume < 67)
                return v.medium;
            return v.high;
        }

        function micIcon(_, muted) {
            const v = root.icons.pipewire.mic;
            return muted ? v.muted : v.unmuted;
        }
    }

    readonly property QtObject volume: QtObject {
        readonly property real stepSize: 0.02
        readonly property bool showMicPercentage: false

        readonly property QtObject commands: QtObject {
            readonly property string openSinkControl: "pavucontrol -t 3"
            readonly property string openSourceControl: "pavucontrol -t 4"
        }
    }
}
