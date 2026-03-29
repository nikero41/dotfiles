# Dotfiles Repository

This repository contains configuration files (dotfiles) for various programs
and tools, organized using the Stow symbolic link manager.

## Repository Structure

In this repository, dotfiles are organized into separate directories based on
the program or tool they configure (e.g., `zsh`, `tmux`). Stow is used
to create symbolic links from these directories into the user's home directory.

The structure of this repository typically looks like:

```
dotfiles/
├── zsh/
│   └── .zshrc
├── tmux/
│   └── .config
│       └── .tmux.conf
└── ...
```

## Setup Instructions

To use these dotfiles on your system:

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/snikoletopoulos/dotfiles.git ~/dotfiles
   ```

2. **Install GNU Stow**:
   Ensure GNU Stow is installed on your system. You can install it using package
   managers like `apt`, `brew`, or `pacman`:

   ```bash
   # Debian/Ubuntu
   sudo apt install stow

   # Homebrew
   brew install stow
   ```

3. **Deploy Dotfiles**:
   Navigate into the `dotfiles` directory and use Stow to deploy specific
   configurations. For example, to deploy the `zsh` configurations:

   ```bash
   stow */ # Everything (the '/' ignores the README)
   ```

   ```bash

   stow zsh
   ```

   This will create symbolic links for the specified configurations
   (`zsh` in this case) in your home directory.

4. **Customize and Update**:
   Feel free to customize any configuration files to suit your preferences. To
   update dotfiles, simply pull the latest changes from this repository and
   re-stow the relevant configurations.

## Apps that are not installed by default

- [1password](https://1password.com/)
- [Beekeeper Studio](https://www.beekeeperstudio.io/)
- [Docker](https://docs.docker.com/desktop/setup/install/mac-install/#install-and-run-docker-desktop-on-mac)
- [Google Chrome](https://www.google.com/chrome/)
- [Postman](https://www.postman.com/)
- [React Native DevTools](https://github.com/Buoy-gg/Buoy-Desktop)
- [Spotify](https://www.spotify.com/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Wispr Fow](https://wisprflow.ai/)
- [Zen](https://zen-browser.app/)

## Contributing

Suggestions and improvements to these dotfiles are welcome! If you have ideas
for new configurations or improvements to existing ones, feel free to open an
issue or pull request.

## Credits

This repository is inspired by various dotfiles repositories shared by the community.
Thanks to all the contributors and open-source projects that make customizing
our computing environments easier and more enjoyable.
