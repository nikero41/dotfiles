set -g @status-separator "#[bg=default,fg=${COLOR_MUTED},none]│"
set -g @is-git-repo "#{==:#(cd #{pane_current_path} && git rev-parse --is-inside-work-tree 2>/dev/null),true}"
set -g @is-command "#{&&:#{!=:#{pane_current_command},zsh},#{!=:#{pane_current_command},bash}}"

set -g @status-session "\
#[range=user|session]\
#{?client_prefix,#[fg=#{@thm_red}], }\
#{?client_prefix,#[bg=#{@thm_red}#,fg=#{@thm_bg}#,bold],#[fg=#{@thm_mauve}]} #S\
#{?client_prefix,#[bg=default#,fg=#{@thm_red}], }\
#[range=left]"

set -g @status-path "#[bg=default,fg=#{@thm_blue}] #{=/-25/~:#{s|.*/||:#{d:pane_current_path}}/#{b:pane_current_path}}"

set -g @status-git "\
#[range=user|git]\
#{?#{E:@is-git-repo},\
 #{E:@status-separator} \
#[bg=default#,fg=#{@thm_green}] #{=/20/~:#(cd #{pane_current_path} && git symbolic-ref --short HEAD || echo HEAD)}\
}#[range=left]"

set -g @status-command "\
#{?#{E:@is-command}, #{E:@status-separator} \
#[bg=default#,fg=#{@thm_maroon}] #{pane_current_command}\
}"

set -g @status-window-label "\
#I#{?#{!=:#{window_name},},: ,}\
#{window_name}"
