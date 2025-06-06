# Awesome Dotfiles
Simple, but extensive customization of ZSH, TMUX, and Vim.

[![VideoWalkthrough](https://img.youtube.com/vi/UgDz_9i2nwc/0.jpg)](https://www.youtube.com/watch?v=UgDz_9i2nwc)

## Setup Options

There's 3 ways in which you can use this, depending on how much you think you'll be customizing.

One of the key features is that this implementation stays in sync across all your machines. So depending on how much you'd like to customize your configuration, you have a few options:

-   Little Customization: Just clone this repo and jump to [Installation](#installation).
-   Mild Customization: [Fork]() this repo, and clone your own fork. Keep an eye on this repo for bugfixes and other improvements that you'd like to incorporate into your fork. Then jump to [Installation](#installation).
-   Most Customization: Building your own dotfiles from scratch! Read through these docs, watch the video above, star this repo, and create your own dotfiles! You can add this repository as a [git module](https://git-scm.com/book/en/v2/Git-Tools-Submodules) and source the parts you like.

    If you're unsure, just read the docs, watch the video, clone this repository, and jump to [Installation](#installation).

## Installation

Once the repo is cloned, execute the deploy script:

```
./deploy
```

This script guides you through the following:

1. Checks to see if you have zsh, tmux, and nvim installed.
2. Installs it using your default package manager if you don't have it installed.
3. Checks to see if your default shell is zsh.
4. Sets zsh to your default shell.
5. Backs up your old configuration files.

Pretty convenient for configuring new servers.

# Summary of Changes

## Basic runtime operations

All default dotfiles (`.zshrc`, `init.vim`, etc) source something within the dotfiles repository. This helps separate changes that are synced across all your machines with system specific changes.

Upon launching a new shell, the first thing that's evaluated is `zshrc_manager.sh`. This script first launches tmux. Then once zsh logs in, within tmux, it updates the dotfiles repository, and sources the changes.

## [Zsh](https://en.wikipedia.org/wiki/Z_shell)

* `cd` has been reassigned to `cd` and `ls`. Every time you navigate to a new directory, it will display the contents of that directory.
* `v` has been aliased too: `nvim -p`. This let's you open multiple files in vim as tabs.

### Prompt

The prompt takes on the form:

```
[plugin, plugin, ...]:
```

Each plugin is sensitive to where you are and what you're doing, they reveal themselves when it's contextually relevant. Plugins include:

* `PWD plugin`: always present, tells you where you are. Always the first plugin.
* `Status code plugin`: appears anytime a program returns with a non-zero status code. Tells you what status code the program completed with.
* `Git plugin`: appears when you're in a git repository. Tells you what branch you're on, and how many files have been changed since the last commit.
* `Sudo plugin`: tells you when you can sudo without a password. Or when you're logged in as root.
* `Time plugin`: appears when a program took more than 1s to execute. Tells you how long it took to execute.
* `PID plugin`: appears when you background a task. Tells you what the PID of the task is.

### Keybindings

| Shell              | What It Does                                               |
| ------------------ | ---------------------------------------------------------- |
| `Ctrl-o`           | Open some file                                             |
| `Ctrl-u`           | Runs `cd ..`                                               |
| `Ctrl-g`           | Go to folder                                               |
| `Ctrl-p`           | Edit file in editor                                        |
| `Ctrl-s`           | Add's `sudo` to the beginning of the buffer.               |
| `Ctrl-n`           | Open notes                                                 |

| Runners             |                                                           |
| --------------------| ----------------------------------------------------------|
| `Cmd-Return`        | Shell                                                     |
| `Cmd-Shift-Return`  | Browser                                                   |
| `Cmd-F` `RCmd-Ret`  | File Manager - Vifm                                       |
| `Cmd-V`             | Vim                                                       |

| Helpers            |                                                            |
| -------------------| ---------------------------------------------------------- |
| `Cmd-Shift-U`      | Serial ports                                               |
| `Cmd-Shift-M`      | Tmux sessions                                              |
| `Cmd-Shift-Y`      | Y.VM                                                       |
| `Cmd-Shift-H`      | How Do I                                                   |
| `Cmd-Shift-@`      | Remind                                                     |
| `Cmd-Shift-#`      | Note                                                       |

| Window Management  |                                                            |
| -------------------| ---------------------------------------------------------- |
| `Ctrl-Alt-Shift`   | Meh                                                        |
| `Alt-[Zz]`         | Fullscreen / Section fullscreen                            |
| `Alt-b`            | Toggle bar                                                 |
| `meh-R`            | Reload yabai, skhd, spacebar                               |
| Arrange                                                                         |
| `Alt-x`            | Mirrror x-axis                                             |
| `Alt-y`            | Mirrror y-axis                                             |
| `Alt-o`            | Toggle Split                                               |
| Windows                                                                         |
| `Alt-Shift-[hjkl]` | Move window                                                |
| `Alt-Cmd-[hjkl]`   | Resize window                                              |
| `Alt-Ctrl-[hjkl]`  | Warp window                                                |
| `Alt-Shift-[qw]`   | Move window to near space                                  |
| Floating Windows                                                                |
| `Alt-Shift-Space`  | Toggle float Window                                        |
| `Alt-[Ff]`         | Toggle float Space                                         |
| `Alt-s`            | Toggle Stick                                               |
| `Alt-t`            | Toggle Topmost                                             |
| `Alt-p`            | Toggle PiP (stick, topmost, pip)                           |
| `Alt-Shift-Cmd-[hjkl]` | Fill left/center/full/right                            |
| Displays                                                                        |
| `Ctrl-[123]`       | Focus display N                                            |
| `Ctrl-Cmd-[qw]`    | Focus prev/next display                                    |
| `Ctrl-Shift-[123]` | Move Space to N display                                    |
| Spaces                                                                          |
| `Alt-[1-9]`        | Select N Space                                             |
| `Ctrl-Shift-[qw]`  | Move Space back/next                                       |
| `Cmd-Shift-c`      | Create space                                               |
| `Cmd-Alt-c`        | Create space for window                                    |
| `Cmd-Shift-w`      | Destroy Space                                              |

| Vim                |                                                            |
| -------------------| ---------------------------------------------------------- |
| `q[abc]`           | Record action                                              |
| `H`                | Show documentation                                         |

#### Vim
| Vim / Navigation   |                                                            |
| -------------------| ---------------------------------------------------------- |
| `[c ]c`            | Hunks navigation                                           |
| `[g ]g`            | Diagnostics navigation                                     |

| Vim / Git            |                                                          |
| ---------------------| ---------------------------------------------------------|
| `<leader> - i`       | Blame                                                    |
| `[c ]c`              | Hunks navigation                                         |
| `<leader> - hp`      | Hunk preview                                             |
| `<leader> - hs / hu` | Hunk save / undo                                         |

| Vim / C Formatter  |                                                            |
| -------------------| ---------------------------------------------------------- |
| Ctrl-K             | Format seleter                                             |

### Plugins
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): Searches your history while you type and provides suggestions.
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/tree/ad522a091429ba180c930f84b2a023b40de4dbcc): Provides fish style syntax highlighting for zsh.
* [ohmyzsh](https://github.com/robbyrussell/oh-my-zsh/tree/291e96dcd034750fbe7473482508c08833b168e3): Borrowed things like tab completion, fixing ls, tmux's vi-mode plugin.
* [vimode-zsh](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/vi-mode) allows you to hit `esc` and navigate the current buffer using vim movement keys.

## [Vim](<https://en.wikipedia.org/wiki/Vim_(text_editor)>)
* Leader key has ben remapped to `<space>`

## [Tmux](https://en.wikipedia.org/wiki/Tmux)

The tmux configuration has been completely refactored into a modular structure with theme support. See the [tmux README](tmux/README.md) for detailed documentation.

Key features:
* Prefix key is backtick (`) instead of Ctrl-B
* Automatic theme switching based on macOS appearance (light/dark)
* Vim-style navigation between panes with Ctrl+hjkl
* Mouse support for scrolling, selecting, and resizing
* Clipboard integration with system clipboard
* Status bar shows session, user, and hostname

All tmux configuration files are in the `tmux/` directory:
* `tmux.conf` - Main configuration
* `tmux-keybindings.conf` - All key bindings
* `tmux-theme.conf` - Theme configuration
* `tmux.dark.theme` and `tmux.light.theme` - Theme-specific settings
