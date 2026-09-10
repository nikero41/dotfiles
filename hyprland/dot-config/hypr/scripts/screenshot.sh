#!/usr/bin/env bash

set -euo pipefail

readonly mode="${1:-region}"
readonly screenshots_dir="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
readonly timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
readonly file="$screenshots_dir/$timestamp.png"

mkdir -p "$screenshots_dir"

case "$mode" in
    region)
        grim -g "$(slurp)" "$file"
        ;;
    window)
        grim -g "$(hyprctl activewindow -j | jq -r '\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])')" "$file"
        ;;
    output)
        grim "$file"
        ;;
    edit)
        grim -g "$(slurp)" - | satty -f - --copy-command wl-copy -o "$screenshots_dir/%Y-%m-%d_%H-%M-%S.png"
        exit 0
        ;;
    *)
        printf 'Unknown screenshot mode: %s\n' "$mode" >&2
        exit 2
        ;;
esac

wl-copy < "$file"
notify-send --app-name=Screenshot --icon="$file" "Screenshot saved" "$file"
