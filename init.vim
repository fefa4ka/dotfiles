
call plug#begin('~/.config/nvim/plugged')

" Welcome
Plug 'mhinz/vim-startify'

" Navigation
Plug 'pechorin/any-jump.vim'
Plug 'phaazon/hop.nvim'
Plug 'jbyuki/venn.nvim'

" Color
Plug 'folke/twilight.nvim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'morhetz/gruvbox'

" Docs
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'rizzatti/dash.vim'
Plug 'majutsushi/tagbar'

" Filesystem
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'

" LSP
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'sheerun/vim-polyglot'
Plug 'rhysd/vim-gfm-syntax'
Plug 'z0mbix/vim-shfmt'
Plug 'jupyter-vim/jupyter-vim'
Plug 'github/copilot.vim'

" Debuglug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

" Git
Plug 'airblade/vim-gitgutter'
Plug 'zivyangll/git-blame.vim'

" WM and Tmux
Plug 'benmills/vimux'

" Zen
Plug 'junegunn/goyo.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }


call plug#end()

set timeoutlen=20

" Keybindings
let g:which_key_map = {}

" Leader Space l
" local = ,
let g:mapleader = "\<Space>"
" let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" UX
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
colorscheme gruvbox
set number relativenumber

" Highlight spaces and tabs
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
let g:netrw_winsize = 20
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_preview = 0
let g:netrw_alto = 1
let g:NetrwIsOpen=0

autocmd filetype netrw call Netrw_mappings()
function! Netrw_mappings()
    noremap <buffer>% :call CreateInPreview()<cr>
    nmap <buffer> h -:call DrawNetrwIcons()<CR>
    nmap <buffer> l <CR>:call DrawNetrwIcons()<CR>
    nmap <buffer> s o
    nmap <silent> <buffer> R :e<CR>:call DrawNetrwIcons()<CR>
    nmap <silent> <buffer> r :e<CR>:call DrawNetrwIcons()<CR>

    " Netrw overrides <C-l>, this sets it back to MoveToRight
    nmap <silent> <buffer> <C-l> :MoveToRight<CR>
endfunction
function! CreateInPreview()
    let l:filename = input("please enter filename: ")
    execute 'silent !touch ' . b:netrw_curdir.'/'.l:filename
    redraw!
endf
if argv(0) ==# '.'
    let g:netrw_browse_split = 0
else
    let g:netrw_browse_split = 4
endif

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
        call DrawNetrwIcons()
    endif
endfunction

noremap <silent> <C-E> :call ToggleNetrw()<CR><Paste>

" Add icons to netrw
sign define netrw_dir text= texthl=netrwDir
sign define netrw_exec text= texthl=netrwExe
sign define netrw_link text=⤤ texthl=netrwSymLink
sign define netrw_file text= texthl=netrwPlain

sign define netrw_c text= texthl=netrwPlain
sign define netrw_go text= texthl=netrwPlain
sign define netrw_js text= texthl=netrwPlain
sign define netrw_py text= texthl=netrwPlain
sign define netrw_rs text= texthl=netrwPlain
sign define netrw_ts text= texthl=netrwPlain

sign define netrw_conf text= texthl=netrwPlain
sign define netrw_db text= texthl=netrwPlain
sign define netrw_html text= texthl=netrwPlain
sign define netrw_json text= texthl=netrwPlain
sign define netrw_md text= texthl=netrwPlain

sign define netrw_img text= texthl=netrwPlain
sign define netrw_sound text=♫ texthl=netrwPlain

function! DrawNetrwIcons()
    if &filetype != 'netrw'
        return
    endif

    let l:bufnr = bufnr('')
    exec 'sign unplace * buffer='.l:bufnr

    let l:line_nr=1
    let l:num_lines=line('$')
    while l:line_nr <= l:num_lines
        let l:sign_name = 'netrw_file'
        let l:line = getline(l:line_nr)

        if l:line == ''
            let l:line_nr += 1
            continue
        endif

        if l:line =~ '/$'
            let l:sign_name = 'netrw_dir'
        elseif l:line =~ '@\t --> '
            let l:sign_name = 'netrw_link'
        elseif l:line =~ '\*$'
            let l:sign_name = 'netrw_exec'

        elseif l:line =~ '\.\(c\|cc\|cpp\)$'
            let l:sign_name = 'netrw_c'
        elseif l:line =~ '\.go$\|^go.mod$\|^go.sum$'
            let l:sign_name = 'netrw_go'
        elseif l:line =~ '\.\(js\|jsx\)$'
            let l:sign_name = 'netrw_js'
        elseif l:line =~ '\.pyc\?$'
            let l:sign_name = 'netrw_py'
        elseif l:line =~ '\.rs$\|^Cargo.lock$\|^Cargo.toml$'
            let l:sign_name = 'netrw_rs'
        elseif l:line =~ '\.\(tsx\|ts\)$'
            let l:sign_name = 'netrw_ts'

        elseif l:line =~ '*gitignore$\|^\.dockerignore$'
            let l:sign_name = 'netrw_conf'
        elseif l:line =~ '\.\(sql\|dump\|db\)$'
            let l:sign_name = 'netrw_db'
        elseif l:line =~ '\.\(htm\|html\)$'
            let l:sign_name = 'netrw_html'
        elseif l:line =~ '\.\(json$\|yaml\|yml\)$'
            let l:sign_name = 'netrw_json'
        elseif l:line =~ '\.md$'
            let l:sign_name = 'netrw_md'

        elseif l:line =~ '\.\(gif\|png\|ico\|jpg\|bmp\|svg\)$'
            let l:sign_name = 'netrw_img'
        elseif l:line =~ '\.\(mp3\|f4a\|flac\|wav\)$'
            let l:sign_name = 'netrw_sound'
        endif

        exec 'sign place '.l:line_nr.' line='.l:line_nr.' name='.l:sign_name.' buffer='.l:bufnr
        let l:line_nr += 1
    endwhile

endfunction
nmap <C-g> :GFiles<CR>
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>
nmap <C-t> :TagbarToggle<CR>



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
nmap <silent> s :HopChar1<CR>
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

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>e  :<C-u>CocList diagnostics<cr>
let g:which_key_map.e = 'diagnostics'
" Show commands
nnoremap <silent> <space>a  :<C-u>CocList commands<cr>
let g:which_key_map.a = 'routines'


nmap <silent> <leader>d <Plug>DashSearch
let g:which_key_map.d = 'help'


nmap <silent> <leader>f <Plug>CtrlSFPrompt
let g:which_key_map.f = 'find'
nmap <silent> <leader>w <Plug>CtrlSFCwordPath
let g:which_key_map.w = 'find-word'

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

" Prompt for a command to run
map <Leader>cc :VimuxPromptCommand<CR>
map <Leader>cr :VimuxRunLastCommand<CR>
let g:which_key_map.c = { 'name' : '+command' }
let g:which_key_map.c.c = 'run-command'
let g:which_key_map.c.r = 'run-last'

" fzf recursive git ignore with bat preview
let $FZF_DEFAULT_OPTS="--color=dark --layout=reverse --margin=1,1 --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,pointer:12,marker:4,spinner:11,header:-1"
let $FZF_DEFAULT_COMMAND="ag `ls */.gitignore | awk '{ print \"-p \" $1 }' ORS=' '` -g ''"
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --style=numbers --color=always {}']}, <bang>0)

" Git blame info
nnoremap <Leader>i :<C-u>call gitblame#echo()<CR>
let g:which_key_map.i = 'blame'


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
        hi normal guibg=none ctermbg=none
        function! BgToggleSol()
            if (&background == "light")
                set background=dark
                silent !alacritty_theme -set gruvbox_dark
                silent !tmux source-file ~/dotfiles/tmux/tmux.dark.theme
                silent !echo "set background=dark"> ~/.config/theme
                silent !osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true"
                hi normal guibg=none ctermbg=none
            else
                set background=light
                silent !alacritty_theme -set gruvbox_light
                silent !tmux source-file ~/dotfiles/tmux/tmux.light.theme
                silent !echo "set background=light"> ~/.config/theme
                silent !osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false"
                hi normal guibg=none ctermbg=none
            endif
        endfunction

        nnoremap <silent> <leader>t :call BgToggleSol()<cr>


        " Zen
        function! s:goyo_enter()
            if executable('tmux') && strlen($TMUX)
                silent !tmux set status off
                silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
            endif
            set noshowmode
            set noshowcmd
            set scrolloff=999
        endfunction

        function! s:goyo_leave()
            if executable('tmux') && strlen($TMUX)
                silent !tmux set status on
                silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
            endif
            set showmode
            set showcmd
            set scrolloff=5
            hi normal guibg=none ctermbg=none
        endfunction

        autocmd! User GoyoEnter nested call <SID>goyo_enter()
        autocmd! User GoyoLeave nested call <SID>goyo_leave()
        let g:goyo_width = 146

        function! TmuxGoyo()
            silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
            sleep 10m
            Goyo
        endfunction

        map <leader>z :call TmuxGoyo()<cr>
        let g:which_key_map.z = 'zen'


        " Scroll
        set breakindent
        set breakindentopt=sbr
        " I use a unicode curly array with a <backslash><space>
        set showbreak=↪>\

        " Shift+scroll for horizontal scrolling
        nnoremap <S-ScrollWheelUp> <ScrollWheelLeft>
        nnoremap <S-2-ScrollWheelUp> <2-ScrollWheelLeft>
        nnoremap <S-3-ScrollWheelUp> <3-ScrollWheelLeft>
        nnoremap <S-4-ScrollWheelUp> <4-ScrollWheelLeft>
        nnoremap <S-ScrollWheelDown> <ScrollWheelRight>
        nnoremap <S-2-ScrollWheelDown> <2-ScrollWheelRight>
        nnoremap <S-3-ScrollWheelDown> <3-ScrollWheelRight>


        " Config
        map <leader>vimrc :tabe ~/dotfiles/init.vim<cr>
        autocmd bufwritepost init.vim source $MYVIMRC
        let g:which_key_map.v = { 'name' : '+vimrc' }


        " Theme
        source ~/.config/theme
        hi normal guibg=none ctermbg=none


        " Strip trailing spaces
        autocmd BufWritePre * :%s/\s\+$//e


        " Turn on tmux panes on first start
        autocmd VimEnter * silent !tmux set status on
        autocmd VimEnter * silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z

        " Custom cwd for tabs
        "below is reload GTAGS, ctags demo code.
        function! TabReloadCGtag()
            "reload GTAGS in current directory
            cs kill 0
            "gnu global produce GTAGS, more useful than cscope
            cs add GTAGS
            "reload tags in current directory
            set tags=tags
        endfunction

        "some action when enter a tab
        function! TabEnterTag(nr)
            "echo "tab ". a:nr . " enter"
            call TabReloadCGtag()
        endfunction

        " some action when leave a tab
        function! TabLeaveTag(nr)
            "echo "tab ". a:nr . " leaves"
            "nothing
        endfunction

        "don't care about pattern field for now
        let g:TabTagTrigger = {'name':'TabTagTriger','pattern':"", 'enter_callback':"TabEnterTag", 'leave_callback':"TabLeaveTag" }

        call which_key#register('<Space>', "g:which_key_map")


        " Navigation
        let g:any_jump_disable_default_keybindings = 1

        " Normal mode: Jump to definition under cursor
        nnoremap <leader>j :AnyJump<CR>

" Vienn
set ve=all
vnoremap <silent> q :VBox<CR>
vnoremap <silent> Q :VBoxH<CR>


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

