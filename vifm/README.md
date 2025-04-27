# Vifm Configuration

This is a modular vifm configuration designed for efficient file management with a focus on previews and keyboard-driven workflows.

## Features

- **Modular Configuration**: Split into logical components for easier maintenance
- **Rich File Previews**: Support for various file types including:
  - Images, videos, and fonts with visual previews
  - PDF and EPUB documents
  - Archives (zip, tar, etc.)
  - Markdown with syntax highlighting
  - Source code with syntax highlighting
  - Binary files with hexdump view
- **Custom Keybindings**: Optimized for productivity
- **File Classification**: Extensive file type icons and categorization

## Structure

- `vifmrc`: Main configuration file that sources all modules
- `config/`: Directory containing modular configuration files:
  - `classify.vifm`: File type icons and classifications
  - `filetypes.vifm`: File type associations and handlers
  - `mappings.vifm`: Custom keyboard shortcuts
  - `viewers.vifm`: File preview configurations
- `scripts/`: Custom scripts for enhanced functionality
  - `defviewer`: Default viewer script for file previews

## Key Bindings

- `<` and `>`: Resize panes
- `yd`: Yank (copy) current directory path to clipboard
- `yf`: Yank current file path to clipboard
- `q`: Preview file in macOS Quick Look

## Dependencies

This configuration relies on several external tools:
- `exa`: For directory tree previews
- `glow`: For Markdown rendering
- `highlight`: For syntax highlighting
- `visualpreview`: For visual file previews
- `xsv`: For CSV file viewing
- Various archive tools (`unzip`, `unrar`, etc.)

## Installation

1. Clone this repository to `~/.config/vifm/`
2. Ensure all dependencies are installed
3. Launch vifm

## Customization

Edit the modular configuration files to customize your experience:
- Add new file associations in `filetypes.vifm`
- Customize previews in `viewers.vifm`
- Add new keybindings in `mappings.vifm`
