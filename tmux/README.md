# Tmux Configuration

This directory contains my personal tmux configuration files that provide a customized terminal multiplexer experience with automatic theme switching based on macOS appearance settings.

## Features

- **Automatic Theme Switching**: Automatically switches between light and dark themes based on macOS system appearance
- **Vim-like Navigation**: Seamless navigation between tmux panes and vim splits
- **Mouse Support**: Full mouse integration for pane selection, resizing, and scrolling
- **Custom Keybindings**: Intuitive keyboard shortcuts for efficient workflow
- **Clipboard Integration**: Copy to system clipboard directly from tmux
- **Plugin Support**: Integration with useful tmux plugins

## Files Overview

- `tmux.conf`: Main configuration file with core settings
- `tmux-keybindings.conf`: All keyboard shortcuts and bindings
- `tmux-theme.conf`: Theme configuration and status bar styling
- `tmux.dark.theme`: Dark mode specific theme settings
- `tmux.light.theme`: Light mode specific theme settings
- `theme-switch.sh`: Script to manually switch between themes
- `tmuxinator.zsh`: ZSH completion for tmuxinator

## Key Bindings

| Binding | Action |
|---------|--------|
| `` ` `` | Prefix key |
| `Prefix + -` | Split window horizontally |
| `Prefix + \` | Split window vertically |
| `Prefix + r` | Reload tmux configuration |
| `Ctrl + h/j/k/l` | Navigate panes (works with Vim integration) |
| `Shift + Left/Right` | Switch windows |
| `Prefix + Tab` | Switch to last window |
| `Ctrl + Shift + Arrow` | Resize pane |
| `Shift + Arrow` | Swap panes |
| `Escape` | Enter copy mode |
| `Prefix + b` | List buffers |
| `Prefix + p` | Paste from buffer |
| `Prefix + P` | Choose buffer to paste from |
| `Prefix + C-s` | Save session |
| `Prefix + C-r` | Restore session |
| `Prefix + t` | Open quick popup terminal |
| `Prefix + /` | Search backward |
| `Prefix + C-f` | Search forward |
| `Prefix + v` | Begin selection |
| `Prefix + m` | Mark pane |
| `Prefix + M` | Unmark pane |
| `Prefix + i` | Swap with marked pane |
| `Prefix + S` | Quick session switch |
| `Prefix + X` | Kill session |
| `Prefix + x` | Kill pane |
| `Prefix + &` | Kill window |
| `Prefix + K` | Clear screen |

## Installation

This configuration is typically managed as part of a larger dotfiles repository.

1.  **Clone Dotfiles:** Ensure the dotfiles repository containing this tmux configuration is cloned (e.g., to `~/dotfiles`).
2.  **Run Deploy Script:** Execute the main `deploy` script located in the root of the dotfiles repository. This script handles:
    *   Installing `tmux` and `tmuxinator` if missing.
    *   Backing up any existing `~/.tmux.conf`.
    *   Creating a symbolic link from `~/dotfiles/tmux/tmux.conf` to `~/.tmux.conf`.
3.  **Install TPM & Plugins:**
    *   Install TPM (Tmux Plugin Manager) if you haven't already:
        ```bash
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        ```
    *   Launch `tmux`.
    *   Press `Prefix + I` (Shift+I) to fetch and install plugins defined in `tmux.conf`.

## Theme Switching

The theme automatically switches based on your macOS appearance settings. To manually switch:

```
~/dotfiles/tmux/theme-switch.sh
```

## Dependencies

- tmux 3.0+ 
- reattach-to-user-namespace (for clipboard integration on macOS)
- zsh (for running theme-switch.sh)
- tmuxinator (for tmux project management)
- TPM (Tmux Plugin Manager)
