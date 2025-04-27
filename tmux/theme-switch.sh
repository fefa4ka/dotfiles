#!/bin/zsh

# Check if macOS is in Dark Mode
if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q 'Dark'; then
    # Dark mode is active
    tmux source-file ~/dotfiles/tmux/tmux.dark.theme
    echo "Switched to dark theme"
else
    # Light mode is active
    tmux source-file ~/dotfiles/tmux/tmux.light.theme
    echo "Switched to light theme"
fi

# Refresh tmux
tmux refresh-client
