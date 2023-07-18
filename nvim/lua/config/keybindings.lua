local g = vim.g

g.mapleader = " "

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
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')
map('i', 'ii', '<Esc>')
map('n', '<Esc>', '<nop>')

-- Undo/Redo
map('', '<C-r>', ':redo<CR>')
map('n', 'U', '<C-r>')
map('i', '<C-z>', '<Esc>ua')
map('i', '<C-Z>', '<Esc>Ua')
map('i', '<C-v>', '<Esc>pa')

-- Navigation
map('', '<C-e>', ':call ToggleNetrw()<CR>', { silent = true })
map('', '<C-t>', ':TagbarToggle<CR>')
map('n', '<C-s>', ':Telescope find_files<CR>')
map('n', '<C-p>', ':Telescope commands<CR>')
map('n', '<C-g>', ':Telescope git_files<CR>')
map('n', '<Esc>', ':Telescope buffers<CR>')

-- Panes
map('n', '<C-_>', '<C-W>S')
map('n', '<C-\\>', '<C-W>v')
map('n', '<C-q>', '<C-W>q')
map('n', '<C-k>', '<C-W>k')
map('n', '<C-j>', '<C-W>j')
map('n', '<C-h>', '<C-W>h')
map('n', '<C-l>', '<C-W>l')

-- Tabs
map('n', 'gtn', ':tabnew<CR>')
map('n', 'gtc', ':tabclose<CR>')

-- Naviagate through text
--map('n', 's', ':HopChar1<CR>', { silent = true })

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
vim.opt.pastetoggle = '<F2>'


