-- LSP Configuration Entry Point
-- This file initializes all language-specific LSP configurations

-- Load the common LSP utilities
local common = require('config.lsp')

-- Autocommand for LSP Attach actions (like keybindings)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspCustomAttach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf
    -- Call the shared on_attach function
    common.on_attach(client, bufnr)
  end,
})

-- Load all language-specific configurations
require('config.lsp.lua')
require('config.lsp.python')
require('config.lsp.typescript')
require('config.lsp.cpp')
require('config.lsp.bash')
require('config.lsp.cmake')
require('config.lsp.vim')
require('config.lsp.treesitter')
