-- Bash Language Server Configuration
local lspconfig = require('lspconfig')
local common = require('config.lsp')

-- Bash Language Server
lspconfig.bashls.setup(common.default_setup)

-- Shell script formatting with shfmt
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.sh", "*.bash", "*.zsh" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local cmd = "shfmt -i 2 -ci -bn -s -w " .. vim.fn.shellescape(filename)
    vim.fn.system(cmd)
    -- Reload the buffer if it was modified by the external command
    if vim.api.nvim_buf_get_option(bufnr, 'modified') then
      vim.cmd('checktime')
    end
  end,
})
