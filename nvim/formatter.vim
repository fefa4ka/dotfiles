" Formatter
let g:prettier#config#tab_width = '4'
autocmd FileType c,cpp setlocal equalprg=clang-format
map <C-K> :pyf /usr/local/Cellar/clang-format/10.0.0/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/local/Cellar/clang-format/10.0.0/share/clang/clang-format.py<cr>


" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
