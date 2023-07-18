local o = vim.o
--local hop = require('hop')

o.timeoutlen = 100
o.swapfile = false
o.clipboard = 'unnamed'

o.number = true
o.relativenumber = true

-- Source ~/.config/theme
vim.cmd('source ~/.config/theme')

-- Set highlight for normal mode
-- Check if 'termguicolors' option is supported
if vim.fn.exists('+termguicolors') == 1 then
     -- Enable 'termguicolors' option
    vim.cmd('let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"')
    vim.cmd('let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"')
    vim.cmd('set termguicolors')
end

vim.cmd('colorscheme gruvbox')
vim.cmd('hi normal guibg=none ctermbg=none')

--hop.setup({ keys = 'etovxqpdygfblzhckisuran', jump_on_sole_occurrence = false })
