#!/usr/bin/env sh

set -eu

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q 'MUTED'; then
    exec swayosd-client --custom-message 'Microphone muted' --custom-icon microphone-sensitivity-muted
fi

exec swayosd-client --custom-message 'Microphone on' --custom-icon audio-input-microphone
