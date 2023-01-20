
" Plugins
"
call plug#begin('~/.config/nvim/plugged')

" Welcome
Plug 'mhinz/vim-startify'

" Navigation
Plug 'pechorin/any-jump.vim'
Plug 'phaazon/hop.nvim'
Plug 'jbyuki/venn.nvim'

" Color
Plug 'folke/twilight.nvim'
Plug 'morhetz/gruvbox'

" Docs
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'rizzatti/dash.vim'
Plug 'majutsushi/tagbar'

" Filesystem
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'sheerun/vim-polyglot'
Plug 'rhysd/vim-gfm-syntax'
Plug 'z0mbix/vim-shfmt'
Plug 'jupyter-vim/jupyter-vim'
Plug 'cyberkov/openhab-vim'

" Debuglug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

" Git
Plug 'airblade/vim-gitgutter'
Plug 'zivyangll/git-blame.vim'

" WM and Tmux
Plug 'gcmt/taboo.vim'
Plug 'benmills/vimux'

" Zen
Plug 'junegunn/goyo.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

call plug#end()


" coc config
let g:coc_global_extensions = [
            \ 'coc-pairs',
            \ 'coc-tsserver',
            \ 'coc-eslint',
            \ 'coc-prettier',
            \ 'coc-json',
            \ 'coc-clangd',
            \ 'coc-python',
            \ ]


" Config
source ~/dotfiles/nvim/netrw.vim
source ~/dotfiles/nvim/routines.vim
source ~/dotfiles/nvim/formatter.vim
source ~/dotfiles/nvim/keybindings.vim
source ~/dotfiles/nvim/layout.vim
source ~/dotfiles/nvim/autocomplete.vim

set timeoutlen=100

" UX
" Theme
source ~/.config/theme
hi normal guibg=none ctermbg=none
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
colorscheme gruvbox
set number relativenumber

lua << EOF

require("twilight").setup {
    {
            dimming = {
                alpha = 0.25,
                -- we try to get the foreground from the highlight groups or fallback color
                inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
            },
            context = 10,
            treesitter = true,
            expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                "function",
                "method",
                "table",
                "if_statement",
            }
    }
}
EOF

lua require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', jump_on_sole_occurrence = false }


" Highlight spaces and tabs
set list lcs=trail:·,tab:»·

set mouse=a
set clipboard=unnamed
set nowrap
" Search down into subfolders
set path+=**

nnoremap '.  :exe ":FZF " . expand("%:h")<CR>

" if hidden is not set, TextEdit might fail.
set hidden

" Fold
set foldmethod=syntax
set foldnestmax=2
autocmd BufReadPost *.py :set foldmethod=indent


" Transparency
set termguicolors
hi normal guibg=none ctermbg=none

" Tabs
" show existing tab with 4 spaces width
set tabstop=4
autocmd Filetype tsx setlocal tabstop=2 shiftwidth=2
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
set signcolumn=number

" Draw Vienn Boxes
set ve=all

" Highlight symbol under cursor on CursorHold
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Jupyter
let g:jupyter_mapkeys = 0

nnoremap <silent> <leader>pc :JupyterConnect<CR>

" Debugging maps
nnoremap <silent> <leader>pb :PythonSetBreak<CR>

nnoremap <silent> <leader>pr :JupyterRunFile<cr>
nnoremap <silent> <leader>pi :PythonImportThisFile<CR>

" Change to directory of current file
nnoremap <silent> <leader>pd :JupyterCd %:p:h<CR>
let g:which_key_map.p = { 'name' : '+jupyter' }
let g:which_key_map.p.c = 'connect'
let g:which_key_map.p.d = 'change-directory'
let g:which_key_map.p.b = 'breakpoint'
let g:which_key_map.p.r = 'run-file'
let g:which_key_map.p.i = 'import-file'


" Send a selection of lines
nnoremap <silent> <leader>g :JupyterSendCell<CR>
nnoremap <silent> <leader>x :JupyterSendRange<CR>

" fzf recursive git ignore with bat preview
let $FZF_DEFAULT_OPTS="--color=dark --layout=reverse --margin=1,1 --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,pointer:12,marker:4,spinner:11,header:-1"
let $FZF_DEFAULT_COMMAND="ag `ls */.gitignore | awk '{ print \"-p \" $1 }' ORS=' '` -g ''"
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --style=numbers --color=always {}']}, <bang>0)


" Strip trailing spaces
autocmd BufWritePre * :%s/\s\+$//e


" Turn on tmux panes on first start
autocmd VimEnter * silent !tmux set status on
autocmd VimEnter * silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z


"autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")

" Navigation
let g:any_jump_disable_default_keybindings = 1

" Working directory per tab
function! OnTabEnter(path)
    if isdirectory(a:path)
        let dirname = a:path
    else
        let dirname = fnamemodify(a:path, ":h")
    endif
    execute "tcd ". dirname
endfunction()

autocmd TabNewEntered * call OnTabEnter(expand("<amatch>"))

autocmd BufRead *.md setlocal wrap linebreak


" Abbreviations for speed coding
:autocmd FileType python     :iabbrev <buffer> iff if:<left>
:autocmd FileType javascript :iabbrev <buffer> iff if ()<left>

" Log datetime
"map <Leader>l i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
"imap <C-l> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>


" Welcome
let g:startify_lists = [
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'commands',  'header': ['   Commands']       },
            \ ]

set noswapfile

set sessionoptions+=tabpages,globals


" Shell formatting
let g:shfmt_extra_args = '-i 4'

