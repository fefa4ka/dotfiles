-- Plugin: lsp-config
-- LSP Configuration
-- See :help lspconfig
-- Server configurations: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local lsp = require('lspconfig')
local util = require 'lspconfig.util'

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
  wk.register({
    { "<leader>f", function() vim.lsp.buf.format { async = true } end, desc = "Format Code", buffer = bufnr },
    { "<leader>n", function() vim.lsp.buf.rename() end, desc = "Rename Symbol", buffer = bufnr },
    { "<leader>w", group = "Workspace", buffer = bufnr },
    { "<leader>wa", function() vim.lsp.buf.add_workspace_folder() end, desc = "Add Workspace Folder", buffer = bufnr },
    { "<leader>wr", function() vim.lsp.buf.remove_workspace_folder() end, desc = "Remove Workspace Folder", buffer = bufnr },
    { "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List Workspace Folders", buffer = bufnr },
    { "<leader>h", group = "LSP Help", buffer = bufnr },
    { "<leader>ha", "<cmd>FzfLua lsp_code_actions<CR>", desc = "Code Actions", buffer = bufnr },
    -- Flutter specific command, conditionally shown if dartls is attached (though registered once)
    { "<leader>hf", function()
        if client.name == "dartls" then
          require('telescope').extensions.flutter.commands()
        else
          print("Flutter commands require Dart LSP")
        end
      end, desc = "Flutter Commands", buffer = bufnr },
    { "gr", "<cmd>FzfLua lsp_references<CR>", desc = "References", buffer = bufnr },
    { "gd", "<cmd>FzfLua lsp_definitions<CR>", desc = "Definitions", buffer = bufnr },
    { "gD", "<cmd>FzfLua lsp_type_definitions<CR>", desc = "Type Definitions", buffer = bufnr },
    { "gi", "<cmd>FzfLua lsp_implementations<CR>", desc = "Implementations", buffer = bufnr },
    { "K", vim.lsp.buf.hover, desc = "Hover Documentation", buffer = bufnr },
    { "<C-S-k>", vim.lsp.buf.signature_help, desc = "Signature Help", buffer = bufnr }, -- Keep existing mapping if desired
  }, { buffer = bufnr })


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

-- Vim Language Server
lsp.vimls.setup(default_setup)

-- Ruff (Python Linter/Formatter)
lsp.ruff.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- Note: The LspAttach autocmd below handles disabling hover if needed
}

-- TypeScript / JavaScript (using ts_ls)
lsp.ts_ls.setup(default_setup)

-- CMake
lsp.cmake.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'cmake', 'CMakeLists.txt' }
}

-- Python (using pylsp)
lsp.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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

-- C/C++/Objective-C (using clangd)
lsp.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp" },
  -- Consider adding command or cmd_path if clangd is not in PATH
  -- cmd = {
  --   "clangd",
  --   "--offset-encoding=utf-16", -- Ensure correct offset encoding
  -- },
}

-- Bash Language Server (Uncomment to enable)
-- lsp.bashls.setup(default_setup)

-- Autocommand for LSP Attach actions (like keybindings)
-- This replaces the previous LspAttach autocmd group 'UserLspConfig'
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspCustomAttach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf
    -- Call the shared on_attach function
    on_attach(client, bufnr)
  end,
})

-- Autocommand for organizing imports on save (Python example using ruff)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup('UserLspBufWritePre', { clear = true }),
  pattern = "*.py", -- Only for Python files
  callback = function(args)
    -- Check if ruff is attached to the buffer
    local ruff_client = vim.lsp.get_clients({ name = 'ruff', bufnr = args.buf })[1]
    if not ruff_client then return end -- Only run if ruff is active

    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }

    local result = ruff_client.request_sync("textDocument/codeAction", params, 1000) -- Timeout 1 sec
    if not result or vim.tbl_isempty(result) then return end

    local actions = {}
    for _, res in pairs(result) do
      if res.edit then
        vim.list_extend(actions, vim.lsp.util.transform_diagnostics(res))
      end
    end

    if #actions > 0 then
      vim.lsp.util.apply_text_edits(actions[1].edit.changes[params.textDocument.uri], args.buf, ruff_client.offset_encoding)
      vim.api.nvim_buf_call(args.buf, function()
        vim.cmd("noautocmd write") -- Save the buffer without triggering BufWritePre again
      end)
    end
  end,
})


-- Treesitter Configuration
-- Although related to code understanding, often kept separate from pure LSP config.
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
  indent = {
    enable = true,
    -- disable = { "yaml" },
  },
  autotag = {
    enable = true,
  },
  -- Ensure parsers are installed
  ensure_installed = {
    "bash", "c", "cmake", "cpp", "css", "dart", "dockerfile", "go", "html",
    "javascript", "json", "lua", "make", "markdown", "python", "query",
    "rust", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml"
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  auto_install = true,
}

-- Set completion options
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Load snippets (example using luasnip with vscode snippets)
require('luasnip.loaders.from_vscode').lazy_load()
