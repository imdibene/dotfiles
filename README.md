# Dotfiles Repository
This repository contains my personal configuration files (dotfiles) for various applications, organized by application name. The setup uses GNU `stow` for symlinking the files to their appropriate locations in the system.

## Prerequisites

- `git`: To clone the repository.
- GNU `stow`: For symlinking the configuration files.

Install it with your package manager:

  - Debian: `sudo apt install stow`
  - MacOS (Homebrew): `brew install stow`

## Installation

1. Clone the repository into your home directory (or another preferred location):

```shell
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Use `stow` to symlink configurations for the desired applications.

For example, to set up `zsh` and `tmux`:

```shell
stow -v zsh tmux
```

  - The `-v` flag enables verbose output (optional).
  - Replace `zsh` and `tmux` with the names of the directories for the apps you want to configure.

3. Verify the symlinks were created correctly in `~/.config/` (or other target directories).

## Adding New Configurations

1. Organize by application:

Create a new directory (e.g., `nvim/.config/nvim`) and place your config files inside, maintaining the same directory structure as the target system.

2. Symlink with `stow`:

```shell
stow -v nvim
```

## Removing Configurations

To unlink a configuration (e.g., `tmux`), run:

```shell
stow -D tmux
```

## Structure

```shell
.
├── zsh/
│   └── .config/
│       └── zsh/          # → ~/.config/zsh/
│           ├── .zshrc
│           └── ...
├── tmux/
│   └── .config/
│       └── tmux/         # → ~/.config/tmux/
│           └── .tmux.conf
└── ...
```

## Notes

- Backup existing files: If you already have config files in the target locations, move or back them up before running `stow`.
- Custom paths: If your system expects configs in non-standard paths (e.g., `~/.zshrc` instead of `~/.config/zsh/.zshrc`), adjust the directory structure accordingly.
- Dry run: Test with `stow -nv` to preview changes without applying them.

## [License: MIT](LICENSE)
