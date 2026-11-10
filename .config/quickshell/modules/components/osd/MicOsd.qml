import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.config

Scope {
	id: root

	readonly property var audio: Pipewire.defaultAudioSource?.audio
	readonly property real volume: audio?.volume ?? 0
	readonly property bool muted: audio?.muted ?? false

	// Sem o tracker o volume/mute do source não é atualizado
	PwObjectTracker { objects: [Pipewire.defaultAudioSource] }

	Connections {
		target: root.audio

		function onVolumeChanged() {
			osd.show();
		}

		function onMutedChanged() {
			osd.show();
		}
	}

	OsdPopup {
		id: osd
		value: root.volume
		maxValue: 1.0
		barColor: root.muted ? Config.colors.muted : Config.colors.primary
		icon: root.muted
			? "microphone-sensitivity-muted-symbolic"
			: "microphone-sensitivity-high-symbolic"
	}
}
