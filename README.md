### dotfiles

My personal dotfiles for setting up development environment on macOS.

[![MIT License](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

### Overview

This repository contains configuration files for:
- Zsh (with Oh My Zsh and Powerlevel10k theme)
- Vim
- VS Code (settings, keybindings, and extensions)
- Git
- Homebrew packages

### Prerequisites

- macOS
- [Homebrew](https://brew.sh/)
- [GNU Stow](https://www.gnu.org/software/stow/)
- [VS Code](https://code.visualstudio.com/)

### Installation

1. Clone this repository:
```bash
git clone https://github.com/jx2lee/dotfiles.git
cd dotfiles
```

2. Run the bootstrap script:
```bash
./bootstrap.sh
```

This will:
- Symlink all configuration files using stow
- Install Homebrew packages and casks from `brew/Brewfile`
- Install VS Code extensions from `vscode/vscode-extensions.txt`

### Components

#### Zsh Configuration
- Uses Oh My Zsh with Powerlevel10k theme
- Includes plugins: git, zsh-syntax-highlighting, zsh-autosuggestions
- Custom aliases and environment configurations

#### Vim Configuration
- Basic settings for better usability
- Line numbers (relative and absolute)
- Cursor line highlighting
- Search highlighting
- Custom keybindings

#### VS Code Setup
- Custom keybindings for terminal and editor management
- Shades of Purple theme
- Vim emulation
- Various extensions for development (Python, Go, Docker, etc.)
- Screencast mode configuration
- Auto-save enabled

#### Git Configuration
- User information
- Performance optimizations
- Branch and tag sorting
- Push and fetch configurations
- Rebase settings

#### Homebrew Packages
Includes essential development tools and applications:
- Development tools (asdf, gcc, gradle)
- Programming languages (Python, Java)
- Cloud tools (Google Cloud SDK)
- Database tools (MySQL, PostgreSQL)
- Container tools (Docker)
- VS Code extensions

## License

MIT