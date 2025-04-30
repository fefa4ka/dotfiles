-- CMake Language Server Configuration
local lspconfig = require('lspconfig')
local common = require('config.lsp')

-- CMake
lspconfig.cmake.setup {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  filetypes = { 'cmake', 'CMakeLists.txt' }
}
