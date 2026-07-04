define log
	printf "\n\e[1;34m====> %s <====\e[0m\n\n" $(1);
endef

.PHONY: all
all: link setup-homebrew install-packages setup-tmux setup-yazi install-node install-global-npm setup-env-vars setup-zsh

.PHONY: link
link:
	@$(call log,"Setting up dotfiles")
	@stow */

.PHONY: setup-homebrew
setup-homebrew:
	@if ! [ -x "$(command -v brew)" ]; then \
		$(call log,"Installing Homebrew") \
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@$(call log,"Updating Homebrew")
	@brew update

.PHONY: setup-homebrew-packages
install-packages:
	@$(call log,"Installing Homebrew packages")
	@brew bundle

.PHONY: update
update:
	@topgrade

.PHONY: setup-tmux
setup-tmux:
	@$(call log,"Install tmux plugins")
	@~/.config/tmux/plugins/tpm/bin/install_plugins

.PHONY: setup-yazi
setup-yazi:
	@$(call log,"Setting up yazi")
	@ya pkg install
	@if [ ! -d "${HOME}/.config/yazi/plugins/yatline-catppuccin.yazi" ]; then \
		$(call log,"Install yatline-catppuccin.yazi") \
		git clone https://github.com/imsi32/yatline-catppuccin.yazi.git "${HOME}/.config/yazi/plugins/yatline-catppuccin.yazi"; \
	fi

.PHONY: install-node
install-node:
	@$(call log,"Install latest LTS Node.js")
	@fnm install --lts
	@fnm alias lts-latest default
	@fnm use lts-latest

.PHONY: install-global-npm
install-global-npm:
	@$(call log,"Install global npm packages")
	@npm install -g \
		@fsouza/prettierd \
		@typescript/native-preview \
		cspell \
		eas-cli \
		eslint \
		eslint_d \
		prettier \
		oxlint \
		oxlint-tsgolint \
		oxfmt \
		serve \
		neovim \
		port-whisperer \
		prisma \
		turbo \
		typescript

.PHONY: setup-zsh
setup-zsh:
	@$(call log,"Generate zsh completions")
	@zsh -ic generate_zsh_completions
	@$(call log,"Setting up zsh configuration")
	@zsh -ic compile_zsh_configs

.PHONY: setup-env-vars
setup-env-vars:
	@$(call log,"Setting up environment variables")
	@op inject -i ./zsh/dot-config/zsh/env.template -o ./zsh/dot-config/zsh/env.zsh
	@make setup-zsh
