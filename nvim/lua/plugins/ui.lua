return {
	-- add gruvbox
	{ "ellisonleao/gruvbox.nvim" },
	{ "f-person/auto-dark-mode.nvim" },
  { "echasnovski/mini.icons", opts = {} }, -- Add mini.icons for which-key
	{ "tiagovla/scope.nvim" },
	{ "vifm/vifm.vim" },
	{ "mhinz/vim-startify" },
	{ "tpope/vim-obsession" },
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ "kelly-lin/telescope-ag",
	dependencies = { "nvim-telescope/telescope.nvim" }
},
{ "phaazon/hop.nvim" },
{
	'tzachar/local-highlight.nvim',
	config = function()
		require('local-highlight').setup({
			disable_file_types = {'tex'},
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
		require("fzf-lua").setup({})
	end
},
{ -- or show symbols in the current file as breadcrumbs
	'Bekaboo/dropbar.nvim',
	enabled = function()
		return vim.fn.has 'nvim-0.10' == 1
	end,
	dependencies = {
		'nvim-telescope/telescope-fzf-native.nvim',
	},
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
			height = 1, -- height of the Zen window
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
}
