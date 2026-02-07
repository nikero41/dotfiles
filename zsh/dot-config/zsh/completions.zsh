# fzf-tab
zstyle ":completion:*" list-colors '${(s.:.)LS_COLORS}'
zstyle ":completion:*" menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
FZF_TAB_GROUP_COLORS=($'\033[34m' $'\033[93m' $'\033[95m' $'\033[96m' $'\033[91m')
zstyle ':fzf-tab:*' group-colors $FZF_TAB_GROUP_COLORS
zstyle ':fzf-tab:*' single-group color
zstyle ':fzf-tab:*' switch-group '<' '>'

zstyle ":fzf-tab:complete:cd:*" fzf-preview 'eza --group-directories-first --color=always --long --no-user --no-time --icons --git $realpath'
zstyle ":fzf-tab:complete:nvim:*" fzf-preview '[ -f $realpath ] && bat --color=always --style=numbers $realpath || eza --group-directories-first --color=always --long --no-user --no-time --icons --git $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza --group-directories-first --color=always --long --no-user --no-time --icons --git $realpath'
zstyle ':fzf-tab:complete:(cd|nvim|z|kill|ps|systemctl|brew-(install|uninstall|search|info)):*' popup-min-size 100 8

# fzf-tab: kill
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# fzr-tab: systemd
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# fzf-tab: homebrew
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'

# Docker
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
