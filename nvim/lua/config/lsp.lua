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

require('lspconfig').ruff.setup {
  trace = 'messages',
  init_options = {
    settings = {
      logLevel = 'debug',
    }
  }
}
-- typescript
lsp.ts_ls.setup{}

lsp.cmake.setup{
filetypes = {'cmake', 'CMakeLists.txt'}
}


lsp.pylsp.setup {
on_attach = custom_attach,
settings = {
    pylsp = {
    plugins = {
        -- formatter options
        black = { enabled = false},
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        -- pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = false },
    },
    },
},
flags = {
    debounce_text_changes = 200,
},
capabilities = capabilities,
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

vim.api.nvim_create_autocmd("BufWritePre", {
               buffer = buffer,
               callback = function()
                 vim.lsp.buf.code_action({
                   context = { only = { "source.organizeImports" } },
                   apply = true,
                 })
                 vim.wait(100)
               end,
       })

require'lspconfig'.clangd.setup {
  -- Filter out .proto files
  filetypes = { "c", "cpp", "objc", "objcpp" }
}

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
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local wk = require("which-key")

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-S-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    -- If lsp for Dart is attached
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.name == "dartls" then
	    wk.add({
		    {'<leader>hf', function() require('telescope').extensions.flutter.commands() end, desc = "Flutter Commands"}
		})
end

    wk.add({
	    {'<leader>f', function() vim.lsp.buf.format { async = true } end, desc = "Format"},
	    {'<leader>n', function() vim.lsp.buf.rename() end, desc = "Rename"},
	    {'<leader>w', group = 'Workspace' },
	    {'<leader>wa', function() vim.lsp.buf.add_workspace_folder() end, desc ="Add Workspace Folder"},
	    {'<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end, desc ="Remove Workspace Folder"},
	    {'<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc ="List Workspace Folders"},
	    {'<leader>ha',  "<cmd>FzfLua lsp_code_actions<CR>", desc ="Code Actions"},
	    {'gr', "<cmd>FzfLua lsp_references<CR>", desc ="References"},
	    {'gd', "<cmd>FzfLua lsp_definitions<CR>", desc ="Definitions"},
	    {'gD', "<cmd>FzfLua lsp_type_definitions<CR>", desc ="Type Definitions"},
	    {'gi', "<cmd>FzfLua lsp_implementations<CR>", desc ="Implementations"},
})

  end,
})


require'nvim-treesitter.configs'.setup {
   highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
   autotag = {
    enable = true,
  },
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "python", "vim", "vimdoc", "query", "json", "bash", "tsx", "html", "css", "yaml", "toml" },

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
    {name = 'supermaven'},
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


require("supermaven-nvim").setup({
  log_level = "info", -- set to "off" to disable logging completely
  disable_inline_completion = false, -- disables inline completion for use with cmp
  disable_keymaps = true, -- disables built in keymaps for more manual control
  condition = function()
    return false
  end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
})

vim.g.signify_sign_add = ''
vim.g.signify_sign_delete = ''
vim.g.signify_sign_change = ''
vim.g.signify_sign_changedelete = ''
vim.g.signify_sign_delete_first_line = ''
vim.g.signify_realtime = true


-- Flutter 
require("flutter-tools").setup {
  -- ui = {
  --   -- the border type to use for all floating windows, the same options/formats
  --   -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
  --   border = "rounded",
  --   -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
  --   -- please note that this option is eventually going to be deprecated and users will need to
  --   -- depend on plugins like `nvim-notify` instead.
  --   notification_style = 'native' | 'plugin'
  -- },
  -- decorations = {
  --   statusline = {
  --     -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
  --     -- this will show the current version of the flutter app from the pubspec.yaml file
  --     app_version = false,
  --     -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
  --     -- this will show the currently running device if an application was started with a specific
  --     -- device
  --     device = false,
  --     -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
  --     -- this will show the currently selected project configuration
  --     project_config = false,
  --   }
  -- },
  -- debugger = { -- integrate with nvim dap + install dart code debugger
  --   enabled = false,
  --   -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
  --   -- see |:help dap.set_exception_breakpoints()| for more info
  --   exception_breakpoints = {},
  --   -- Whether to call toString() on objects in debug views like hovers and the
  --   -- variables list.
  --   -- Invoking toString() has a performance cost and may introduce side-effects,
  --   -- although users may expected this functionality. null is treated like false.
  --   evaluate_to_string_in_debug_views = true,
  --   register_configurations = function(paths)
  --     require("dap").configurations.dart = {
  --       --put here config that you would find in .vscode/launch.json
  --     }
  --     -- If you want to load .vscode launch.json automatically run the following:
  --  -- require("dap.ext.vscode").load_launchjs()
  --   end,
  -- },
  flutter_path = "/Users/fefa4ka/Toolchain/flutter/bin/flutter", -- <-- this takes priority over the lookup
  -- flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
  -- root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
  -- fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
  -- widget_guides = {
  --   enabled = false,
  -- },
  -- closing_tags = {
  --   highlight = "ErrorMsg", -- highlight for the closing tag
  --   prefix = ">", -- character to use for close tag e.g. > Widget
  --   priority = 10, -- priority of virtual text in current line
  --   -- consider to configure this when there is a possibility of multiple virtual text items in one line
  --   -- see `priority` option in |:help nvim_buf_set_extmark| for more info
  --   enabled = true -- set to false to disable
  -- },
  -- dev_log = {
  --   enabled = true,
  --   filter = nil, -- optional callback to filter the log
  --   -- takes a log_line as string argument; returns a boolean or nil;
  --   -- the log_line is only added to the output if the function returns true
  --   notify_errors = false, -- if there is an error whilst running then notify the user
  --   open_cmd = "tabedit", -- command to use to open the log buffer
  -- },
  -- dev_tools = {
  --   autostart = false, -- autostart devtools server if not detected
  --   auto_open_browser = false, -- Automatically opens devtools in the browser
  -- },
  -- outline = {
  --   open_cmd = "30vnew", -- command to use to open the outline buffer
  --   auto_open = false -- if true this will open the outline automatically when it is first populated
  -- },
  -- lsp = {
  --   color = { -- show the derived colours for dart variables
  --     enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
  --     background = false, -- highlight the background
  --     background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
  --     foreground = false, -- highlight the foreground
  --     virtual_text = true, -- show the highlight using virtual text
  --     virtual_text_str = "■", -- the virtual text character to highlight
  --   },
  --   on_attach = my_custom_on_attach,
  --   capabilities = my_custom_capabilities, -- e.g. lsp_status capabilities
  --   --- OR you can specify a function to deactivate or change or control how the config is created
  --   capabilities = function(config)
  --     config.specificThingIDontWant = false
  --     return config
  --   end,
  --   -- see the link below for details on each option:
  --   -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
  --   settings = {
  --     showTodos = true,
  --     completeFunctionCalls = true,
  --     analysisExcludedFolders = {"<path-to-flutter-sdk-packages>"},
  --     renameFilesWithClasses = "prompt", -- "always"
  --     enableSnippets = true,
  --     updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
  --   }
  -- }
}
