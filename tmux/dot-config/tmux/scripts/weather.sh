#!/usr/bin/env bash

PLUGIN_DIR="$TMUX_PLUGIN_MANAGER_PATH/tmux-weather/scripts"

source "$PLUGIN_DIR/helpers.sh"
WEATHER="$("$PLUGIN_DIR"/weather.sh)"

if [[ -z "$WEATHER" ]]; then
  exit 0
fi

echo "#[bg=default,fg=#{@thm_blue}]${WEATHER} #{E:@status-separator} "
