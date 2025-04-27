# Zsh Configuration

This directory contains the configuration files for the Zsh shell environment.

## Structure

The configuration is modularized into several files:

*   `zshrc.sh`: The main configuration file. It sources other files, sets options, and initializes plugins and settings.
*   `zshrc_manager.sh`: Seems to be the entry point, potentially handling environment setup (like Tmux) before sourcing `zshrc.sh`.
*   `alias.sh`: Defines various command aliases for brevity and convenience.
*   `keybindings.sh`: Sets up custom keybindings using `zle` for enhanced shell interaction.
*   `prompt.sh`: Configures the shell prompt, including Git status information and SSH indicators.
*   `toolchain.sh`: Sets up environment variables and paths for specific development toolchains (ESP-IDF, Zephyr, Yandex Cloud, etc.).

## Features

### Core Settings (`zshrc.sh`)

*   Sets `stty -ixon` for Vim mappings.
*   Displays a random tip using `glow`.
*   Sources environment variables (`~/dotfiles/.env`), Cargo environment (`~/.cargo/env`), and aliases.
*   Initializes FZF (`~/.fzf.zsh`).
*   Sources various components mimicking Oh My Zsh's structure (history, key-bindings, completion) from `~/dotfiles/zsh/plugins/oh-my-zsh/lib/`.
*   Loads plugins:
    *   `vi-mode.plugin.zsh`
    *   `zsh-autosuggestions`
    *   `zsh-syntax-highlighting`
*   Sets up custom keybindings by sourcing `keybindings.sh`.
*   Configures fuzzy history search with arrow keys.
*   Sources the custom prompt (`prompt.sh`).
*   Sets up Zsh completion system (`compinit`).
*   Sources toolchain configurations (`toolchain.sh`).
*   Defines a `tm` function for easy Tmux session management with FZF.
*   Defines a `feh` function wrapper for `macfeh`.
*   Configures FZF path, auto-completion, and key bindings.
*   Sets custom `MANPAGER` and `LESS` options.
*   Extensive history configuration (`HISTSIZE`, `SAVEHIST`, various `setopt HIST_*` options).
*   Integrates `atuin` for enhanced shell history.
*   Includes experimental prompt overwriting logic using `preexec` and `precmd` hooks.

### Aliases (`alias.sh`)

*   Connection aliases (`console`, `tty`, `cam`).
*   Utility aliases (`grep`, `g` for lazygit, `v`/`vi`/`vim` for nvim, `mutt` for neomutt, `h` for howdoi, `cat` for bat, `ls`/`la`/`ll`/`lt` for exa).
*   Navigation aliases (`c` wrapper for `cd`, `..`, `...`, etc.).
*   Configuration editing aliases (`cf`, `cfv`, `cfz`, etc.).
*   Global pip installation aliases (`gpip`, `gpip3`).

### Keybindings (`keybindings.sh`)

*   `^u`: Go up one directory (`cd ..`).
*   `^v`: Edit the last command (`fc`).
*   `^s`: Prepend `sudo` to the current command.
*   `^g`: Change directory using `fd` and `fzf`.
*   `^o`: Open file(s) using `fd`, `fzf`, and `open`.
*   `^p`: Open file(s) in `$EDITOR` using `fd` and `fzf`.

### Prompt (`prompt.sh`)

*   Customizable prompt showing:
    *   SSH connection info (user@host).
    *   Current directory (`~` for home).
    *   Git repository status (branch, divergence, staged/modified/untracked files).
    *   Prompt character (`❯` or `#` for root) colored based on the last command's exit status.

### Toolchain (`toolchain.sh`)

*   Sets up paths and environment variables for:
    *   ESP-IDF (`get_idf` alias).
    *   Specific Node.js version.
    *   Binutils.
    *   RISC-V GCC toolchain.
    *   Zephyr project (GNU Arm Embedded Toolchain, Espressif toolchain).
    *   Yandex Cloud CLI.
