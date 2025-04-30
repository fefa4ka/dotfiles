-- Load core utilities
require('core.utils')

-- Load all configuration
require('config.init')

require_vim("vim/netrw.vim")
require_vim("vim/layout.vim")
require_vim("vim/autocmd.vim")
require_vim("vim/vcscommand/plugin/vcscommand.vim")
require_vim("vim/vcscommand/plugin/vcsarc.vim")

vim.g.signify_sign_add               = '█' -- Full block
vim.g.signify_sign_delete            = '█' -- Full block (will be colored differently)
vim.g.signify_sign_delete_first_line = '▀' -- Upper half block
vim.g.signify_sign_change            = '█' -- Full block (will be colored differently)
vim.g.signify_sign_changedelete      = '▟' -- Quadrant lower right

-- Ensure signify highlights are applied after the color scheme or plugin initialization
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Customize signify signs with both foreground and background colors
    vim.api.nvim_set_hl(0, "SignifySignAdd", { fg = "#98971a", bg = "NONE" })  -- Green text, dark gray background
    vim.api.nvim_set_hl(0, "SignifySignDelete", { fg = "#cc241d", bg = "NONE" }) -- Red text, dark gray background
    vim.api.nvim_set_hl(0, "SignifySignChange", { fg = "#d79921", bg = "NONE" }) -- Yellow text, dark gray background
    vim.api.nvim_set_hl(0, "SignifySignChange", { fg = "#d79921", bg = "NONE" }) -- Yellow text, dark gray background

    -- Set the background color for the entire sign column
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
    local hi = vim.api.nvim_set_hl
    hi(0, "DropBarMenuHoverIcon", { reverse = false })

    vim.cmd('highlight Comment guifg=None guibg=None gui=bold')
  end,

})

-- vim.api.nvim_create_autocmd("SessionLoadPost", {
--   callback = function()
-- --    vim.cmd(":SLoad" . GetUniqueSessionName() . "<CR>")
--
--     vim.cmd("doautocmd DirChanged")
--     vim.cmd("doautocmd VimResized")
--   end
-- })
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("dropbar").setup()
  end
})
