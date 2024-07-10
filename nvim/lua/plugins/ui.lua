return {
	-- add gruvbox
	{ "ellisonleao/gruvbox.nvim" },
	{ "f-person/auto-dark-mode.nvim" },
	{ "tiagovla/scope.nvim" },
	{ "vifm/vifm.vim" },
	{ "mhinz/vim-startify" },
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
}
