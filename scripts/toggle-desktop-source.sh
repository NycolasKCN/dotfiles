#!/usr/bin/env bash
#
# toggle-audio.sh
# Alterna entre dois dispositivos de áudio (sink + source) usando pactl.
#
# Dispositivo A: PCI onboard (analógico)
# Dispositivo B: USB Jieli Technology
#
# Uso:
#   ./toggle-audio.sh          -> alterna automaticamente
#   ./toggle-audio.sh pci      -> força o dispositivo PCI
#   ./toggle-audio.sh usb      -> força o dispositivo USB
#   ./toggle-audio.sh status   -> mostra o sink/source padrão atual

set -euo pipefail

# --- Definições dos dispositivos ---------------------------------------

SINK_PCI="alsa_output.pci-0000_00_1f.3.analog-stereo"
SOURCE_PCI="alsa_input.pci-0000_00_1f.3.analog-stereo"

SINK_USB="alsa_output.usb-Jieli_Technology_USB_Composite_Device_4250315736303607-00.analog-stereo"
SOURCE_USB="alsa_input.usb-Jieli_Technology_USB_Composite_Device_4250315736303607-00.mono-fallback"

# --- Funções auxiliares ---------------------------------------------------

get_default_sink() {
    pactl get-default-sink
}

move_all_sink_inputs() {
    local target_sink="$1"
    local ids
    ids=$(pactl list short sink-inputs | cut -f1)
    for id in $ids; do
        pactl move-sink-input "$id" "$target_sink" 2>/dev/null || true
    done
}

move_all_source_outputs() {
    local target_source="$1"
    local ids
    ids=$(pactl list short source-outputs | cut -f1)
    for id in $ids; do
        pactl move-source-output "$id" "$target_source" 2>/dev/null || true
    done
}

set_device() {
    local sink="$1"
    local source="$2"
    local label="$3"

    pactl set-default-sink "$sink"
    pactl set-default-source "$source"

    move_all_sink_inputs "$sink"
    move_all_source_outputs "$source"

    echo "Áudio alternado para: $label"
    echo "  Sink:   $sink"
    echo "  Source: $source"

    # Notificação opcional (requer libnotify/notify-send instalado)
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "Áudio" "Alternado para $label" -i audio-card 2>/dev/null || true
    fi
}

show_status() {
    echo "Sink padrão atual:   $(pactl get-default-sink)"
    echo "Source padrão atual: $(pactl get-default-source)"
}

# --- Lógica principal ------------------------------------------------------

MODE="${1:-toggle}"

case "$MODE" in
    pci)
        set_device "$SINK_PCI" "$SOURCE_PCI" "PCI (analógico onboard)"
        ;;
    usb)
        set_device "$SINK_USB" "$SOURCE_USB" "USB (Jieli Technology)"
        ;;
    status)
        show_status
        ;;
    toggle|"")
        current_sink=$(get_default_sink)
        if [[ "$current_sink" == "$SINK_PCI" ]]; then
            set_device "$SINK_USB" "$SOURCE_USB" "USB (Jieli Technology)"
        else
            set_device "$SINK_PCI" "$SOURCE_PCI" "PCI (analógico onboard)"
        fi
        ;;
    *)
        echo "Uso: $0 [pci|usb|status|toggle]"
        exit 1
        ;;
esac
