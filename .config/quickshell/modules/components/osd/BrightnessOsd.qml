import QtQuick
import Quickshell
import Quickshell.Io

Scope {
	id: root
	property real percent: 0

	IpcHandler {
		target: "brightness"
		function set(percent: int): void {
			root.percent = percent;
			osd.show();
		}
	}

	OsdPopup {
		id: osd
		value: root.percent
		maxValue: 100
		icon: "display-brightness-symbolic"
		barColor: "#ffb84d"
	}
}
