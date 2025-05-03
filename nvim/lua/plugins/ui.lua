return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "f-person/auto-dark-mode.nvim" },
  { "echasnovski/mini.icons",      opts = {} }, -- Add mini.icons for which-key
  { "tiagovla/scope.nvim" },
  { "vifm/vifm.vim" },
  { "mhinz/vim-startify" },
  { "tpope/vim-obsession" },
  { "phaazon/hop.nvim" },
  {
    'tzachar/local-highlight.nvim',
    config = function()
      require('local-highlight').setup({
        disable_file_types = { 'tex' },
        animate = false,
        hlgroup = 'Search',
        cw_hlgroup = nil,
        -- Whether to display highlights in INSERT mode or not
        insert_mode = false,
        min_match_len = 1,
        max_match_len = math.huge,
        highlight_single_match = true,
      })
    end
  },
  { -- Display cheat sheet of vim shortcut
    'folke/which-key.nvim',
    config = true,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({
        winopts = {
          -- split = "belowright new",-- open in a split instead?
          -- "belowright new"  : split below
          -- "aboveleft new"   : split above
          -- "belowright vnew" : split right
          -- "aboveleft vnew   : split left
          -- Only valid when using a float window
          -- (i.e. when 'split' is not defined, default)
          height     = 0.85, -- window height
          width      = 0.80, -- window width
          row        = 0.35, -- window row position (0=top, 1=bottom)
          col        = 0.50, -- window col position (0=left, 1=right)
          -- border argument passthrough to nvim_open_win()
          border     = "rounded",
          -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
          backdrop   = 100,
          -- title         = "Title",
          -- title_pos     = "center",        -- 'left', 'center' or 'right'
          -- title_flags   = false,           -- uncomment to disable title flags
          fullscreen = false, -- start fullscreen?
          -- enable treesitter highlighting for the main fzf window will only have
          -- effect where grep like results are present, i.e. "file:line:col:text"
          -- due to highlight color collisions will also override `fzf_colors`
          -- set `fzf_colors=false` or `fzf_colors.hl=...` to override
          treesitter = {
            enabled    = true,
            fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" }
          },
          preview    = {
            -- default     = 'bat',           -- override the default previewer?
            -- default uses the 'builtin' previewer
            border       = "rounded", -- preview border: accepts both `nvim_open_win`
            -- and fzf values (e.g. "border-top", "none")
            -- native fzf previewers (bat/cat/git/etc)
            -- can also be set to `fun(winopts, metadata)`
            wrap         = false,   -- preview line wrap (fzf's 'wrap|nowrap')
            hidden       = false,   -- start preview hidden
            vertical     = "down:45%", -- up|down:size
            horizontal   = "right:60%", -- right|left:size
            layout       = "flex",  -- horizontal|vertical|flex
            flip_columns = 100,     -- #cols to switch to horizontal on flex
            -- Only used with the builtin previewer:
            title        = true,    -- preview border title (file/buf)?
            title_pos    = "center", -- left|center|right, title alignment
            scrollbar    = "float", -- `false` or string:'float|border'
            -- float:  in-window floating border
            -- border: in-border "block" marker
            scrolloff    = -1, -- float scrollbar offset from right
            -- applies only when scrollbar = 'float'
            delay        = 20, -- delay(ms) displaying the preview
            -- prevents lag on fast scrolling
            winopts      = { -- builtin previewer window options
              number         = true,
              relativenumber = false,
              cursorline     = true,
              cursorlineopt  = "both",
              cursorcolumn   = false,
              signcolumn     = "no",
              list           = false,
              foldenable     = false,
              foldmethod     = "manual",
            },
          },
          on_create  = function()
            -- called once upon creation of the fzf main window
            -- can be used to add custom fzf-lua mappings, e.g:
            --   vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
          end,
          -- called once _after_ the fzf interface is closed
          -- on_close = function() ... end
        }
      })
    end
  },
  { -- or show symbols in the current file as breadcrumbs
    'Bekaboo/dropbar.nvim',
    enabled = function()
      return vim.fn.has 'nvim-0.10' == 1
    end,
    config = function()
      -- turn off global option for windowline
      vim.opt.winbar = nil
      vim.keymap.set('n', '<leader>ls', require('dropbar.api').pick, { desc = '[s]ymbols' })
      vim.api.nvim_set_hl(0, "DropBarMenuHoverIcon", { fg = "#d79921", bg = "NONE" }) -- Yellow text, dark gray background
    end,

  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1,  -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        tmux = { enabled = true }, -- disables the tmux statusline
        kitty = {
          enabled = true,
          font = "+4", -- font size increment
        }
      },
    }
  },
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
    }
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "ya_openai",
          },
          inline = {
            adapter = "ya_aitunnel",
          },
          cmd = {
            adapter = "ya_together",
          },
        },
        opts = {
          -- Set debug logging
          log_level = "DEBUG",
        },
        display = {
          chat = {
            -- Change the default icons
            icons = {
              pinned_buffer = " ",
              watched_buffer = "👀 ",
            },
            roles = {
              ---The header name for the LLM's messages
              ---@type string|fun(adapter: CodeCompanion.Adapter): string
              llm = function(adapter)
                return "AI (" .. adapter.formatted_name .. ")"
              end,

              ---The header name for your messages
              ---@type string
              user = ">>",
            },

            -- Alter the sizing of the debug window
            debug_window = {
              ---@return number|fun(): number
              width = vim.o.columns - 5,
              ---@return number|fun(): number
              height = vim.o.lines - 2,
            },

            -- Options to customize the UI of the chat buffer
            window = {
              layout = "vertical", -- float|vertical|horizontal|buffer
              position = nil,      -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
              border = "single",
              height = 0.8,
              width = 0.45,
              relative = "editor",
              full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
              opts = {
                breakindent = true,
                cursorcolumn = false,
                cursorline = false,
                foldcolumn = "0",
                linebreak = true,
                list = false,
                numberwidth = 1,
                signcolumn = "no",
                spell = false,
                wrap = true,
              },
            },
          },
          action_palette = {
            width = 95,
            height = 10,
            prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
            provider = "default",                 -- Can be "default", "telescope", or "mini_pick". If not specified, the plugin will autodetect installed providers.
            opts = {
              show_default_actions = true,        -- Show the default actions in the action palette?
              show_default_prompt_library = true, -- Show the default prompt library in the action palette?
            },
          },
        },
        adapters = {
          ya_openai = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://" .. vim.env.CODECOMPANION_HOST .. "/raw/openai",                           -- optional: default value is ollama url http://127.0.0.1:11434
                api_key = vim.env.CODECOMPANION_TOKEN or "", -- optional: if your endpoint is authenticated
                chat_url = "/v1/chat/completions",                                         -- optional: default value, override if different
              },
              headers = {
                Authorization = "OAuth ${api_key}",
              },
              schema = {
                model = {
                  default = "gpt-4o",
                },
              },
            })
          end,
          ya_aitunnel = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://" .. vim.env.CODECOMPANION_HOST .. "/raw/aitunnel",                         -- optional: default value is ollama url http://127.0.0.1:11434
                api_key = vim.env.CODECOMPANION_TOKEN or "", -- optional: if your endpoint is authenticated
                chat_url = "/v1/chat/completions",                                         -- optional: default value, override if different
              },
              headers = {
                Authorization = "OAuth ${api_key}",
              },
              schema = {
                model = {
                  default = "claude-3.7-sonnet",
                },
              }
            })
          end,
          ya_together = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://" .. vim.env.CODECOMPANION_HOST .. "/raw/together",                         -- optional: default value is ollama url http://127.0.0.1:11434
                api_key = vim.env.CODECOMPANION_TOKEN or "", -- optional: if your endpoint is authenticated
                chat_url = "/v1/chat/completions",                                         -- optional: default value, override if different
              },
              headers = {
                Authorization = "OAuth ${api_key}",
              },
              schema = {
                model = {
                  default = "deepseek-ai/deepseek-v3",
                },
              }
            })
          end,
        },
      })
    end,
  },
}
