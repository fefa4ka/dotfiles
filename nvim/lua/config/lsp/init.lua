-- LSP Configuration Entry Point
-- This file loads all language-specific LSP configurations

local M = {}

-- General LSP settings and capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Custom on_attach function for keybindings and other buffer-local settings
local function on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
  })

  -- Disable hover for ruff if pyright/pylsp is also attached (preference)
  if client.name == 'ruff' then
    local pyright_client = vim.lsp.get_clients({ name = 'pyright', bufnr = bufnr })[1]
        or vim.lsp.get_clients({ name = 'pylsp', bufnr = bufnr })[1]
    if pyright_client then
      client.server_capabilities.hoverProvider = false
    end
  end
end

-- Default setup arguments
local default_setup = {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Export the common configuration
M.on_attach = on_attach
M.capabilities = capabilities
M.default_setup = default_setup

-- Load all language-specific configurations
require('config.lsp.lua')
require('config.lsp.python')
require('config.lsp.typescript')
require('config.lsp.cpp')
require('config.lsp.bash')
require('config.lsp.cmake')

-- Autocommand for LSP Attach actions (like keybindings)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspCustomAttach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf
    -- Call the shared on_attach function
    on_attach(client, bufnr)
  end,
})

-- Set completion options
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Load snippets (example using luasnip with vscode snippets)
require('luasnip.loaders.from_vscode').lazy_load()

return M
