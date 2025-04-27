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

### Core Requirements

*   **Neovim:** A recent version (0.9+ recommended, 0.10+ required for `dropbar.nvim`).
    ```bash
    # macOS
    brew install neovim
    
    # Linux
    # Ubuntu/Debian
    apt install neovim
    # Arch
    pacman -S neovim
    ```

*   **Git:** Required for `lazy.nvim` and Git features.
    ```bash
    # macOS
    brew install git
    
    # Linux
    apt install git  # Ubuntu/Debian
    ```

*   **Nerd Font:** Required for icons in UI elements.
    ```bash
    # macOS
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font  # or any other nerd font
    
    # Manual installation for any OS
    # Download from https://www.nerdfonts.com/font-downloads
    ```

*   **Ripgrep (rg):** Required for Telescope/fzf-lua search functionality.
    ```bash
    # macOS
    brew install ripgrep
    
    # Linux
    apt install ripgrep  # Ubuntu/Debian
    ```

*   **fd-find:** Improves file finding performance.
    ```bash
    # macOS
    brew install fd
    
    # Linux
    apt install fd-find  # Ubuntu/Debian
    ```

*   **Vifm:** Required for file explorer integration.
    ```bash
    # macOS
    brew install vifm
    
    # Linux
    apt install vifm  # Ubuntu/Debian
    ```

*   **Ollama:** Required for AI features with `gen.nvim`.
    ```bash
    # macOS
    curl -fsSL https://ollama.com/install.sh | sh
    
    # After installation, pull the required model
    ollama pull qwq:latest
    ```

*   **Universal Ctags:** Required for `tagbar` plugin.
    ```bash
    # macOS
    brew install universal-ctags
    
    # Linux
    apt install universal-ctags  # Ubuntu/Debian
    ```

### Language Servers

*   **Python:**
    ```bash
    # Python LSP Server
    pip install python-lsp-server
    
    # Ruff LSP (linter/formatter)
    pip install ruff-lsp
    
    # MyPy for type checking
    pip install mypy
    ```

*   **Lua:**
    ```bash
    # Lua Language Server
    brew install lua-language-server  # macOS
    # For Linux, download from GitHub: https://github.com/LuaLS/lua-language-server/releases
    ```

*   **C/C++:**
    ```bash
    # Clangd
    brew install llvm  # macOS (includes clangd)
    apt install clangd  # Ubuntu/Debian
    
    # CCLS (alternative C/C++ server)
    brew install ccls  # macOS
    apt install ccls  # Ubuntu/Debian
    
    # Clang-format (formatter)
    brew install clang-format  # macOS
    apt install clang-format  # Ubuntu/Debian
    ```

*   **TypeScript/JavaScript:**
    ```bash
    # TypeScript Language Server
    npm install -g typescript typescript-language-server
    ```

*   **CMake:**
    ```bash
    # CMake Language Server
    pip install cmake-language-server
    ```

*   **Vim/VimL:**
    ```bash
    # Vim Language Server
    npm install -g vim-language-server
    ```

### Flutter Development (Optional)

*   **Flutter SDK:**
    ```bash
    # macOS
    brew install --cask flutter
    
    # Manual installation for any OS
    # https://docs.flutter.dev/get-started/install
    ```

*   **Dart SDK:** (Usually included with Flutter)
    ```bash
    # If needed separately
    brew install dart  # macOS
    ```

### Additional Tools

*   **fzf:** Command-line fuzzy finder used by fzf-lua.
    ```bash
    # macOS
    brew install fzf
    
    # Linux
    apt install fzf  # Ubuntu/Debian
    ```

*   **Treesitter CLI:** For parser compilation.
    ```bash
    # macOS
    brew install tree-sitter
    
    # Linux
    npm install -g tree-sitter-cli
    ```

*   **External Theme Script:** The script `/Users/fefa4ka/dotfiles/scripts/switch_theme` is used for toggling light/dark mode. You may need to create your own version of this script or modify the configuration to use a different theme switching mechanism.

### Python Virtual Environment Support (Optional)

*   **Python venv:**
    ```bash
    # Already included with Python 3
    # To create a virtual environment
    python -m venv .venv
    ```

### AI Completion Tools (Optional)

*   **TabNine:** For AI code completion.
    ```bash
    # Install via npm
    npm install -g tabNine
    ```

*   **Supermaven:** Follow installation instructions at https://github.com/supermaven-inc/supermaven-nvim

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
