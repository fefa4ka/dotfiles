-- Centralized Keybindings Configuration
local M = {}

-- Helper function for setting keymaps
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Setup basic keymaps
function M.setup_general_keymaps()
  -- Set leader key
  vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
  vim.g.mapleader = " "

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
  map('n', 'ол', 'dd')
  map('i', 'jk', '<Esc>')
  map('i', 'kj', '<Esc>')
  map('i', 'ол', '<Esc>')
  map('i', 'ло', '<Esc>')
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
  map('n', '<C-S-p>', ':FzfLua commands<CR>')
  map('n', '<C-S-f>', ':FzfLua live_grep<CR>')
  map('n', '<Esc>[95;6u', ':FzfLua commands<CR>')
  map('n', '<Esc>[96;6u', ':FzfLua live_grep<CR>')
  map('n', '<C-g>', ':FzfLua git_files<CR>')
  map('n', '<Esc>', ":FzfLua buffers<CR>")
  map('n', '<C-p>', ":FzfLua files<CR>")
  map('n', '<leader>ht', ':FzfLua help_tags<CR>')

  map('n', '<leader><leader>', ':nohlsearch<CR>')
  map('n', '<leader><leader><leader>', ':qa!<CR>')

  -- LSP
  map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

  -- Panes
  -- #jo
  map('n', '<C-_>', '<C-W>s')       -- Horizontal split with Ctrl+_
  map('n', '<C-->', '<C-W>s')       -- Horizontal split with Ctrl+-
  map('n', '<Esc>[45;5u', '<C-W>s') -- Horizontal split with remapped Ctrl+-
  map('n', '<C-\\>', '<C-W>v')      -- Vertical split with Ctrl+\
  map('n', '<C-q>', '<C-W>q')
  map('n', '<C-k>', '<C-W>k')
  map('n', '<C-j>', '<C-W>j')
  map('n', '<C-h>', '<C-W>h')
  map('n', '<C-l>', '<C-W>l')
  map('n', 'W', ':pclose<CR>')

  -- Resize panes
  -- Don't work in kitty, but works in alacritty
  map('n', '<C-S-h>', ':vertical resize -5<CR>')
  map('n', '<C-S-l>', ':vertical resize +5<CR>')
  map('n', '<C-S-j>', ':resize +5<CR>')
  map('n', '<C-S-k>', ':resize -5<CR>')

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
  -- map('n', '<C-S-j>', ':belowright split | terminal<CR>i', { noremap = true }) -- open
  map('t', '<Esc>', '<C-\\><C-n>') -- exit

  -- Clear search highlighting with <leader> and c
  map('n', '<leader>c', ':nohl<CR>')

  -- Toggle auto-indenting for code paste
  map('n', '<F2>', ':set invpaste paste?<CR>')
  -- vim.opt.pastetoggle = '<F2>'

  vim.api.nvim_set_keymap('n', '<ScrollWheelLeft>', '5zh', {})
  vim.api.nvim_set_keymap('n', '<ScrollWheelRight>', '5zl', {})
end

-- Setup which-key keymaps
function M.setup_which_key()
  local wk = require("which-key")
  local gen = require("gen")

  wk.setup({
    plugins = {
      marks = true,       -- shows a list of your marks on ' and `
      registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual configuration required, just leave it empty :)
      presets = {
        operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = false,      -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true,       -- default bindings on <c-w>
        nav = true,           -- misc bindings to work with windows
        z = true,             -- bindings for folds, spelling and others prefixed with z
        g = true,             -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "", -- symbol used in the command line area that shows your active key combo
      separator = "󰁔", -- symbol used between a key and it's description
      group = "󰅧", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded",       -- none, single, double, rounded, shadow
      position = "bottom",      -- bottom, top
      margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },                                             -- min and max height of the columns
      width = { min = 20, max = 50 },                                             -- min and max width of the columns
      spacing = 3,                                                                -- spacing between columns
      align = "left",                                                             -- align columns left, center or right
    },
    ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true,                                                             -- show help message on the command line when the popup is visible
    triggers = "auto",                                                            -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for keymaps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  })

  -- Setup Gen.nvim prompts
  require('gen').prompts['Fix_Code'] = {
    prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
    replace = true,
    extract = "```$filetype\n(.-)```"
  }

  require('gen').prompts['Comment_Code'] = {
    prompt =
    "Add simple and concise comments toерe following not obvious $filetype code, don't repeat yourself, don't comment self explanatory code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
    replace = true,
    extract = "```$filetype\n(.-)```"
  }

  -- Normal mode AI keybindings
  wk.add({
    {
      mode = { "n" },
      { "<leader>a", group = "󰘦 AI" },
      { "<leader>ag", "<cmd>Gen Generate<CR>", desc = "󰐥 Generate" },
      { "<leader>am", function() gen.select_model() end, desc = "󰆽 Select model" },
    }
  })

  -- Visual mode AI keybindings
  wk.add({
    {
      mode = { "v" },
      { "<leader>a", group = "󰘦 AI" },
      { "<leader>aa", "<cmd>'<,'>Gen Ask<CR>", desc = "󰭻 Ask" },
      { "<leader>ac", "<cmd>'<,'>Gen Change_Code<CR>", desc = "󰌢 Change" },
      { "<leader>ae", "<cmd>'<,'>Gen Enhance_Code<CR>", desc = "✨ Enhance" },
      { "<leader>ag", "<cmd>'<,'>Gen Enhance_Grammar_Spelling<CR>", desc = "󰓆 Grammar" },
      { "<leader>ar", "<cmd>'<,'>Gen Review_Code<CR>", desc = "󰱽 Review" },
      { "<leader>as", "<cmd>'<,'>Gen Make_Concise<CR>", desc = "󰏫 Simple and concise" },
      { "<leader>aw", "<cmd>'<,'>Gen Enhance_Wording<CR>", desc = "󰑬 Wording" },
    },
  })

  -- General keybindings
  wk.add({
    {
      mode = { "n" },
      { "<leader>c", group = "󰊢 VCS" },
      { "<leader>d", ":lua vim.diagnostic.open_float()<CR>", desc = "󱉶 Line Diagnostic" },
      { "<leader>dd", ":FzfLua diagnostics_document<CR>", desc = "󱉶 Document Diagnostics" },
      { "<leader>D", ":FzfLua diagnostics_workspace<CR>", desc = "󱉶 Workspace Diagnostics" },
      { "<leader>h", group = "󰋖 Help" },
      { "<leader>ht", ":FzfLua help_tags<CR>", desc = "󰋖 Help Tags" },
      { "<leader>hk", ":FzfLua keymaps<CR>", desc = "󰌌 Keymaps" },
      { "<leader>hm", ":messages<CR>", desc = "󰍡 Messages" },
      { "<leader>ls", function() require('dropbar.api').pick() end, desc = "󰊄 List Symbols" },
      { "<leader>q", ':qa!<CR>', desc = "󰅚 Quit All" },
      { "<leader>r", ":so %<CR>", desc = "󰑐 Reload Config" },
      { "<leader>t", ':lua BgToggleSol()<CR>', desc = "󰔎 Toggle Theme" },
      {
        "<leader>z",
        function()
          require("zen-mode").toggle()
          vim.cmd("highlight ZenBg guibg=0 guifg=0")
        end,
        desc = "󰍈 Zen Mode"
      },
      { "<leader><leader>", ":nohlsearch<CR>", desc = "󰅃 No Highlight Search" },
      { "<leader><leader><leader><leader>", ":qa!<CR>", desc = "󰅚 Quit All Force" },
    }
  })
end

-- Setup LSP keymaps
function M.setup_lsp_keymaps(client, bufnr)
  -- Buffer local mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-S-k>', vim.lsp.buf.signature_help, opts) -- Use Ctrl+Shift+K for signature help

  -- Setup which-key for LSP specific keybindings, only if not already done for this buffer
  if vim.b[bufnr].lsp_which_key_registered then return end
  vim.b[bufnr].lsp_which_key_registered = true

  local wk = require("which-key")
  -- Use the new list-based spec for which-key
  wk.add({
    { '<leader>f',  function() vim.lsp.buf.format { async = true } end,                      desc = "Format" },
    { '<leader>n',  function() vim.lsp.buf.rename() end,                                     desc = "Rename" },
    { '<leader>w',  group = 'Workspace' },
    { '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end,                       desc = "Add Workspace Folder" },
    { '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end,                    desc = "Remove Workspace Folder" },
    { '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List Workspace Folders" },
    { '<leader>ha', "<cmd>FzfLua lsp_code_actions<CR>",                                      desc = "Code Actions" },
    { 'gr',         "<cmd>FzfLua lsp_references<CR>",                                        desc = "References" },
    { 'gd',         "<cmd>FzfLua lsp_definitions<CR>",                                       desc = "Definitions" },
    { 'gD',         "<cmd>FzfLua lsp_type_definitions<CR>",                                  desc = "Type Definitions" },
    { 'gi',         "<cmd>FzfLua lsp_implementations<CR>",                                   desc = "Implementations" },
    { '<leader>A', ':AiderOpen --no-auto-commits --model anthropic/claude-3-7-sonnet-20250219 --cache-prompts --no-verify-ssl --model-settings-file ~/.aider/.aider.model.settings.yml<CR>', desc = "🤖 Aider" },
  })
end

-- Initialize all keymaps
function M.setup()
  M.setup_general_keymaps()
end

return M
