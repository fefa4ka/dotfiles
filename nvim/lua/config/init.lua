-- Load all configuration modules
require("config.options")                   -- General Neovim options
require("config.keymaps").setup()           -- Centralized key mappings
require("config.lazy")                      -- Plugin manager setup
require("config.keymaps").setup_which_key() -- Which-key setup
require("config.ui").setup()                -- UI related settings
