-- Plugin: lsp-config
 -- TODO:
 -- 1. debug LSP
 -- 4. Use K to show documentation in preview window.
 -- 5. Symbol renaming.
 -- 6. Formatting selected code.
 -- 7. Apply AutoFix to problem on the current line.

 -- 9. NeoVim-only mapping for visual mode scroll
 -- Useful on signatureHelp after jump placeholder of snippet expansion

 -- 10. Add (Neo)Vim's native statusline support.
 -- NOTE: Please see `:h coc-status` for integrations with external plugins that
 -- provide custom statusline: lightline.vim, vim-airline.

 -- 11. gd will go by coc -> tags -> searchdecl
 -- go to type def
 -- go to impl
 -- go to reference
 --

 -- Configure LSP server
 -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local lsp = require('lspconfig')

lsp.vimls.setup({})

lsp.pyright.setup{}

lsp.clangd.setup{}

 -- Bash (bash-language-server)
 -- https://github.com/bash-lsp/bash-language-server
 -- lsp.bashls.setup({})

 -- C/C++/Obj-C (ccls)
 -- https://github.com/MaskRay/ccls
-- lsp.ccls.setup {
--   init_options = {
--     -- compilationDatabaseDirectory = "";
--     cache = {
--       directory = ".ccls-cache";
--     };
--     client = {
--       snippetSupport = true;
--     };
--     index = {
--       threads = 0;
--       onChange = true;
--     };
--     clang = {
--       excludeArgs = { "-frounding-math"} ;
--     };
--   },
-- }


-- 
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
   -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

  end,
})


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "python", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
}


vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 1},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})

-- local cmp_ai = require('cmp_ai.config')
--
-- cmp_ai:setup({
--   max_lines = 100,
--   provider = 'Ollama',
--   provider_options = {
--     model = 'deepseek-coder-v2:16b-lite-base-q4_0',
--   },
--   notify = true,
--   notify_callback = function(msg)
--     vim.notify(msg)
--   end,
--   run_on_every_keystroke = true,
--   ignored_file_types = {
--     -- default is not to ignore
--     -- uncomment to ignore in lua:
--     -- lua = true
--   },
-- })
-- local compare = require('cmp.config.compare')
-- cmp.setup({
--   sorting = {
--     priority_weight = 2,
--     comparators = {
--       require('cmp_ai.compare'),
--       compare.offset,
--       compare.exact,
--       compare.score,
--       compare.recently_used,
--       compare.kind,
--       compare.sort_text,
--       compare.length,
--       compare.order,
--     },
--   },
-- })
