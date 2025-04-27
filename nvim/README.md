# My Neovim Configuration

This repository contains my personal Neovim configuration, tailored for development with a focus on Lua, Python, C/C++, and Flutter. It leverages `lazy.nvim` for plugin management and features a Gruvbox theme with
automatic light/dark mode switching.

<!-- Add a screenshot here if desired -->
<!-- ![Screenshot](path/to/screenshot.png) -->

## Features

**Core Editing & Development:**

*   **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, declarative plugin management.
*   **Completion:** [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) provides autocompletion powered by:
    *   LSP servers (`cmp-nvim-lsp`)
    *   Snippets ([LuaSnip](https://github.com/L3MON4D3/LuaSnip))
    *   Buffer contents (`cmp-buffer`)
    *   File paths (`cmp-path`)
    *   AI suggestions ([Supermaven](https://github.com/supermaven-inc/supermaven-nvim), [cmp-ai](https://github.com/tzachar/cmp-ai))
*   **LSP Integration:** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) for language server protocol support. Configured servers include:
    *   Python: `pylsp`, `ruff`
    *   C/C++: `clangd`, `ccls`
    *   TypeScript: `ts_ls`
    *   CMake
    *   VimL (`vimls`)
    *   Features: Diagnostics, code actions, formatting, go-to-definition/references/implementation, hover information, signature help, renaming.
*   **Syntax Highlighting:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for accurate and fast syntax highlighting, indentation, and text objects.
*   **Snippets:** [LuaSnip](https://github.com/L3MON4D3/LuaSnip) for code snippets, integrated with `nvim-cmp`.
*   **Fuzzy Finding:** [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) and [fzf-lua](https://github.com/ibhagwan/fzf-lua) for finding files, buffers, commands, help tags, LSP
references/definitions, live grep, etc.
*   **Git Integration:**
    *   [Signify](https://github.com/mhinz/vim-signify) (local version) displays Git diff markers in the sign column.
    *   VCSCommand (Vimscript plugin) for various VCS operations.
*   **Movement:** [hop.nvim](https://github.com/phaazon/hop.nvim) allows rapid cursor movement.
*   **AI Integration:**
    *   [gen.nvim](https://github.com/David-Kunz/gen.nvim) connected to a local Ollama instance for code generation, fixing, commenting, etc.
    *   [Supermaven](https://github.com/supermaven-inc/supermaven-nvim) for AI-powered code completion.
    *   [cmp-ai](https://github.com/tzachar/cmp-ai) integrates AI suggestions into the completion menu.

**User Interface:**

*   **Theme:** [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) with automatic light/dark mode switching via [auto-dark-mode.nvim](https://github.com/f-person/auto-dark-mode.nvim) and an external script.
*   **File Explorer:** Uses [vifm.vim](https://github.com/vifm/vifm.vim) integration, replacing the default netrw.
*   **Code Context:** [dropbar.nvim](https://github.com/Bekaboo/dropbar.nvim) provides breadcrumbs based on code structure (requires Neovim 0.10+).
*   **Start Screen:** [vim-startify](https://github.com/mhinz/vim-startify) provides a dashboard on startup.
*   **Keybinding Hints:** [which-key.nvim](https://github.com/folke/which-key.nvim) displays available keybindings following the leader key.
*   **Focus Mode:** [zen-mode.nvim](https://github.com/folke/zen-mode.nvim) for distraction-free writing/coding.
*   **Scope Visualization:** [scope.nvim](https://github.com/tiagovla/scope.nvim) helps visualize code scopes (e.g., function boundaries).
*   **Symbol Outline:** [tagbar](https://github.com/preservim/tagbar) shows a sidebar with code symbols/tags.
*   **Inlay Hints:** [inlay-hints.nvim](https://github.com/MysticalDevil/inlay-hints.nvim) displays contextual information directly in the code.
*   **Local Highlighting:** [local-highlight.nvim](https://github.com/tzachar/local-highlight.nvim) highlights occurrences of the word under the cursor.
*   **Session Management:** Uses `vim-startify` and `vim-obsession` along with custom Vimscript for persistent sessions per project directory.

**Language Specific:**

*   **Flutter:** [flutter-tools.nvim](https://github.com/nvim-flutter/flutter-tools.nvim) provides tools for Flutter development.
*   **C/C++:** Integration with `clangd`, `ccls`, and [vim-clang-format](https://github.com/rhysd/vim-clang-format).

## Installation

1.  **Backup:** Back up your existing Neovim configuration (`~/.config/nvim`).
2.  **Clone:** Clone this repository to `~/.config/nvim`:
    ```bash
    git clone <repository-url> ~/.config/nvim
    ```
3.  **Install Plugins:** Launch Neovim. `lazy.nvim` should automatically install the plugins. You might need to run `:Lazy sync` if anything goes wrong.
4.  **Install Dependencies:** Ensure you have installed the necessary external dependencies (see below).
5.  **Treesitter Parsers:** Run `:TSUpdate` in Neovim to install configured Treesitter parsers.

## Dependencies

*   **Neovim:** A recent version (0.9+ recommended, 0.10+ required for `dropbar.nvim`).
*   **Git:** Required for `lazy.nvim` and Git features.
*   **Nerd Font:** Required for icons in UI elements (e.g., `fzf-lua`, `dropbar`, custom netrw icons if used).
*   **Language Servers:** Install the LSP servers for the languages you use (e.g., `clangd`, `python-lsp-server`, `ruff-lsp`, `typescript-language-server`, `cmake-language-server`).
*   **Formatters/Linters:** Install tools used by LSP or plugins (e.g., `clang-format`, `ruff`).
*   **Treesitter CLI:** May be needed for `nvim-treesitter` if `auto_install` is enabled and parsers aren't pre-compiled.
*   **Ripgrep (rg):** Recommended for `telescope.nvim`'s live grep functionality.
*   **fd:** Optional, can improve file finding performance with Telescope/fzf-lua.
*   **Ollama:** Required for the `gen.nvim` AI features. Ensure the specified model (`qwq:latest`) is pulled (`ollama pull qwq:latest`).
*   **Vifm:** Required for the file explorer integration.
*   **External Theme Script:** The script `/Users/fefa4ka/dotfiles/scripts/switch_theme` is used for toggling light/dark mode.

## Keybindings

*   **Leader Key:** `<Space>`
*   Refer to `lua/config/keybindings.lua` and `lua/config/which-key.lua` for detailed mappings.
*   `which-key.nvim` will pop up hints after pressing the leader key.
*   Common actions are mapped under leader sequences (e.g., `<leader>f` for Telescope/FzfLua, `<leader>h` for help, `<leader>a` for AI, `<leader>l` for LSP actions).

## Structure

*   `init.lua`: Main entry point, loads other configuration files.
*   `lua/core/`: Core utility functions.
*   `lua/config/`: Configuration for Neovim options, plugins, keybindings, LSP, etc.
*   `lua/plugins/`: Plugin specifications for `lazy.nvim`.
*   `vim/`: Legacy Vimscript configurations (e.g., netrw, layout, autocmds).
*   `nvim/lsp/`: Contains `coc-settings.json` (potentially unused/outdated given the Lua LSP setup).

---
