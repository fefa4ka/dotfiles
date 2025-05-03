-- LSP Configuration Entry Point
-- This file exports common LSP functionality to be used by language-specific modules

local M = {}
local keymaps = require('config.keymaps')

-- General LSP settings and capabilities
M.capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Custom on_attach function for keybindings and other buffer-local settings
function M.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Apply LSP keybindings from the centralized keymaps module
  keymaps.setup_lsp_keymaps(client, bufnr)

  -- Disable hover for ruff if pyright/pylsp is also attached (preference)
  if client.name == 'ruff' then
    local pyright_client = vim.lsp.get_clients({ name = 'pyright' })[1]
    local pylsp_client = vim.lsp.get_clients({ name = 'pylsp' })[1]
    if pyright_client or pylsp_client then
      if client.server_capabilities and client.server_capabilities.hoverProvider ~= nil then
        client.server_capabilities.hoverProvider = false
      end
    end
  end
end

-- Default setup arguments
M.default_setup = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

-- Set completion options
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Load snippets (example using luasnip with vscode snippets)
require('luasnip.loaders.from_vscode').lazy_load()


return M
