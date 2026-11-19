import Quickshell.Services.Pipewire
import qs.config

AudioModule {
    node: Pipewire.defaultAudioSource
    controlCommand: Config.volume.commands.openSourceControl
    getIcon: Config.icons.micIcon
    showPercentage: Config.volume.showMicPercentage
}

