-- General Neovim options
local opt = vim.opt

-- Indentation settings
opt.expandtab = true      -- Use spaces instead of tabs
opt.shiftwidth = 2        -- Size of an indent
opt.tabstop = 2           -- Number of spaces tabs count for
opt.softtabstop = 2       -- Number of spaces that a <Tab> counts for
opt.smartindent = true    -- Insert indents automatically

-- File type specific indentation (will be overridden by ftplugin settings)
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"lua"},
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end
})

-- Other common options
opt.swapfile = false      -- Don't use swapfile
opt.backup = false        -- Don't create backup files
opt.undofile = true       -- Enable persistent undo
opt.ignorecase = true     -- Ignore case when searching
opt.smartcase = true      -- Don't ignore case with capitals
opt.scrolloff = 8         -- Lines of context
opt.sidescrolloff = 8     -- Columns of context
opt.splitright = true     -- Put new windows right of current
opt.splitbelow = true     -- Put new windows below current
opt.clipboard = 'unnamed' -- Use system clipboard
opt.timeoutlen = 300      -- Time to wait for a mapped sequence to complete
opt.virtualedit = 'all'   -- Allow cursor to move where there is no text
