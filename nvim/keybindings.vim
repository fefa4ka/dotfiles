" Keybindings
let g:which_key_map = {}

" Leader Space l
" local = ,
let g:mapleader = "\<Space>"
" let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>


" nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" Remap ESC
nnoremap jk dd
nnoremap ол dd
inoremap jk <ESC>
inoremap kj <ESC>
" Cyrillyc doesn't work
inoremap ол <ESC>
inoremap ло <ESC>

" Press i to enter insert mode, and ii to exit.
inoremap ii <ESC>
inoremap <ESC> <nop>

" Tabs
nnoremap gtn :tabnew<CR>
nnoremap gtc :tabclose<CR>

" Input mode
inoremap <C-z> <esc>ua
inoremap <C-Z> <esc>Ua
inoremap <C-v> <esc>pa


" Force train
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>

" File Navigation
noremap <silent> <C-E> :call ToggleNetrw()<CR><Paste>
nmap <C-g> :GFiles<CR>
nmap <C-s> :Files<CR>
nmap <C-p> :Commands<CR>
nmap <ESC> :Buffers<CR>
nmap <C-t> :TagbarToggle<CR>


" Undo Redo
map <C-r> :redo<CR>
" Less keystrokes
nnoremap ; :
vnoremap ; :
nnoremap U <C-r>

" Delete
inoremap <C-d> <esc>ddi

" Smart way to move between windows
map <C-_> <C-W>S
map <C-\> <C-W>v
map <C-q> <C-W>q <C-W>q
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" move to beginning/end of line
nnoremap B ^
nnoremap E $


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" Remap keys for gotos
nmap <silent> s :HopChar1<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Add note related to file and line
map # :NotesPromptCommand<CR>

" Create reminder related to file and line
map <C-2> :ReminderPromptCommand<CR>


" Toggle dark/light theme
let g:which_key_map.t = 'toggle theme'
nnoremap <silent> <leader>t :call BgToggleSol()<cr>

" Toggle zen mode
map <leader>z :call TmuxGoyo()<cr>
let g:which_key_map.z = 'zen'


" Shift+scroll for horizontal scrolling
nnoremap <S-ScrollWheelUp> <ScrollWheelLeft>
nnoremap <S-2-ScrollWheelUp> <2-ScrollWheelLeft>
nnoremap <S-3-ScrollWheelUp> <3-ScrollWheelLeft>
nnoremap <S-4-ScrollWheelUp> <4-ScrollWheelLeft>
nnoremap <S-ScrollWheelDown> <ScrollWheelRight>
nnoremap <S-2-ScrollWheelDown> <2-ScrollWheelRight>
nnoremap <S-3-ScrollWheelDown> <3-ScrollWheelRight>

vnoremap <silent> q :VBox<CR>
vnoremap <silent> Q :VBoxH<CR>


" Normal mode: Jump to definition under cursor
nnoremap <leader>j :AnyJump<CR>


" Show all diagnostics
nnoremap <silent> <space>e  :<C-u>CocList diagnostics<cr>
let g:which_key_map.e = 'diagnostics'


" Show commands
nnoremap <silent> <space>a  :<C-u>CocList commands<cr>
let g:which_key_map.a = 'routines'


" Docs in Dash
nmap <silent> <leader>d <Plug>DashSearch
let g:which_key_map.d = 'help'


" Search in workdir
nmap <silent> <leader>/ <Plug>CtrlSFPrompt
" let g:which_key_map./ = 'find'

nmap <silent> <leader>w <Plug>CtrlSFCwordPath
let g:which_key_map.w = 'find-word'


" Prompt for a command to run
map <Leader>cc :VimuxPromptCommand<CR>
map <Leader>cr :VimuxRunLastCommand<CR>
let g:which_key_map.c = { 'name' : '+command' }
let g:which_key_map.c.c = 'run-command'
let g:which_key_map.c.r = 'run-last'


" Git
" Git blame info
nnoremap <Leader>i :<C-u>call gitblame#echo()<CR>
let g:which_key_map.i = 'blame'



" Config
map <leader>vimrc :tabe ~/dotfiles/nvim/init.vim<cr>
autocmd bufwritepost init.vim source $MYVIMRC
let g:which_key_map.v = { 'name' : '+vimrc' }


nnoremap '.  :exe ":FZF " . expand("%:h")<CR>


vnoremap b <Plug>nvim-magic-append-completion

nnoremap <silent> K :call <SID>show_documentation()<CR>


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
