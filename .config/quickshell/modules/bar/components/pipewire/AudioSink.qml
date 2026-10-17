import Quickshell.Services.Pipewire
import qs.config

AudioModule {
    node: Pipewire.defaultAudioSink
    controlCommand: Config.volume.commands.openSinkControl
    getIcon: Config.icons.volumeIcon
}
