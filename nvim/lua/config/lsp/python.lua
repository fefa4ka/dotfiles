-- Python Language Server Configuration
local lspconfig = require('lspconfig')
local common = require('config.lsp')

-- Python (using pylsp)
lspconfig.pylsp.setup {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  settings = {
    pylsp = {
      plugins = {
        -- formatter options (prefer ruff/external formatters)
        black = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options (prefer ruff)
        pylint = { enabled = false },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting (prefer ruff)
        pyls_isort = { enabled = false },
      },
    },
  },
  flags = {
    debounce_text_changes = 200,
  },
}

-- Ruff (Python Linter/Formatter)
lspconfig.ruff.setup {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
}

-- Auto-organize imports on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py" },
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
    vim.wait(100)
  end,
})
