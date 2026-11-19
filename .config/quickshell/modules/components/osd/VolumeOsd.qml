import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.config

Scope {
	id: root

	readonly property var audio: Pipewire.defaultAudioSink?.audio
	readonly property real volume: audio?.volume ?? 0
	readonly property bool muted: audio?.muted ?? false

	property bool ready: false

	onAudioChanged: {
		ready = false;
		settleTimer.restart();
	}

	Timer {
		id: settleTimer
		interval: 500
		running: true
		onTriggered: root.ready = true
	}

	PwObjectTracker { objects: [Pipewire.defaultAudioSink] }

	Connections {
		target: root.audio

		function onVolumeChanged() {
			if (!root.ready) return;
			osd.showBar = true;
			osd.show();
		}

		function onMutedChanged() {
			if (!root.ready) return;
			osd.showBar = false;
			osd.show();
		}
	}

	OsdPopup {
		id: osd
		value: root.muted ? 0 : root.volume
		maxValue: 1.0
		barColor: root.muted ? Config.colors.muted : Config.colors.fg
		icon: {
			if (root.muted) return "audio-volume-muted-symbolic";
			if (root.volume < 0.33) return "audio-volume-low-symbolic";
			if (root.volume < 0.66) return "audio-volume-medium-symbolic";
			return "audio-volume-high-symbolic";
		}
	}
}
