return {
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'preservim/tagbar' },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('config.lsp.init')
    end,
    dependencies = {
      -- Add treesitter as a dependency to ensure it's loaded before LSP
      'nvim-treesitter/nvim-treesitter',
    }
  },
  { 'ranjithshegde/ccls.nvim' },
  { -- Autocomplete framework
    'hrsh7th/nvim-cmp',
    -- load cmp on InsertEnter
    event = "InsertEnter",
    dependencies = {
      -- Snippet engine with LSP backend
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      -- Interface between nvim-cmp and luasnip
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Snippet engine of buffer words
      'hrsh7th/cmp-buffer',
    },
    config = function()
      require('config.cmp')
    end,
  },
  { -- format code with clang-format
    'rhysd/vim-clang-format',
    config = function()
      -- require('config.vim-clang-format')
    end
  },
  {
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("inlay-hints").setup()
    end
  },

  { 'tzachar/cmp-ai',         dependencies = 'nvim-lua/plenary.nvim' },
  {
    "supermaven-inc/supermaven-nvim",
  },
  {
    dir = "/Users/fefa4ka/dotfiles/nvim/vim/signify"
  },
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',   -- optional for vim.ui.select
    },
    config = true,
  }
  -- {
  --   "linux-cultist/venv-selector.nvim",
  --     dependencies = {
  --       "neovim/nvim-lspconfig",
  --       "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
  --       { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  --     },
  --   lazy = false,
  --   branch = "regexp", -- This is the regexp branch, use this for the new version
  --   config = function()
  --       require("venv-selector").setup()
  --     end,
  --     keys = {
  --       { ",v", "<cmd>VenvSelect<cr>" },
  --     },
  -- },
}
