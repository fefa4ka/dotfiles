-- Vim Language Server Configuration
local lspconfig = require('lspconfig')
local common = require('config.lsp')

-- Vim Language Server
lspconfig.vimls.setup(common.default_setup)
