local wk = require("which-key")
local gen = require("gen")


require('gen').prompts['Fix_Code'] = {
	prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
	replace = true,
	extract = "```$filetype\n(.-)```"
}

require('gen').prompts['Comment_Code'] = {
	prompt = "Add simple and concise comments toерe following not obvious $filetype code, don't repeat yourself, don't comment self explanatory code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
	replace = true,
	extract = "```$filetype\n(.-)```"
}

wk.add({
	{
		mode = { "n" },
		{ "<leader>a", group = "AI" },
		{ "<leader>ag", "<cmd>Gen Generate<CR>", desc = "Generate" },
		{ "<leader>am", function() gen.select_model() end, desc = "Select model" },
	}
})

wk.add({
	{
		mode = { "v" },
		{ "<leader>a", group = "AI" },
		{ "<leader>aa", "<cmd>'<,'>Gen Ask<CR>", desc = "Ask" },
		{ "<leader>ae", "<cmd>'<,'>Gen Enhance_Code<CR>", desc = "Enhance" },
		{ "<leader>ag", "<cmd>'<,'>Gen Enhance_Grammar_Spelling<CR>", desc = "Grammar" },
		{ "<leader>ar", "<cmd>'<,'>Gen Review_Code<CR>", desc = "Review" },
		{ "<leader>as", "<cmd>'<,'>Gen Make_Concise<CR>", desc = "Simple and consise" },
		{ "<leader>aw", "<cmd>'<,'>Gen Enhance_Wording<CR>", desc = "Wording" },
	},
})



wk.add({
	{
		mode = { "n" },
		{ "<leader>c", group = "VCS" },
		{ "<leader>h", group = "Help" },
		{ "<leader>r", ":so %<CR>", desc = "Reload config" },
		{ "<leader>ht", ":FzfLua help_tags<CR>", desc = "Help" },
		{ "<leader>hk", ":FzfLua keymaps<CR>", desc = "Keys" },
		{ "<leader>hm", ":messages<CR>", desc = "Messages" },
		{ "<leader>t", ':lua BgToggleSol()<CR>', desc = "Toggle Theme" },
		{ "<leader>q", ':qa!<CR>', desc = "Quit" },
		{ "<leader>z", function() 
			require("zen-mode").toggle()
			vim.cmd("highlight ZenBg guibg=0 guifg=0")	
		end, desc = "Zoom" },

	}
})


