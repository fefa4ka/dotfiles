call plug#begin('~/.config/nvim/plugged')

" Navigation
Plug 'phaazon/hop.nvim'

" Color
Plug 'morhetz/gruvbox'

call plug#end()


set timeoutlen=100

nnoremap jk dd
nnoremap ол dd
inoremap jk <ESC>
inoremap kj <ESC>
" Cyrillyc doesn't work
inoremap ол <ESC>
inoremap ло <ESC>

" Press i to enter insert mode, and ii to exit.
inoremap ii <ESC>

