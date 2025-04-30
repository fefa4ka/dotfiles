-- C/C++/Objective-C Language Server Configuration
local lspconfig = require('lspconfig')
local common = require('config.lsp')

-- C/C++/Objective-C (using clangd)
lspconfig.clangd.setup {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp" },
  -- Consider adding command or cmd_path if clangd is not in PATH
  -- cmd = {
  --   "clangd",
  --   "--offset-encoding=utf-16", -- Ensure correct offset encoding
  -- },
}
