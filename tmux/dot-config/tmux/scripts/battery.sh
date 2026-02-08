#!/usr/bin/env bash

PLUGIN_DIR="$TMUX_PLUGIN_PATH/tmux-battery/scripts"

source "$PLUGIN_DIR/helpers.sh"

# COLOR="$("$PLUGIN_DIR"/battery_color.sh bg)"
COLOR_FG="$("$PLUGIN_DIR"/battery_color.sh fg)"
# COLOR_CHARGE="$("$PLUGIN_DIR"/battery_color_charge.sh bg)"
# COLOR_CHARGE="$("$PLUGIN_DIR"/battery_color_charge.sh fg)"
# COLOR_STATUS="$("$PLUGIN_DIR"/battery_color_status.sh bg)"
# COLOR_STATUS="$("$PLUGIN_DIR"/battery_color_status.sh fg)"
# GRAPH="$("$PLUGIN_DIR"/battery_graph.sh)"
ICON="$("$PLUGIN_DIR"/battery_icon.sh)"
# ICON_CHARGE="$("$PLUGIN_DIR"/battery_icon_charge.sh)"
# ICON_STATUS="$("$PLUGIN_DIR"/battery_icon_status.sh)"
PERCENTAGE="$("$PLUGIN_DIR"/battery_percentage.sh)"
REMAIN="$("$PLUGIN_DIR"/battery_remain.sh)"
# CHARGING_WATTS="$("$PLUGIN_DIR"/battery_charging_watts.sh)"

if [[ ${PERCENTAGE::-1} -lt 60 || ${PERCENTAGE::-1} -eq 100 ]]; then
  exit 0
fi

echo "$COLOR_FG$ICON $PERCENTAGE $REMAIN #{E:@status-separator} "
