-- UI Configuration
-- Consolidates all UI-related settings in one place

local M = {}

-- Basic UI settings
local function setup_ui_basics()
  local opt = vim.opt
  
  -- UI appearance settings
  opt.number = true         -- Show line numbers
  opt.relativenumber = true -- Show relative line numbers
  opt.wrap = false          -- Disable line wrap
  opt.termguicolors = true  -- True color support
  
  -- Terminal color support
  if vim.fn.exists('+termguicolors') == 1 then
    vim.cmd('let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"')
    vim.cmd('let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"')
  end
end

-- Theme configuration
local function setup_theme()
  -- Theme settings
  vim.cmd('colorscheme gruvbox')
  vim.cmd('hi normal guibg=none ctermbg=none')
  
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
  
  -- Apply custom highlights after colorscheme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      -- Customize signify signs with both foreground and background colors
      vim.api.nvim_set_hl(0, "SignifySignAdd", { fg = "#98971a", bg = "NONE" })  -- Green text
      vim.api.nvim_set_hl(0, "SignifySignDelete", { fg = "#cc241d", bg = "NONE" }) -- Red text
      vim.api.nvim_set_hl(0, "SignifySignChange", { fg = "#d79921", bg = "NONE" }) -- Yellow text
      
      -- Set the background color for the entire sign column
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "DropBarMenuHoverIcon", { reverse = false })
      
      vim.cmd('highlight Comment guifg=None guibg=None gui=bold')
    end,
  })
end

-- Plugin configurations
local function setup_plugins()
  -- Hop plugin configuration
  local hop = require('hop')
  hop.setup({ keys = 'etovxqpdygfblzhckisuran', jump_on_sole_occurrence = false })
  
  -- Plugin: vim-better-whitespace
  vim.g.strip_whitelines_at_eof = 1
  vim.g.show_spaces_that_precede_tabs = 1
  vim.g.better_whitespace_enabled = 0
  
  -- Tabs scope
  require("scope").setup({})
  require("telescope").load_extension("scope")
  
  -- Local highlight attach to any buffer
  vim.api.nvim_create_autocmd('BufRead', {
    pattern = { '*.*' },
    callback = function(data)
      require('local-highlight').attach(data.buf)
    end
  })
  
  -- Sessions
  vim.g.startify_session_persistence = 1
  
  -- Plugin: Startify - Show startify when there is no opened buffers
  local function show_startify()
    local tabpage_bufs = vim.api.nvim_tabpage_list_bufs(0)
    if #vim.tbl_filter(function(buf)
          return not vim.api.nvim_buf_is_loaded(buf) or not vim.api.nvim_buf_get_option(buf, 'buflisted')
        end, tabpage_bufs) == 0 and vim.fn.bufname('') == '' then
      vim.cmd('Startify')
    end
  end
  
  -- Setup dropbar
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      require("dropbar").setup()
    end
  })
  
  -- Commented out Copilot settings (preserved for reference)
  -- vim.g.copilot_proxy = 'http://localhost:11435'
  -- vim.g.copilot_proxy_strict_ssl = false
  -- vim.keymap.set('i', '<C-A>', 'copilot#Accept("\\<CR>")', {
  --   expr = true,
  --   replace_keycodes = false
  -- })
  -- vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
  -- vim.keymap.set('i', '<C-J>', '<Plug>(copilot-accept-line)')
  -- vim.g.copilot_no_tab_map = true
end

-- Initialize all UI components
function M.setup()
  setup_ui_basics()
  setup_theme()
  setup_plugins()
end

return M
