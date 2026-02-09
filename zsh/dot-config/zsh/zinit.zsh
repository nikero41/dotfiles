ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

zinit depth"1" nocd light-mode for \
	mroth/evalcache \
	has"starship" atinit"_evalcache starship init zsh" zdharma-continuum/null \
	jeffreytse/zsh-vi-mode

zinit wait lucid as"completion" depth"1" for \
	has"docker" OMZP::docker/completions/_docker \
	has"pod" OMZP::pod/_pod \
	has"rustc" OMZP::rust/_rustc \
	if"[ -s \"$HOME/.bun/_bun\" ]" is-snippet "$HOME/.bun/_bun"

zinit wait lucid depth"1" nocd for \
	has"fnm" atload"_evalcache fnm env --use-on-cd" zdharma-continuum/null \
	has"fzf" atload"_evalcache fzf --zsh" zdharma-continuum/null \
	has"jenv" atload"_evalcache jenv init -" zdharma-continuum/null \
	has"zoxide" atload"_evalcache zoxide init zsh" zdharma-continuum/null \
	has"pnpm" atclone"./zplug.zsh" atpull"%atclone" g-plane/pnpm-shell-completion \
	has"fzf" Aloxaf/fzf-tab \
	hlissner/zsh-autopair \
	zsh-users/zsh-history-substring-search \
	atinit"zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
	atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
	blockf atpull"zinit creinstall -q ." zsh-users/zsh-completions

zinit wait lucid depth"1" nocd for \
	has"delta" atload"_evalcache delta --generate-completion zsh" zdharma-continuum/null \
	has"op" atload"_evalcache op completion zsh" zdharma-continuum/null \
	has"opencode" atload"_evalcache opencode completion" zdharma-continuum/null \
	has"ngrok" atload"_evalcache ngrok completion" zdharma-continuum/null \
	has"spotify_player" atload"_evalcache spotify_player generate zsh" zdharma-continuum/null

# Autostart tmux
zinit wait lucid depth"1" nocd \
	if'[[ -z $TMUX ]] && [[ "$TERM_PROGRAM" != "vscode" && "$TERM_PROGRAM" != "" ]]' \
	atload"start_tmux" \
	for zdharma-continuum/null
