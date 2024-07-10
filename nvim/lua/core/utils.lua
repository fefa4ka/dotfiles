function require_vim(config)
	-- Specify the path to your Vim configuration file
	local nvimConfigPath = vim.fn.stdpath('config')
	local vimConfigPath = nvimConfigPath .. "/" .. config

	-- Read the Vim configuration file
	local vimConfigFile = io.open(vimConfigPath, "r")
	local vimConfigContents = vimConfigFile:read("*all")
	vimConfigFile:close()

	-- Execute the Vim configuration in Neovim
	vim.api.nvim_exec(vimConfigContents, false)
end

local cfg = vim.fn.stdpath('config')
Flush = function()
    local s = vim.api.nvim_buf_get_name(0)
    if string.match(s, '^' .. cfg .. '*') == nil then
        return
    end
    s = string.sub(s, 6 + string.len(cfg), -5)
    local val = string.gsub(s, '%/', '.')
    package.loaded[val] = nil
end

function BgToggleSol()
    if vim.o.background == "light" then
--        vim.cmd('set background=dark')
	vim.cmd("silent !/Users/fefa4ka/dotfiles/scripts/switch_theme")
    else
	vim.cmd("silent !/Users/fefa4ka/dotfiles/scripts/switch_theme")
        -- vim.cmd('hi normal guibg=none ctermbg=none')
    end
end

