-- Shell script specific settings
vim.bo.expandtab = true    -- Use spaces instead of tabs
vim.bo.shiftwidth = 2      -- Size of an indent
vim.bo.tabstop = 2         -- Number of spaces tabs count for
vim.bo.softtabstop = 2     -- Number of spaces that a <Tab> counts for
vim.bo.smartindent = true  -- Insert indents automatically

-- Set commentstring for shell scripts
vim.bo.commentstring = '# %s'

-- Set formatprg to use shfmt
vim.bo.formatprg = 'shfmt -i 2 -ci -bn -s'

-- Add shell script specific keymaps
local opts = { buffer = true, noremap = true, silent = true }
vim.keymap.set('n', '<leader>sf', ':!shfmt -i 2 -ci -bn -s -w %<CR>', opts)
