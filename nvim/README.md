# My Neovim Configuration

Personal Neovim setup focused on Lua, Python, C/C++, Bash, CMake, TypeScript/JavaScript, and Flutter development. Uses `lazy.nvim` and Gruvbox theme with automatic light/dark mode switching via `auto-dark-mode.nvim`.

## Core Features

*   **Plugin Management:** [lazy.nvim](https://github.com/folke/lazy.nvim)
*   **Completion:** [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with sources:
    *   LSP ([cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp))
    *   Snippets ([cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip))
    *   Buffer ([cmp-buffer](https://github.com/hrsh7th/cmp-buffer))
    *   AI: [Supermaven](https://github.com/supermaven-inc/supermaven-nvim), [cmp-ai](https://github.com/tzachar/cmp-ai) (Ollama backend via `gen.nvim`)
*   **LSP:** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) configured for:
    *   Lua (`lua_ls`)
    *   Python (`pylsp`, `ruff`)
    *   TypeScript/JavaScript (`ts_ls`)
    *   C/C++ (`clangd`, `ccls`)
    *   Bash (`bashls`)
    *   CMake (`cmake`)
    *   VimL (`vimls`)
*   **Syntax Highlighting & More:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (Highlighting, Indentation, Autotag)
*   **Snippets:** [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
*   **Fuzzy Finding:** [fzf-lua](https://github.com/ibhagwan/fzf-lua) (Primary), [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (with `telescope-ag` for live grep)
*   **Git Integration:** Signify (local version for diff signs), VCSCommand (legacy Vimscript)
*   **Movement:** [hop.nvim](https://github.com/phaazon/hop.nvim) for quick jumps.
*   **AI Integration:**
    *   [gen.nvim](https://github.com/David-Kunz/gen.nvim): Ollama interaction (model: `qwq:latest`).
    *   [Supermaven](https://github.com/supermaven-inc/supermaven-nvim): Cloud-based AI completion.
    *   [cmp-ai](https://github.com/tzachar/cmp-ai): Completion source using `gen.nvim`.
    *   [aider.nvim](https://github.com/joshuavial/aider.nvim): Integration with the Aider coding assistant.
*   **UI Enhancements:**
    *   Theme: [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) with [auto-dark-mode.nvim](https://github.com/f-person/auto-dark-mode.nvim).
    *   File Explorer: [vifm.vim](https://github.com/vifm/vifm.vim).
    *   Context Breadcrumbs: [dropbar.nvim](https://github.com/Bekaboo/dropbar.nvim).
    *   Start Screen: [vim-startify](https://github.com/mhinz/vim-startify).
    *   Key Hints: [which-key.nvim](https://github.com/folke/which-key.nvim).
    *   Focus Mode: [zen-mode.nvim](https://github.com/folke/zen-mode.nvim).
    *   Code Structure Outline: [preservim/tagbar](https://github.com/preservim/tagbar).
    *   Inlay Hints: [MysticalDevil/inlay-hints.nvim](https://github.com/MysticalDevil/inlay-hints.nvim).
    *   Visual Aids: [local-highlight.nvim](https://github.com/tzachar/local-highlight.nvim), [scope.nvim](https://github.com/tiagovla/scope.nvim), [mini.icons](https://github.com/echasnovski/mini.icons), [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons).
    *   UI Elements: [dressing.nvim](https://github.com/stevearc/dressing.nvim) for `vim.ui`.
*   **Session Management:** [vim-startify](https://github.com/mhinz/vim-startify), [vim-obsession](https://github.com/tpope/vim-obsession), custom autocmds for auto-saving/loading.
*   **Formatting:**
    *   C/C++: [vim-clang-format](https://github.com/rhysd/vim-clang-format).
    *   Shell: `shfmt` via autocmd.
    *   Python: `ruff` via LSP action (organize imports on save).
*   **Language Specific:**
    *   [nvim-flutter/flutter-tools.nvim](https://github.com/nvim-flutter/flutter-tools.nvim).
    *   [ranjithshegde/ccls.nvim](https://github.com/ranjithshegde/ccls.nvim).

## Installation

1.  **Backup:** Backup your existing `~/.config/nvim` and other relevant dotfiles (`~/.zshrc`, `~/.tmux.conf`).
2.  **Clone:** `git clone <repository-url> ~/dotfiles` (or your chosen location).
3.  **Run Deploy Script:** Navigate to the cloned directory and run `./deploy`. This script will:
    *   Check for and offer to install necessary system packages (Neovim, Zsh, Tmux, fzf, etc.).
    *   Check for and offer to install common development tools and Neovim dependencies (`ripgrep`, `fd`, `ctags`, `python3`, `shfmt`, `clangd`, etc.).
    *   Offer to install Node.js/npm if missing.
    *   Install required global npm packages (including some LSPs like `typescript-language-server`, `bash-language-server`).
    *   Offer to install Python 3/pip if missing.
    *   Install required global pip packages (including LSPs like `python-lsp-server`, `ruff-lsp`, `cmake-language-server`, and tools like `aider-chat`).
    *   Check for `ollama` and remind you to install it manually if needed.
    *   Offer to back up existing dotfiles.
    *   Create symbolic links for `nvim`, `zsh`, and `tmux` configurations.
    *   Attempt to sync Neovim plugins using `lazy.nvim`.
4.  **Launch Neovim:** If the deploy script didn't sync plugins (e.g., Neovim wasn't installed initially), launch `nvim` and run `:Lazy sync`.
5.  **Treesitter:** Run `:TSUpdate` in Neovim to install/update parsers.
6.  **Ollama Model:** If using Ollama, ensure you have pulled the model specified in `lua/plugins/ollama.lua` (e.g., `ollama pull qwq:latest`).

## Dependencies

The `deploy` script attempts to install most dependencies. Manual installation might be required if the script fails or for optional components.

### Core Tools (Handled by `deploy` script where possible)

*   **Neovim:** 0.9+ (0.10+ recommended)
*   **Package Manager:** Git (Assumed present)
*   **Font:** A Nerd Font (Optional install via `deploy` on macOS, manual otherwise)
*   **Search:** Ripgrep (`rg`), fd (`fd`)
*   **File Manager:** Vifm
*   **Code Outline:** Universal Ctags (`ctags`)
*   **Fuzzy Finder Backend:** fzf
*   **Syntax Parser:** Treesitter CLI (`tree-sitter`)
*   **Scripting:** Python 3, pip3
*   **Shell Formatter:** `shfmt`
*   **Node.js/npm:** For installing JS/TS LSPs etc.

### Language Servers & Linters (Handled by `deploy` script via system packages, npm, or pip)

*   **Python:** `python-lsp-server[all]`, `ruff-lsp`, `mypy` (via pip)
*   **Lua:** `lua-language-server` (via system package manager)
*   **C/C++:** `clangd`, `clang-format` (via system package manager)
    *   *Note:* `ccls` is configured but not installed by the script due to potential build complexities. Install manually if needed.
*   **TypeScript/JavaScript:** `typescript`, `typescript-language-server` (via npm)
*   **CMake:** `cmake-language-server` (via pip)
*   **VimL:** `vim-language-server` (via npm)
*   **Bash:** `bash-language-server` (via npm)

### AI Tools

*   **Ollama:** **Manual Install Required** from [ollama.com](https://ollama.com/). The `deploy` script will remind you if it's missing. Remember to pull the model (e.g., `ollama pull qwq:latest`).
*   **Aider:** `aider-chat` (Installed via pip by `deploy` script). Requires separate configuration (API keys or local model setup) for actual use.
*   **Supermaven:** Requires manual account setup/API key if using the cloud service.

### Optional / External

*   **Flutter:** Flutter SDK, Dart SDK (**Manual Install Required**)
*   **Theme Switching Script:** The `BgToggleSol` function in `lua/core/utils.lua` calls `/Users/fefa4ka/dotfiles/scripts/switch_theme`. Adapt or remove this if you don't use an external script for system-wide theme changes.

## Keybindings

*   **Leader Key:** `<Space>`
*   See `lua/config/keymaps.lua` for base mappings and LSP mappings.
*   `which-key.nvim` provides hints after pressing `<Space>` (leader key). See `lua/config/keymaps.lua` (`setup_which_key` function) for `which-key` specific groups (AI, VCS, Diagnostics, etc.).

## Structure

*   `init.lua`: Main entry point, loads core utils and configs.
*   `lazy-lock.json`: Managed by `lazy.nvim`, tracks plugin commits.
*   `lua/core/`: Core utility functions (`utils.lua`).
*   `lua/config/`: Main configuration modules:
    *   `init.lua`: Loads other config modules.
    *   `options.lua`: General Neovim settings (`vim.opt`).
    *   `keymaps.lua`: Centralized keybindings, including `which-key` setup.
    *   `lazy.lua`: `lazy.nvim` plugin manager setup and plugin list entry (`plugins` directory).
    *   `ui.lua`: UI-related settings and plugin configurations (theme, icons, hop, startify, etc.).
    *   `cmp.lua`: `nvim-cmp` (completion) configuration.
    *   `lsp/`: Language Server Protocol configurations:
        *   `init.lua`: Entry point, loads common settings and language-specific files.
        *   `*.lua`: Configuration for specific language servers (python, lua, cpp, etc.).
        *   `treesitter.lua`: `nvim-treesitter` configuration.
    *   `autocmd.lua`: Custom autocommands (e.g., whitespace trimming, session management).
    *   `layout.lua`: Keyboard layout mappings (e.g., Russian).
*   `lua/plugins/`: `lazy.nvim` plugin specifications (grouped by functionality like `lsp.lua`, `ui.lua`, `ollama.lua`).
*   `vim/`: Legacy Vimscript files (e.g., `netrw.vim`, `vcscommand`).
*   `deploy`: Shell script to automate installation and setup.
