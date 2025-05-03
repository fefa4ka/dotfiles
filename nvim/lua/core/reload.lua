-- Module for handling Neovim configuration reloading
local M = {}

-- Clear package cache for config modules
function M.clear_cache()
  -- Get all loaded modules
  local modules = {}
  for module_name, _ in pairs(package.loaded) do
    -- Only clear modules that are part of our config
    if module_name:match('^config%.') or
       module_name:match('^core%.') or
       module_name:match('^plugins%.') then
      modules[#modules + 1] = module_name
    end
  end

  -- Unload all matched modules
  for _, module_name in ipairs(modules) do
    package.loaded[module_name] = nil
  end

  return #modules
end

-- Reload the entire Neovim configuration
function M.reload_config()
  -- Clear module cache
  local cleared = M.clear_cache()

  -- Store current colorscheme
  local current_colorscheme = vim.g.colors_name

  -- Reload key configuration modules
  for _, module in ipairs({
    "config.keymaps",
    "config.ui",
    "config.options",
    "config.autocmd"
  }) do
    if package.loaded[module] then
      package.loaded[module] = nil
      local ok, mod = pcall(require, module)
      if ok and mod and type(mod.setup) == "function" then
        pcall(mod.setup)
      end
    end
  end

  -- Reapply colorscheme
  if current_colorscheme then
    vim.cmd('colorscheme ' .. current_colorscheme)
  end

  -- Notify user
  vim.notify(
    string.format("Neovim configuration reloaded! (%d modules cleared)", cleared),
    vim.log.levels.INFO
  )

  return true
end

return M
