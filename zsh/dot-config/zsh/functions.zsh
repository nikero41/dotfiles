google() {
	open "https://www.google.com/search?q=$*"
}

cx() { cd "$@" && ls; }
zx() { z "$@" && ls; }

dotconfig() {
	cd ~/dotfiles || return
	nv
	cd - || return
}

nvimconfig() {
	cd ~/.config/nvim || return
	nv
	cd - || return
}

start_tmux() {
	local session_ids create_new_session start_without_tmux choices choice
	session_ids="$(tmux list-sessions -F '#{session_name}')"

	if [[ -z "$session_ids" ]]; then
		tmux new-session
	fi

	create_new_session="Create new session"
	start_without_tmux="Start without tmux"
	choices="${start_without_tmux}\n${create_new_session}\n$session_ids"
	choice="$(echo "$choices" | fzf --no-multi --style full --layout reverse --preview 'tmux capture-pane -ep -t {}' --header "Select session" | cut -d: -f1)"

	if [[ "$choice" = "${create_new_session}" ]]; then
		tmux new-session
	elif [[ "$choice" = "${start_without_tmux}" ]]; then
		:
	elif [[ -n "$choice" ]]; then
		tmux attach-session -t "$choice"
	fi
}

yy() {
	local tmp
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"

	local cwd
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd" || return
	fi
	rm -f -- "$tmp"
}

save_prev() {
	PREV=$(fc -lrn | head -n 1)
	sh -c "pet new $(printf %q "$PREV")"
}

run_snippet() {
	pet exec
}

clear_evalcache() {
	echo "clearing evalcache"
	rm "$ZSH_EVALCACHE_DIR"/init-*.sh
	echo "evalcache cleared"
}

compile_zsh_configs() {
	local config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
	local src zwc
	local -a files=(
		"$config_dir/aliases.zsh"
		"$config_dir/completions.zsh"
		"$config_dir/env.zsh"
		"$config_dir/functions.zsh"
		"$config_dir/init.zsh"
		"$config_dir/keybinds.zsh"
		"$config_dir/polish.zsh"
		"$config_dir/variables.zsh"
		"$config_dir/vi-mode.zsh"
		"$config_dir/zinit.zsh"
	)

	for src in "${files[@]}"; do
		[[ -r "$src" ]] || continue
		zwc="${src}.zwc"

		if [[ ! -e "$zwc" || "$src" -nt "$zwc" ]]; then
			zcompile -R -- "$src" || return 1
			print -r "compiled: $src"
		fi
	done

	print -r "zsh compile done"
}
