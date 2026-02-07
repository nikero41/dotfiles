#! /bin/zsh -i

set -e

log() {
	printf "\n\e[1;34m====> %s <====\e[0m\n\n" "$1"
}

log "Updating Homebrew"
brew update
brew upgrade
brew autoremove

log "Updating zinit"
clear_evalcache
zinit self-update

log "Updating zinit plugins"
zinit update

log "Updating tmux plugins"
~/.config/tmux/plugins/tpm/bin/update_plugins all

log "Updating Yazi plugins"
ya pkg upgrade

log "Updating npm packages"
npm update -g

log "Updating Rust toolchain"
rustup update

log "Updating Bun"
bun upgrade
