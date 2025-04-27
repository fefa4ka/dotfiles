# Yabai Configuration

This is a configuration for [yabai](https://github.com/koekeishiya/yabai), a tiling window manager for macOS.

## Hotkey Mnemonics

### Window Management
- **alt - h/j/k/l**: Think "**H**orizontal and **V**ertical" for left/right/up/down navigation
- **alt + shift - h/j/k/l**: "**S**hift windows" in direction
- **alt + cmd - h/j/k/l**: "**C**hange size" (cmd is for Control/Change)
- **alt - z**: "**Z**oom to parent" (like zooming out to see parent container)
- **alt + shift - z**: "**Z**oom to fullscreen" (shift makes it more powerful)
- **alt - r**: "**R**otate" the space
- **alt - f**: "**F**loat" layout
- **alt + shift - f**: "**F**ix back to BSP" layout
- **alt - s**: "**S**ticky" window toggle
- **alt - t**: "**T**op" window toggle
- **alt - p**: "**P**icture-in-picture" mode

### Space Navigation
- **alt - [1-8]**: "**1**st space, **2**nd space" etc. (direct access)
- **alt - q/w**: "**Q**uit/previous" and "for**W**ard/next" space
- **alt + shift - q/w**: "**Q**uit/previous" and "for**W**ard/next" with window

### Scratchpad Applications
- **cmd + ctrl - t**: "**T**elegram" (T for Telegram)
- **cmd + ctrl - o**: "**O**bsidian" (O for Obsidian)
- **cmd + ctrl - l**: "**L**anguage translator" (DeepL)
- **cmd + ctrl - c**: "**C**alendar" (C for Calendar)
- **cmd + ctrl - m**: "**M**usic" (M for Music)
- **cmd + ctrl - b**: "**B**rowser UI" (Open WebUI)
- **cmd - space**: "**Space** to browse" (browser)
- **alt - space**: "**Space** for terminal" (console)

### Display Navigation
- **ctrl - [1-3]**: "**C**ontrol which display" (1st, 2nd, 3rd)
- **ctrl + cmd - left/right**: "**C**ontrol and **C**hange display" focus

## Features

- **Window Management**: Uses Binary Space Partitioning (BSP) layout
- **Opacity Settings**: Active windows are fully opaque, while inactive windows are slightly transparent
- **Mouse Control**: Move and resize windows with fn + mouse actions
- **Organized Workspaces**: Predefined spaces with specific labels
- **Scratchpad Support**: Quick access to frequently used applications

## Configuration Structure

The yabairc file is organized into logical sections:

1. **Initialization**: Loads the scripting addition
2. **Status Bar Settings**: Configures the appearance of the status bar
3. **Global Settings**: Sets focus behavior
4. **Visual Settings**: Controls window appearance and opacity
5. **Space Settings**: Configures layout, padding, and gaps
6. **Mouse Settings**: Defines mouse actions
7. **Space Labels**: Names each workspace
8. **Application Rules**: Sets up rules for different applications

## Keyboard Shortcuts

### Window Management
- **alt - z**: Toggle zoom parent
- **alt + shift - z**: Toggle zoom fullscreen
- **alt - r**: Rotate space 90 degrees
- **alt + shift - space**: Toggle float and resize to grid
- **alt - s**: Toggle sticky
- **alt - t**: Toggle topmost
- **alt - p**: Toggle sticky, topmost, and picture-in-picture
- **alt - x**: Mirror space on x-axis
- **alt - y**: Mirror space on y-axis
- **alt - o**: Toggle split

### Window Navigation
- **alt - h/j/k/l** or **alt - arrow keys**: Focus window in direction
- **alt + shift - h/j/k/l** or **alt + shift - arrow keys**: Move window in direction
- **alt + cmd - h/j/k/l** or **alt + cmd - arrow keys**: Resize window
- **alt + shift - q/w**: Move window to previous/next space
- **alt + shift - [1-8]**: Move window to specific space

### Space Navigation
- **alt - [1-8]**: Focus specific space
- **alt - q/w**: Focus previous/next space
- **alt - f**: Set space layout to float
- **alt + shift - f**: Set space layout to BSP
- **shift + alt - c**: Create space and move window to it
- **shift + cmd - c**: Create space and focus it
- **cmd + shift - w**: Destroy space

### Display Navigation
- **ctrl - [1-3]**: Focus specific display
- **ctrl + cmd - left/right**: Focus previous/next display
- **shift + alt + cmd - left/right**: Move window to previous/next display

### Scratchpad Applications
- **cmd + ctrl - t**: Toggle Telegram
- **cmd + ctrl - o**: Toggle Obsidian
- **cmd + ctrl - l**: Toggle DeepL
- **cmd + ctrl - c**: Toggle Calendar
- **cmd + ctrl - m**: Toggle Yandex Music
- **cmd + ctrl - b**: Toggle Open WebUI
- **cmd + ctrl - n**: Toggle Obsidian with ctrl-n
- **cmd - space**: Toggle Vivaldi browser
- **alt - space**: Toggle console terminal

### Other
- **meh - r**: Restart skhd and yabai services
- **cmd + shift - return**: Open Vivaldi
- **cmd + shift - u**: Open terminal menu
- **cmd + shift - g**: Open browser menu
- **cmd + shift - y**: Open YouTube menu
- **cmd + shift - d**: Open application launcher
- **cmd + shift + alt - t**: Toggle dark/light theme

## Workspace Organization

The configuration defines 5 spaces with specific purposes:

1. **Coding**: For development environments
2. **Typing**: For writing and document editing
3. **Tools**: For utilities and development tools
4. **Social**: For communication apps
5. **Float**: For apps that work better with floating windows

## Scratchpad Applications

The following applications are configured as scratchpads for quick access:

- Telegram (cmd + ctrl - t)
- Obsidian (cmd + ctrl - o)
- DeepL (cmd + ctrl - l)
- Calendar (cmd + ctrl - c)
- Open WebUI (cmd + ctrl - b)
- Vivaldi browser (cmd - space)
- Yandex Music (cmd + ctrl - m)
- Terminal with title "console" (alt - space)

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
