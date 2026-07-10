%hidden COLOR_PRIMARY="#{@thm_peach}"
%hidden COLOR_MUTED="#{@thm_overlay_0}"

source-file -F "#{HOME}/.config/tmux/status-widgets/widgets.tmux"

set -g status-position top
set -g status-justify "absolute-centre"

set -g status-style "bg=default,fg=#{@thm_fg}"

set -g message-style "fg=#{@thm_peach},bg=default,fill=#{@thm_bg},align=centre"

# Status Left
set -g status-left-length 100
set -g @status-normal-left "#{E:@status-session}#{E:@status-separator} #{E:@status-path}#{E:@status-git}#{E:@status-command}"
set -g status-left "#{E:@status-normal-left}"

# Zoom
set -ga status-left "#{?window_zoomed_flag, #{E:@status-separator} #[bg=default#,fg=#{@thm_yellow}]}"

# Windows
set -g window-status-format "\
#{?#{window_bell_flag},#[bg=default#,fg=#{@thm_red}#,bold#,noreverse], }\
#[#{?#{window_bell_flag},reverse}]#{E:@status-window-label}\
#{?#{window_marked_flag}, 󰈽}\
#{?#{window_bell_flag},#[noreverse], }"

set -g window-status-current-format "\
#[bg=default,fg=${COLOR_PRIMARY},bold]\
#[reverse]#{E:@status-window-label}\
#{?#{window_marked_flag}, 󰈽}\
#[noreverse]"

set -gF window-status-separator " #{E:@status-separator} "

set -g window-status-style "bg=default,fg=#{@thm_flamingo}"
set -g window-status-last-style "fg=${COLOR_PRIMARY}"
set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"

# Status Right
set -g status-right-length 100
set -g status-right ""
set -ga status-right "#{?#{==:#{online_status},offline},#[fg=#{@thm_red}]󰤮 #{E:@status-separator} }"
set -ga status-right "#(~/.config/tmux/scripts/cpu.sh)"
set -ga status-right "#(~/.config/tmux/scripts/battery.sh)"
set -ga status-right "#(~/.config/tmux/scripts/weather.sh)"
set -ga status-right "#[bg=default,fg=#{@thm_mauve}]󰭦 %e %b 󰅐 %I:%M %p"
