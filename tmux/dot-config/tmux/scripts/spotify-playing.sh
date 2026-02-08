#!/usr/bin/env bash

BG_FILLED="#{@thm_sky}"
BG="default"
FG="#{@thm_maroon}"
FG_FILLED="#{@thm_surface_1}"

# Get Spotify data via AppleScript
if pgrep -x "Spotify" >/dev/null; then
  STATUS=$(osascript -e 'tell application "Spotify" to player state as string')
  if [[ "$STATUS" == "playing" ]] || [[ "$STATUS" == "paused" ]]; then
    TITLE=$(osascript -e 'tell application "Spotify" to name of current track')
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track')
    POSITION=$(osascript -e 'tell application "Spotify" to player position' | cut -d. -f1)
    DURATION=$(osascript -e 'tell application "Spotify" to (duration of current track) / 1000' | cut -d. -f1)
  fi
fi

[[ "$STATUS" != "playing" ]] && exit 0
OUTPUT="$ARTIST - $TITLE"

MAX_WIDTH=25
if [[ ${#OUTPUT} -gt $MAX_WIDTH ]]; then
  PADDED="${OUTPUT}   ${OUTPUT}"
  # Scroll based on current time
  OFFSET=$(( ($(date +%s)) % (${#OUTPUT} + 3) ))
  OUTPUT="${PADDED:$OFFSET:$MAX_WIDTH}"
fi

# Calculate progress
OUTPUT_LENGTH=$((${#OUTPUT} + 2))
echo "🪚 OUTPUT_LENGTH: $OUTPUT_LENGTH" >&2
RAW_PROGRESS=0
if [[ $DURATION -gt 0 ]]; then
  PERCENT=$((POSITION * 100 / DURATION))
  RAW_PROGRESS=$((OUTPUT_LENGTH * PERCENT / 100))
fi

echo "🪚 RAW_PROGRESS: $RAW_PROGRESS" >&2
if [[ $RAW_PROGRESS -gt 0 ]]; then
  PROGRESS=$((RAW_PROGRESS - 1))
else
  PROGRESS=0
fi
  echo "🪚 PROGRESS: $PROGRESS" >&2

PREFIX="$([[ $RAW_PROGRESS -ge 1 ]] && echo "#[bg=default,fg=$BG_FILLED]" || echo " ")"
FILLED_OUTPUT="#[bg=$BG_FILLED,fg=$FG_FILLED]${OUTPUT:0:$PROGRESS}"
UNFILLED_OUTPUT="#[bg=$BG,fg=$FG]${OUTPUT:$PROGRESS}"
SUFFIX=$([ "${RAW_PROGRESS}" -eq "${OUTPUT_LENGTH}" ] && echo "#[bg=default,fg=$BG_FILLED]" || echo " ")

echo "$PREFIX#[default]$FILLED_OUTPUT#[default]$UNFILLED_OUTPUT#[default]$SUFFIX#[default]"
