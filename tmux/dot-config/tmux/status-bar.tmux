set -g status-position top
set -g status-justify "absolute-centre"

set -g status-style "bg=default,fg=#{@thm_fg}"

%hidden COLOR_PRIMARY="#{@thm_peach}"
%hidden COLOR_MUTED="#{@thm_overlay_0}"
set -g @status-separator "#[bg=default,fg=${COLOR_MUTED},none]│"

set -g message-style "fg=${COLOR_PRIMARY}"

# Status Left
set -g status-left-length 100
set -g status-left ""
set -ga status-left "\
#[range=user|session]#{?client_prefix,#[fg=#{@thm_red}], }\
#{?client_prefix,#[bg=#{@thm_red}#,fg=#{@thm_bg}#,bold],#[fg=#{@thm_mauve}]} #S\
#{?client_prefix,#[bg=default#,fg=#{@thm_red}], }#[range=left]"
set -ga status-left "#{E:@status-separator} "
set -ga status-left "#[bg=default,fg=#{@thm_blue}] #{=/-25/~:#{s|.*/||:#{d:pane_current_path}}/#{b:pane_current_path}}"
set -ga status-left "\
#[range=user|git]#{?#{==:#(git rev-parse --is-inside-work-tree 2>/dev/null),true},\
 #{E:@status-separator} \
#[bg=default#,fg=#{@thm_green}] #(cd #{pane_current_path} && git symbolic-ref --short HEAD || echo HEAD)\
}#[range=left]"
set -ga status-left "\
#{?#{&&:#{!=:#{pane_current_command},zsh},#{!=:#{pane_current_command},bash}},\
 #{E:@status-separator} \
#[bg=default#,fg=#{@thm_maroon}] #{pane_current_command}\
}"
set -ga status-left "#{?window_zoomed_flag, #{E:@status-separator} #[bg=default#,fg=#{@thm_yellow}]}"

# Windows
set -g window-status-format "\
#{?#{window_bell_flag},#[bg=default#,fg=#{@thm_red}#,bold#,noreverse], }\
#[#{?#{window_bell_flag},reverse}]#I#{?#{!=:#{window_name},},: ,}\
#{window_name}\
#{?#{window_marked_flag}, 󰈽}\
#{?#{window_bell_flag},#[noreverse], }"
set -g window-status-current-format "\
#[bg=default,fg=${COLOR_PRIMARY},bold]\
#[reverse]#I#{?#{!=:#{window_name},},: ,}\
#{window_name}\
#{?#{window_marked_flag}, 󰈽}\
#[noreverse]"
set -gF window-status-separator " #{E:@status-separator} "

set -g window-status-style "bg=default,fg=#{@thm_flamingo}"
set -g window-status-last-style "fg=${COLOR_PRIMARY}"
set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"

# Status Right
set -g status-right-length 100
set -g status-right ""
set -ga status-right "\
#{?#{==:#{online_status},offline},\
#[fg=#{@thm_red}]󰤮\
 #{E:@status-separator}}" # NOTE: `online_status` is readable once
set -ga status-right "\
#{?#{!=:#{cpu_icon},off},\
#{cpu_bg_color}#{cpu_fg_color} #{cpu_icon} #{cpu_percentage} \
#{E:@status-separator} \
}"
set -ga status-right "\
#{battery_color_fg}#{battery_icon}#{?#{<=:#{battery_percentage},60}, #{battery_percentage}} #{battery_remain}"
set -ga status-right " #{E:@status-separator} "
set -ga status-right "#[bg=default,fg=#{@thm_blue}]#{weather} #{E:@status-separator} "
set -ga status-right "#[bg=default,fg=#{@thm_mauve}]󰭦 %e %b 󰅐 %I:%M %p"
