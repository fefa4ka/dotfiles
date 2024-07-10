
return {
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'preservim/tagbar' },
	{ 'neovim/nvim-lspconfig',
	config = function()
		require('config.lsp')
	end
},
{ 'ranjithshegde/ccls.nvim' },
{ -- Autocomplete framework
	'hrsh7th/nvim-cmp',
	-- load cmp on InsertEnter
	event = "InsertEnter",
	dependencies = {
		-- Snippet engine with LSP backend
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
		-- Interface between nvim-cmp and luasnip
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		-- Snippet engine of buffer words
		'hrsh7th/cmp-buffer',
	},
	config = function()
		require('config.cmp')
	end,
},
{ -- format code with clang-format
	'rhysd/vim-clang-format',
	config = function()
		-- require('config.vim-clang-format')
	end
},
{
	"MysticalDevil/inlay-hints.nvim",
	event = "LspAttach",
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		require("inlay-hints").setup()
	end
},

{'tzachar/cmp-ai', dependencies = 'nvim-lua/plenary.nvim'},
}

