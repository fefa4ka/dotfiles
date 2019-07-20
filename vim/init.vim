set exrc
set secure

set mouse=a

set number relativenumber

" Tabs
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.config/nvim/plugged')
" Make sure you use single quotes

Plug 'tpope/vim-sensible'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" File System
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'albfan/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'yuttie/comfortable-motion.vim'

" Color
Plug 'morhetz/gruvbox'

" Docs
Plug 'rizzatti/dash.vim'
Plug 'majutsushi/tagbar'

Plug 'Valloric/YouCompleteMe'

Plug 'leafgarland/typescript-vim'

Plug 'critiqjo/lldb.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'arakashic/chromatica.nvim'


" Initialize plugin system
call plug#end()

""" Plugin Configurations

" NERDTree
let NERDTreeShowHidden            = 1
let g:NERDTreeDirArrowExpandable  = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
autocmd vimenter * NERDTree

set guifont=Fira\ Code\ 10

" .gitignore
function! GitDimIgnoredFiles()
    let gitcmd = 'git -c color.status=false status -s --ignored'
    if exists('b:NERDTree')
        let root = b:NERDTree.root.path.str()
    else
        let root = './'
    endif
    let files = split(system(gitcmd.' '.root), '\n')

    call GitFindIgnoredFiles(files)
endfunction

function! GitFindIgnoredFiles(files)
    for file in a:files
        let pre = file[0:1]
        if pre == '!!'
            let ignored = split(file[3:], '/')[-1]
            exec 'syn match Comment #\<'.escape(ignored, '~').'\(\.\)\@!\># containedin=NERDTreeFile'
        endif
    endfor
endfunction


autocmd FileType nerdtree       :call GitDimIgnoredFiles()


nmap <C-p> :GFiles<CR>
nmap <C-t> :TagbarToggle<CR>
nnoremap <silent> <expr> <C-e> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"


color gruvbox

" Focus on editor
autocmd VimEnter * wincmd w

nnoremap <C-g> :Ag <C-R><C-W><CR>


" C syntax
let g:chromatica#libclang_path='/usr/local/opt/llvm/lib'
let g:chromatica#enable_at_startup=1

" Remap VIM 0 to first non-blank character
map 0 ^

let mapleader = ","
let g:mapleader = ","

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Close all the buffers
map <leader>ba :bufdo bd<cr>
