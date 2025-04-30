-- Load core utilities
require('core.utils')

-- Load all configuration
require('config.init')

-- Load Lua configuration files
require('config.layout')
require('config.autocmd')
require_vim("vim/netrw.vim")
require_vim("vim/vcscommand/plugin/vcscommand.vim")
require_vim("vim/vcscommand/plugin/vcsarc.vim")

-- Configure signify signs
vim.g.signify_sign_add               = '█' -- Full block
vim.g.signify_sign_delete            = '█' -- Full block (will be colored differently)
vim.g.signify_sign_delete_first_line = '▀' -- Upper half block
vim.g.signify_sign_change            = '█' -- Full block (will be colored differently)
vim.g.signify_sign_changedelete      = '▟' -- Quadrant lower right
