-- Russian keyboard mapping
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Russian map
map('', 'ё', '`')
map('', 'й', 'q')
map('', 'ц', 'w')
map('', 'у', 'e')
map('', 'к', 'r')
map('', 'е', 't')
map('', 'н', 'y')
map('', 'г', 'u')
map('', 'ш', 'i')
map('', 'щ', 'o')
map('', 'з', 'p')
map('', 'ф', 'a')
map('', 'ы', 's')
map('', 'в', 'd')
map('', 'а', 'f')
map('', 'п', 'g')
map('', 'р', 'h')
map('', 'о', 'j')
map('', 'л', 'k')
map('', 'д', 'l')
map('', 'ж', ';')
map('', 'э', '\'')
map('', 'я', 'z')
map('', 'ч', 'x')
map('', 'с', 'c')
map('', 'м', 'v')
map('', 'и', 'b')
map('', 'т', 'n')
map('', 'ь', 'm')
map('', 'б', ',')
map('', 'ю', '.')
map('', 'Ё', '~')
map('', 'Й', 'Q')
map('', 'Ц', 'W')
map('', 'У', 'E')
map('', 'К', 'R')
map('', 'Е', 'T')
map('', 'Н', 'Y')
map('', 'Г', 'U')
map('', 'Ш', 'I')
map('', 'Щ', 'O')
map('', 'З', 'P')
map('', 'Ф', 'A')
map('', 'Ы', 'S')
map('', 'В', 'D')
map('', 'А', 'F')
map('', 'П', 'G')
map('', 'Р', 'H')
map('', 'О', 'J')
map('', 'Л', 'K')
map('', 'Д', 'L')
map('', 'Ж', ':')
map('', 'Э', '"')
map('', 'Я', 'Z')
map('', 'Ч', 'X')
map('', 'С', 'C')
map('', 'М', 'V')
map('', 'И', 'B')
map('', 'Т', 'N')
map('', 'Ь', 'M')
map('', 'Б', '<')
map('', 'Ю', '>')

-- Common command abbreviations
vim.cmd([[
  cnoreabbrev W w
  cnoreabbrev ц w
  cnoreabbrev Ц w
  
  cnoreabbrev X x
  cnoreabbrev ч x
  cnoreabbrev ч x
]])

-- Command for quitting all windows
vim.api.nvim_create_user_command('Q', 'qa!', {})
vim.cmd([[
  cnoreabbrev Й Q
  cnoreabbrev й q
]])

-- Bracket mappings
map('', 'Х', '{')
map('', 'Ъ', '}')
map('', 'х', '[')
map('', 'ъ', ']')
