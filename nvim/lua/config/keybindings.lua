local g = vim.g

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

vim.g.mapleader = " "
--g.mapleader = "<Space>"

-- Define keymaps of Neovim and installed plugins.
local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Less keystrokes for command
map('n', ';', ':')
map('v', ';', ':')

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Replace esc with letters
map('n', 'jk', 'dd')
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')
-- map('i', 'ii', '<0Esc>')
map('n', '<Esc>', '<nop>')

-- Undo/Redo
map('', '<C-r>', ':redo<CR>')
map('n', 'U', '<C-r>')
map('i', '<C-z>', '<Esc>ua')
map('i', '<C-Z>', '<Esc>Ua')
map('i', '<C-v>', '<Esc>pa')

-- Navigation
-- map('', '<C-e>', ':call ToggleNetrw()<CR>', { silent = true })
map('', '<C-e>', ':Vifm<CR>', { silent = true })
map('n', 'fs', ':SplitVifm<CR>', { silent = true })
map('n', 'fv', ':VsplitVifm<CR>', { silent = true })
map('n', 'ft', ':TabVifm<CR>', { silent = true })
map('n', 'fd', ':DiffVifm<CR>', { silent = true })

map('', '<C-t>', ':TagbarToggle<CR>')
map('n', '<C-p>', ':Telescope find_files<CR>')
map('n', '<C-S-p>', ':Telescope commands<CR>')
map('n', '<C-g>', ':Telescope git_files<CR>')
map('n', '<Esc>', ':Telescope buffers<CR>')
map('n', '<leader>ht', ':Telescope help_tags<CR>')

-- LSP
map('n', 'gr', ':Telescope lsp_references<CR>')
map('n', 'gd', ':Telescope lsp_definitions<CR>')
map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

-- Panes
map('n', '<C-_>', '<C-W>s')
map('n', '<C-->', '<C-W>s')
map('n', '<C-\\>', '<C-W>v')
map('n', '<C-q>', '<C-W>q')
map('n', '<C-k>', '<C-W>k')
map('n', '<C-j>', '<C-W>j')
map('n', '<C-h>', '<C-W>h')
map('n', '<C-l>', '<C-W>l')
map('n', 'W', ':pclose<CR>')

-- Tabs
map('n', 'tn', ':tabnew<CR>')
map('n', 'tc', ':tabclose<CR>')

-- Naviagate through text
map('n', 's', ':HopChar1<CR>', { silent = true })
map('i', '<C-s>', '<Esc>:HopChar1<CR>', { silent = true })

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-- Toggle light/dark theme
map('n', '<leader>t', ':lua BgToggleSol()<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

-- Terminal mappings
map('n', '<C-j>', ':terminal<CR>i', { noremap = true })  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- Toggle auto-indenting for code paste
map('n', '<F2>', ':set invpaste paste?<CR>')
-- vim.opt.pastetoggle = '<F2>'


