unbind C-b
set -g prefix C-s
unbind C-s
bind C-s send-prefix

bind -r -N "Move window to the left" "<" swap-window -d -t -1
bind -r -N "Move window to the right" ">" swap-window -d -t +1

bind -N "Clear history" C-c send-keys C-l

# Create new shells
bind -N "New window" c new-window -c "#{pane_current_path}"
bind -N "Vertical split" v split-window -v -c "#{pane_current_path}"
bind -N "Horizontal split" h split-window -h -c "#{pane_current_path}"

# popups
set -g @lazygit_popup_cmd 'tmux popup -d "#{pane_current_path}" -E -w 90% -h 90% -T Git lazygit'
bind -N "Lazygit" g run-shell "#{@lazygit_popup_cmd}"
bind -N "Spotify" m run-shell \
  'tmux popup -d "#{pane_current_path}" -E -w 90% -h 90% -T Spotify spotify_player'
bind -N "File manager" f run-shell \
  'tmux popup -d "#{pane_current_path}" -E -w 90% -h 90% -T "File manager" yazi'
bind -N "Activity monitor" a run-shell \
  'tmux popup -E -w 90% -h 90% -T Activity btop'
bind C-Space run-shell "$TMUX_PLUGIN_MANAGER_PATH/tmux-palette/bin/tmux-palette.sh"

unbind P
bind -N "pet" P run-shell \
  'tmux popup -E -w 90% -h 90% -T Activity "pet search | xargs -I _ tmux send-keys -l -t #{pane_id} _"'

bind -n MouseDown1Status {
  if -F "#{==:#{mouse_status_range},session}" {
    run "#{TMUX_PLUGIN_MANAGER_PATH}/tmux-sessionx/scripts/sessionx.sh"
  } 
  if -F "#{==:#{mouse_status_range},window}" {
      select-window
  }
  if -F "#{==:#{mouse_status_range},git}" {
    run "#{@lazygit_popup_cmd}"
  } 
}

bind C-S-l switch-client -l

# unbind resize-pane keys
unbind M-Up
unbind M-Down
unbind M-Left
unbind M-Right
unbind C-Up
unbind C-Down
unbind C-Left
unbind C-Right

bind -N "Resize pane left" -r H resize-pane -L 5
bind -N "Resize pane down" -r J resize-pane -D 5
bind -N "Resize pane up" -r K resize-pane -U 5
bind -N "Resize pane right" -r L resize-pane -R 5

bind -n "C-\\" select-pane -l

# make panes equal on =

# bind V choose-tree -F "#{E:@custom_choose_tree_format}" -Z "join-pane -h -s "%%""
# bind S choose-tree -F "#{E:@custom_choose_tree_format}" -Z "join-pane -v -s "%%""
#
# bind b if-shell " [ #{window_panes} -gt '1' ] " { break-pane -a }
