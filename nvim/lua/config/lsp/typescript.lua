-- TypeScript/JavaScript Language Server Configuration
local lspconfig = require('lspconfig')
local common = require('config.lsp')

-- TypeScript / JavaScript (using ts_ls)
lspconfig.ts_ls.setup(common.default_setup)
