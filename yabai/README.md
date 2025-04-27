# Yabai Configuration

This is a configuration for [yabai](https://github.com/koekeishiya/yabai), a tiling window manager for macOS.

## Features

- **Window Management**: Uses Binary Space Partitioning (BSP) layout
- **Opacity Settings**: Active windows are fully opaque, while inactive windows are slightly transparent
- **Mouse Control**: Move and resize windows with fn + mouse actions
- **Organized Workspaces**: Predefined spaces with specific labels
- **Scratchpad Support**: Quick access to frequently used applications

## Workspace Organization

The configuration defines 5 spaces with specific purposes:

1. **Coding**: For development environments
2. **Typing**: For writing and document editing
3. **Tools**: For utilities and development tools
4. **Social**: For communication apps
5. **Float**: For apps that work better with floating windows

## Scratchpad Applications

The following applications are configured as scratchpads for quick access:

- Telegram
- Obsidian
- DeepL
- Calendar
- Open WebUI
- Vivaldi (browser)
- Yandex Music
- Terminal (with title "console")

## Floating Windows

Some applications are configured to always float:

- System Preferences
- Archive Utility
- Finder (specific windows)
- Safari (preference windows)
- App Store
- Activity Monitor
- Calculator
- Dictionary
- The Unarchiver
- Transmission
- VirtualBox
- eqMac

## Usage

### Mouse Controls

- **fn + Left Click**: Move window
- **fn + Right Click**: Resize window

### Status Bar

The configuration enables the status bar with custom colors:
- Background: `0xff354274`
- Foreground: `0xffDEE6E7`

## Installation

1. Install yabai: `brew install koekeishiya/formulae/yabai`
2. Copy this configuration to `~/.config/yabai/yabairc`
3. Make it executable: `chmod +x ~/.config/yabai/yabairc`
4. Start yabai: `brew services start yabai`

For full functionality, you'll need to [disable System Integrity Protection](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection) and install the scripting addition.
