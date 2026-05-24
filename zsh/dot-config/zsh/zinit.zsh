ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

zinit depth"1" nocd light-mode for \
	mroth/evalcache \
	has"starship" atinit"_evalcache starship init zsh" zdharma-continuum/null \
	jeffreytse/zsh-vi-mode

zinit wait"0" lucid depth"1" for \
	has"pnpm" atclone"./zplug.zsh; zinit creinstall -q ." atpull"%atclone" g-plane/pnpm-shell-completion

zinit wait"0" lucid depth"1" nocd for \
	hlissner/zsh-autopair \
	zsh-users/zsh-history-substring-search \
 	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" atclone"fast-theme XDG:catppuccin-mocha" atpull"%atclone" zdharma-continuum/fast-syntax-highlighting \
 	blockf atclone"zinit creinstall -q ." atpull"%atclone" zsh-users/zsh-completions \
 	atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions

zinit wait"1" lucid depth"1" nocd for \
	has"fzf" atload"_evalcache fzf --zsh" Aloxaf/fzf-tab \
	has"zoxide" atload"_evalcache zoxide init zsh" zdharma-continuum/null \
	has"wt" atload"_evalcache wt config shell init zsh" zdharma-continuum/null \
	has"fnm" atload"_evalcache fnm env --use-on-cd" zdharma-continuum/null

zinit wait"2" lucid as"completion" depth"1" for \
	has"rustc" OMZP::rust/_rustc \
	if"[ -s \"$HOME/.bun/_bun\" ]" is-snippet "$HOME/.bun/_bun"

zinit wait"3" lucid depth"1" nocd for \
	has"jenv" atload"_evalcache jenv init -" zdharma-continuum/null

# Autostart tmux
zinit wait"4" lucid depth"1" nocd \
	if'[[ -z $TMUX ]] && [[ "$TERM_PROGRAM" != "vscode" && "$TERM_PROGRAM" != "" ]]' \
	atload"start_tmux" \
	for zdharma-continuum/null
