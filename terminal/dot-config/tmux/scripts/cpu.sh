#!/usr/bin/env bash

PLUGIN_DIR="$TMUX_PLUGIN_MANAGER_PATH/tmux-cpu/scripts"

CPU_PERCENTAGE="$("$PLUGIN_DIR"/cpu_percentage.sh)"
CPU_ICON="$("$PLUGIN_DIR"/cpu_icon.sh)"
CPU_BG_COLOR="$("$PLUGIN_DIR"/cpu_bg_color.sh)"
CPU_FG_COLOR="$("$PLUGIN_DIR"/cpu_fg_color.sh)"
# GPU_PERCENTAGE="$("$PLUGIN_DIR"/gpu_percentage.sh)"
# GPU_ICON="$("$PLUGIN_DIR"/gpu_icon.sh)"
# GPU_BG_COLOR="$("$PLUGIN_DIR"/gpu_bg_color.sh)"
# GPU_FG_COLOR="$("$PLUGIN_DIR"/gpu_fg_color.sh)"
# RAM_PERCENTAGE="$("$PLUGIN_DIR"/ram_percentage.sh)"
# RAM_ICON="$("$PLUGIN_DIR"/ram_icon.sh)"
# RAM_BG_COLOR="$("$PLUGIN_DIR"/ram_bg_color.sh)"
# RAM_FG_COLOR="$("$PLUGIN_DIR"/ram_fg_color.sh)"
# GRAM_PERCENTAGE="$("$PLUGIN_DIR"/gram_percentage.sh)"
# GRAM_ICON="$("$PLUGIN_DIR"/gram_icon.sh)"
# GRAM_BG_COLOR="$("$PLUGIN_DIR"/gram_bg_color.sh)"
# GRAM_FG_COLOR="$("$PLUGIN_DIR"/gram_fg_color.sh)"
# CPU_TEMP="$("$PLUGIN_DIR"/cpu_temp.sh)"
# CPU_TEMP_ICON="$("$PLUGIN_DIR"/cpu_temp_icon.sh)"
# CPU_TEMP_BG_COLOR="$("$PLUGIN_DIR"/cpu_temp_bg_color.sh)"
# CPU_TEMP_FG_COLOR="$("$PLUGIN_DIR"/cpu_temp_fg_color.sh)"
# GPU_TEMP="$("$PLUGIN_DIR"/gpu_temp.sh)"
# GPU_TEMP_ICON="$("$PLUGIN_DIR"/gpu_temp_icon.sh)"
# GPU_TEMP_BG_COLOR="$("$PLUGIN_DIR"/gpu_temp_bg_color.sh)"
# GPU_TEMP_FG_COLOR="$("$PLUGIN_DIR"/gpu_temp_fg_color.sh)"

if [[ ${CPU_PERCENTAGE::-1} -lt 60 ]]; then
  exit
fi

echo "$CPU_BG_COLOR$CPU_FG_COLOR $CPU_ICON $CPU_PERCENTAGE #{E:@status-separator} "
