#!/usr/bin/env bash

set -euo pipefail

readonly runtime_dir="${XDG_RUNTIME_DIR:?XDG_RUNTIME_DIR is required}"
readonly pid_file="$runtime_dir/hypr-recording.pid"
readonly recordings_dir="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"

if [[ -r "$pid_file" ]]; then
    read -r pid < "$pid_file"
    if kill -0 "$pid" 2>/dev/null; then
        kill -INT "$pid"
        notify-send --app-name=ScreenRecorder "Recording saved"
        exit 0
    fi
    rm -f "$pid_file"
fi

mkdir -p "$recordings_dir"
geometry="$(slurp)"
file="$recordings_dir/$(date +%Y-%m-%d_%H-%M-%S).mp4"

wf-recorder --geometry "$geometry" --file "$file" &
printf '%s\n' "$!" > "$pid_file"
notify-send --app-name=ScreenRecorder "Recording started" "Press Alt+Print again to stop"
