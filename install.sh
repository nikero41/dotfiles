#! /bin/zsh -i

set -e

log() {
	printf "\n\e[1;34m====> %s <====\e[0m\n\n" "$1"
}

# Install Homebrew
if ! [ -x "$(command -v brew)" ]; then
	log "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	log "Homebrew is already installed"
fi
brew update

log "Installing Homebrew packages"
brew bundle

log "Setting up dotfiles"
stow */

log "Reloading zsh"
source ~/.zshrc

log "Generate zsh files"
compile_zsh_configs

log "Install tmux plugins"
~/.config/tmux/plugins/tpm/bin/install_plugins

log "Setting up yazi"
ya pkg install
if [ ! -d "$HOME/.config/yazi/plugins/yatline-catppuccin.yazi" ]; then
	git clone https://github.com/imsi32/yatline-catppuccin.yazi.git "$HOME/.config/yazi/plugins/yatline-catppuccin.yazi"
fi

log "install Node.js"
fnm install --lts
fnm use lts-latest

log "Install global npm packages"
npm install -g \
	@fsouza/prettierd \
	@typescript/native-preview \
	cspell \
	eas-cli \
	eslint \
	eslint_d \
	live-server \
	neovim \
	prisma \
	turbo \
	typescript

log "Installation completed"
log "Run \"op inject -i zsh/dot-config/zsh/env.template -o zsh/dot-config/zsh/env.zsh; compile_zsh_configs\""
log "to set up environment variables"
