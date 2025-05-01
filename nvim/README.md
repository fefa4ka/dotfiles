# My Neovim Configuration

Personal Neovim setup focused on Lua, Python, C/C++, and Flutter development. Uses `lazy.nvim` and Gruvbox theme with auto light/dark mode.

## Core Features

*   **Plugin Management:** [lazy.nvim](https://github.com/folke/lazy.nvim)
*   **Completion:** [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) (LSP, Snippets, Buffer, AI - Supermaven, cmp-ai)
*   **LSP:** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) (Python, C/C++, TS/JS, CMake, VimL, Lua)
*   **Syntax:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
*   **Snippets:** [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
*   **Fuzzy Finding:** [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim), [fzf-lua](https://github.com/ibhagwan/fzf-lua)
*   **Git:** Signify (local), VCSCommand
*   **Movement:** [hop.nvim](https://github.com/phaazon/hop.nvim)
*   **AI:** [gen.nvim](https://github.com/David-Kunz/gen.nvim) (Ollama), [Supermaven](https://github.com/supermaven-inc/supermaven-nvim), [cmp-ai](https://github.com/tzachar/cmp-ai)
*   **UI:** Gruvbox theme, Vifm explorer, Dropbar context, Startify screen, Which-key hints, Zen mode, Scope visualization, Tagbar outline, Inlay hints, Local highlighting.
*   **Session Management:** Startify, Obsession, custom scripts.
*   **Language Specific:** Flutter tools, Clangd/CCLS/ClangFormat integration.

## Installation

1.  **Backup:** Backup your existing `~/.config/nvim`.
2.  **Clone:** `git clone <repository-url> ~/.config/nvim`
3.  **Launch Neovim:** Plugins should install automatically via `lazy.nvim`. Run `:Lazy sync` if needed.
4.  **Install Dependencies:** Ensure external dependencies (listed below) are installed.
5.  **Treesitter:** Run `:TSUpdate` in Neovim.

## Dependencies

### Core Tools

*   Neovim (0.9+, 0.10+ for Dropbar)
*   Git
*   Nerd Font
*   Ripgrep (`rg`)
*   fd (`fd`)
*   Vifm
*   Ollama (and `ollama pull qwq:latest`)
*   Universal Ctags (`ctags`)
*   fzf
*   Treesitter CLI (`tree-sitter`)
*   Python 3 (for some LSPs and venv)

### Language Servers

*   **Python:** `python-lsp-server`, `ruff-lsp`, `mypy`
*   **Lua:** `lua-language-server`
*   **C/C++:** `clangd`, `ccls`, `clang-format`
*   **TypeScript/JavaScript:** `typescript`, `typescript-language-server`
*   **CMake:** `cmake-language-server`
*   **VimL:** `vim-language-server`

### Optional

*   **Flutter:** Flutter SDK, Dart SDK
*   **AI Completion:** TabNine, Supermaven (see plugin docs)
*   **Theme Script:** `/Users/fefa4ka/dotfiles/scripts/switch_theme` (or adapt `BgToggleSol` function)

## Keybindings

*   **Leader Key:** `<Space>`
*   See `lua/config/keymaps.lua` and `lua/config/which-key.lua`.
*   `which-key.nvim` provides hints after pressing `<Space>`.

## Structure

*   `init.lua`: Entry point.
*   `lua/core/`: Utilities.
*   `lua/config/`: Main configuration (options, keymaps, LSP, UI, etc.).
*   `lua/plugins/`: `lazy.nvim` plugin definitions.
*   `vim/`: Legacy Vimscript.
