alias ..="cd .."
alias ...="cd ../.."
alias dev="cd ~/Developer"

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias mkdir="mkdir -pv"
alias grep="grep --color=auto"
alias du="du -h"
alias df="df -h"

alias nv="nvim"
alias lg="lazygit"

# eza
alias ls="eza --group-directories-first --icons --oneline"
alias lsl="eza --group-directories-first --icons --long --no-user --git"
alias lst="eza --group-directories-first --icons --tree"

# pnpm
alias pn="pnpm"

# tmuxinator
alias mux="tmuxinator"
alias muxstart="mux list -n | tail -n +2 | fzf | xargs tmuxinator start"

# files extensions
alias -s json=fx
alias -s md=bat
alias -s go="$EDITOR"
alias -s rs="$EDITOR"
alias -s txt=bat
alias -s log=bat
alias -s js="$EDITOR"
alias -s jsx="$EDITOR"
alias -s ts="$EDITOR"
alias -s tsx="$EDITOR"
alias -s html=open

# global aliases
alias -g NE="2>/dev/null"
alias -g NO=">/dev/null"
alias -g NUL=">/dev/null 2>&1"
alias -g J="| jq"
alias -g C="| pbcopy"
