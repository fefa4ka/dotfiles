
call plug#begin('~/.config/nvim/plugged')

" Sandbox
Plug 'jupyter-vim/jupyter-vim'

" Color
Plug 'danilo-augusto/vim-afterglow'
Plug 'morhetz/gruvbox'

" Docs
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'rizzatti/dash.vim'
Plug 'majutsushi/tagbar'

" Filesystem
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'sheerun/vim-polyglot'
Plug 'rhysd/vim-gfm-syntax'

" Debug
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

" Git
Plug 'airblade/vim-gitgutter'
Plug 'zivyangll/git-blame.vim'

" WM and Tmux
Plug 'benmills/vimux'

" Zen
Plug 'junegunn/goyo.vim'


call plug#end()


set timeoutlen=20

" UX


if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme gruvbox 
set number relativenumber
 
set list lcs=trail:·,tab:»·

set mouse=a
set clipboard=unnamed
set nowrap
" Search down into subfolders
set path+=**

nnoremap '.  :exe ":FZF " . expand("%:h")<CR>

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:NetrwIsOpen=0

autocmd filetype netrw call Netrw_mappings()
function! Netrw_mappings()
  noremap <buffer>% :call CreateInPreview()<cr>
endfunction
function! CreateInPreview()
  let l:filename = input("please enter filename: ")
  execute 'silent !touch ' . b:netrw_curdir.'/'.l:filename 
  redraw!
endf

function! ToggleNetrw()
  if g:NetrwIsOpen
      let i = bufnr("$")
      while (i >= 1)
          if (getbufvar(i, "&filetype") == "netrw")
              silent exe "bwipeout " . i
          endif
          let i-=1
      endwhile
      let g:NetrwIsOpen=0
  else
      let g:NetrwIsOpen=1
      silent Lexplore %:h
  endif
endfunction
" Add your own mapping. For example

noremap <silent> <C-E> :call ToggleNetrw()<CR><Paste>
nmap <C-g> :GFiles<CR>
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>
nmap <C-t> :TagbarToggle<CR>


" Leader ,
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" Undo Redo
map <C-r> :redo<CR>
" Less keystrokes
nnoremap ; :
vnoremap ; :
nnoremap U <C-r>





" Smart way to move between windows
map <C-_> <C-W>S
map <C-\> <C-W>v
map <C-q> <C-W>q
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" move to beginning/end of line
nnoremap B ^
nnoremap E $

" if hidden is not set, TextEdit might fail.
set hidden


" Tabs
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab


" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=200

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes


" coc config
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-ccls',
  \ 'coc-python',
  \ ]

" Formatter
let g:prettier#config#tab_width = '4'
autocmd FileType c,cpp setlocal equalprg=clang-format
map <C-K> :pyf /usr/local/Cellar/clang-format/10.0.0/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/local/Cellar/clang-format/10.0.0/share/clang/clang-format.py<cr>

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break do chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>e  :<C-u>CocList diagnostics<cr>
" Show commands
nnoremap <silent> <space>a  :<C-u>CocList commands<cr>


nmap <silent> <leader>d <Plug>DashSearch

nmap <silent> <leader>f <Plug>CtrlSFPrompt
nmap <silent> <leader>w <Plug>CtrlSFCwordPath 

" Jupyter
let g:jupyter_mapkeys = 0 

nnoremap <silent> <leader>jc :JupyterConnect<CR>

" Debugging maps
nnoremap <silent> <leader>jb :PythonSetBreak<CR>

nnoremap <silent> <leader>jr :JupyterRunFile<cr>
nnoremap <silent> <leader>ji :PythonImportThisFile<CR>

" Change to directory of current file
nnoremap <silent> <leader>jd :JupyterCd %:p:h<CR>

" Send a selection of lines
nnoremap <silent> <leader>g :JupyterSendCell<CR>
nnoremap <silent> <leader>x :JupyterSendRange<CR>

" Prompt for a command to run
map <Leader>c :VimuxPromptCommand<CR>
map <Leader>rr :VimuxRunLastCommand<CR>

" fzf recursive git ignore with bat preview
let $FZF_DEFAULT_OPTS="--color=dark --layout=reverse --margin=1,1 --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,pointer:12,marker:4,spinner:11,header:-1"
let $FZF_DEFAULT_COMMAND="ag `ls */.gitignore | awk '{ print \"-p \" $1 }' ORS=' '` -g ''"
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --style=numbers --color=always {}']}, <bang>0)

" Git blame info
nnoremap <Leader>i :<C-u>call gitblame#echo()<CR> 


" Notes
"
map # :NotesPromptCommand<CR>
command! -nargs=? NotesPromptCommand :call NotesPromptCommand(<args>)
function! NotesPromptCommand(...)
    let command = a:0 == 1 ? a:1 : ""
    let l:command = input(_NotesOption("g:NotesPromptString", "Note: "), command)

    silent execute '!notes add_to' '"'.expand("%:p").':'.line('.').'"' '"'.escape(l:command, '\"$`').'"'
endfunction

function! _NotesOption(option, default)
  if exists(a:option)
    return eval(a:option)
  else
    return a:default
  endif
endfunction

" Reminder 
"
map @ :ReminderPromptCommand<CR>
command! -nargs=? ReminderPromptCommand :call ReminderPromptCommand(<args>)
function! ReminderPromptCommand(...)
    let command = a:0 == 1 ? a:1 : ""
    let l:command = input(_NotesOption("g:NotesPromptString", "Remind: "), command)

    silent execute '!remind' '"'.escape(l:command, '\"$`').'"' '"'.expand("%:p").':'.line('.').'"'
endfunction

function! _NotesOption(option, default)
  if exists(a:option)
    return eval(a:option)
  else
    return a:default
  endif
endfunction

" Russian map
map ё `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]
map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .
map Ё ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ъ }
map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >

cnoreabbrev W w
cnoreabbrev ц w
cnoreabbrev Ц w

cnoreabbrev X x
cnoreabbrev ч x
cnoreabbrev ч x

command! Q qa!
cnoreabbrev Й Q 
cnoreabbrev й q 


" Fold
set foldmethod=syntax
set foldnestmax=2
autocmd BufReadPost *.py :set foldmethod=indent


" Transparency
set termguicolors
hi Normal guibg=NONE ctermbg=NONE
