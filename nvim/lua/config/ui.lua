local o = vim.o
local hop = require('hop')

o.timeoutlen = 300
o.swapfile = false
o.clipboard = 'unnamed'

o.number = true
o.relativenumber = true

-- Source ~/.config/theme

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

hop.setup({ keys = 'etovxqpdygfblzhckisuran', jump_on_sole_occurrence = false })


-- Plugin: vim-better-whitespace
-- https://github.com/ntpeters/vim-better-whitespace

-- To strip white lines at the end of the file when stripping whitespace
vim.g.strip_whitelines_at_eof = 1
-- To highlight space characters that appear before or in-between tabs
vim.g.show_spaces_that_precede_tabs = 1
-- default disable whitespace warnings
vim.g.better_whitespace_enabled = 0



-- Plugin: Startify
-- Show startify when there is no opened buffers

local function show_startify()
  local tabpage_bufs = vim.api.nvim_tabpage_list_bufs(0)
  if #vim.tbl_filter(function(buf)
    return not vim.api.nvim_buf_is_loaded(buf) or not vim.api.nvim_buf_get_option(buf, 'buflisted')
  end, tabpage_bufs) == 0 and vim.fn.bufname('') == '' then
    vim.cmd('Startify')
  end
end


-- Dark mode
local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
		vim.cmd('colorscheme gruvbox')
	end,
	set_light_mode = function()
		vim.api.nvim_set_option('background', 'light')
		vim.cmd('colorscheme gruvbox')
	end,
})


-- Tabs scope
require("scope").setup({})
require("telescope").load_extension("scope")

-- Local highlight attach to any buffer
vim.api.nvim_create_autocmd('BufRead', {
  pattern = {'*.*'},
  callback = function(data)
    require('local-highlight').attach(data.buf)
  end
})

-- Copilot
vim.g.copilot_proxy = 'http://localhost:11435'
vim.g.copilot_proxy_strict_ssl = false
vim.keymap.set('i', '<C-A>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-J>', '<Plug>(copilot-accept-line)')
vim.g.copilot_no_tab_map = true
