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

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/dotfiles.git
   ```

2. Create symlinks:
   ```
   ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
   ```

3. Install TPM (Tmux Plugin Manager):
   ```
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

4. Start tmux and install plugins:
   Press `Prefix + I` to install plugins

## Theme Switching

The theme automatically switches based on your macOS appearance settings. To manually switch:

```
~/dotfiles/tmux/theme-switch.sh
```

## Dependencies

- tmux 3.0+ 
- reattach-to-user-namespace (for clipboard integration)
- TPM (Tmux Plugin Manager)
