-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Session management functions
local function get_unique_session_name()
  local path = vim.fn.fnamemodify(vim.fn.getcwd(), ':~:t')
  if path == "" then
    path = 'no-project'
  end
  return vim.fn.substitute(path, '/', '-', 'g')
end

-- Autosave session for current working directory
vim.api.nvim_create_autocmd("User", {
  pattern = "StartifyReady",
  callback = function()
    vim.cmd('silent execute \'SLoad \' . \'' .. get_unique_session_name() .. '\'')
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    vim.cmd('silent execute \'SSave! \' . \'' .. get_unique_session_name() .. '\'')
  end,
})

-- Session options
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,options"

-- Ensure syntax highlighting is enabled after loading a session
vim.api.nvim_create_autocmd("SessionLoadPost", {
  pattern = "*",
  command = "filetype detect",
})

-- Keep windows equal size when resizing Vim
vim.opt.equalalways = true
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})
