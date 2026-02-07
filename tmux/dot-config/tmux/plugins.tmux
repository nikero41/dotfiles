# Bootstrap Tmux Plugin Manager
if 'test ! -d "#{TMUX_PLUGIN_PATH}/tpm"' {
  run 'mkdir -p "#{TMUX_PLUGIN_PATH}"'
  run 'git clone https://github.com/tmux-plugins/tpm "#{TMUX_PLUGIN_PATH}/tpm"'
  run "#{TMUX_PLUGIN_PATH}/tpm/bin/install_plugins"
}

# List of plugins
set -g @plugin "tmux-plugins/tpm"
set -g @plugin "tmux-plugins/tmux-sensible"
set -g @plugin "wfxr/tmux-fzf-url"
set -g @plugin "nhdaly/tmux-better-mouse-mode"
set -g @plugin "christoomey/vim-tmux-navigator"
set -g @plugin "jaclu/tmux-menus"

# Resurrect
set -g @plugin "tmux-plugins/tmux-resurrect"
set -g @resurrect-strategy-nvim "session"
set -g @resurrect-capture-pane-contents "on"
set -g @resurrect-save "S"

# Continuum
set -g @plugin "tmux-plugins/tmux-continuum"
set -g @continuum-restore "on"
set -g @continuum-save-interval "15"

# SessionX
set -g @plugin "omerxx/tmux-sessionx"
set -g @sessionx-bind "w"
set -g @sessionx-zoxide-mode "on"
set -g @sessionx-filter-current "false"
set -g @sessionx-preview-location "top"
set -g @sessionx-preview-ratio "75%"
set -g @sessionx-tmuxinator-mode "on"
set -g @sessionx-bind-tmuxinator-list "ctrl-p"
set -g @sessionx-filtered-sessions "floax"
set -g @sessionx-legacy-fzf-support "off"

# FloaX
set -g @plugin "omerxx/tmux-floax"
set -g @floax-session-name "floax"
set -g @floax-bind "s"
set -gF @floax-border-color "#{@thm_mauve}"
set -g @floax-bind-menu "M-X"

# CPU
set -g @plugin "tmux-plugins/tmux-cpu"
set -g @cpu_percentage_format "%3d%%"
set -g @cpu_medium_thresh "65"
set -g @cpu_high_thresh "85"
set -g @cpu_medium_bg_color "#[bg=default]"
set -g @cpu_high_fg_color "#[fg=#{@thm_crust}]"
set -g @cpu_high_bg_color "#[bg=red]"
set -g @cpu_low_icon "off"
set -g @cpu_medium_icon ""
set -g @cpu_high_icon ""

# Battery
set -g @plugin "tmux-plugins/tmux-battery"
set -g @batt_icon_charge_tier8 '󰂂'
set -g @batt_icon_charge_tier7 '󰂁'
set -g @batt_icon_charge_tier6 '󰂀'
set -g @batt_icon_charge_tier5 '󰁿'
set -g @batt_icon_charge_tier4 '󰁾'
set -g @batt_icon_charge_tier3 '󰁼'
set -g @batt_icon_charge_tier2 '󰁻'
set -g @batt_icon_charge_tier1 '󰁺'
set -g @batt_icon_status_charged '󰁹'
set -g @batt_icon_status_charging '󰂄'
set -g @batt_icon_status_discharging '󰂃'
set -g @batt_icon_status_attached '󰂄'
set -g @batt_icon_status_unknown '󰂄'

set -g @batt_color_charge_primary_tier8 "#{@thm_green}"
set -g @batt_color_charge_primary_tier7 "#{@thm_green}"
set -g @batt_color_charge_primary_tier6 "#{@thm_green}"
set -g @batt_color_charge_primary_tier5 "#{@thm_green}"
set -g @batt_color_charge_primary_tier4 "#{@thm_green}"
set -g @batt_color_charge_primary_tier3 "#{@thm_pink}"
set -g @batt_color_charge_primary_tier2 "#{@thm_crust}"
set -g @batt_color_charge_primary_tier1 "#{@thm_crust}"
set -g @batt_color_charge_secondary_tier8 "default"
set -g @batt_color_charge_secondary_tier7 "default"
set -g @batt_color_charge_secondary_tier6 "default"
set -g @batt_color_charge_secondary_tier5 "default"
set -g @batt_color_charge_secondary_tier4 "default"
set -g @batt_color_charge_secondary_tier3 "default"
set -g @batt_color_charge_secondary_tier2 "#{@thm_red}"
set -g @batt_color_charge_secondary_tier1 "#{@thm_red}"

set -g @batt_color_status_primary_charged "#{@thm_green}"
set -g @batt_color_status_primary_charging "#{@thm_green}"
set -g @batt_color_status_primary_discharging "#{@thm_red}"
set -g @batt_color_status_primary_attached "#{@thm_green}"
set -g @batt_color_status_primary_unknown  "#{@thm_green}"
set -g @batt_color_status_secondary_charged "default"
set -g @batt_color_status_secondary_charging "default"
set -g @batt_color_status_secondary_discharging "default"
set -g @batt_color_status_secondary_attached "default"
set -g @batt_color_status_secondary_unknown  "default"
set -g @batt_remain_short "true"

# Weather
set -g @plugin "xamut/tmux-weather"
set -g @tmux-weather-format "%c+%t+(%f)"

# Online status
set -g @plugin "tmux-plugins/tmux-online-status"
set -g @offline_icon "offline"

run "#{TMUX_PLUGIN_PATH}/tpm/tpm"
