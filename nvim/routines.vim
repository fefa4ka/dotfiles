function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction


" Notes
"
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


" Toggle dark/light theme
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

function! TmuxGoyo()
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    Twilight
    sleep 10m
    Goyo
endfunction

let g:goyo_width = 146
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" eer
function! EERComp(name)
    let name="/Users/fefa4ka/Documents/ee-react/eer-apps/lego/".fnameescape(a:name)."/".fnameescape(a:name)
    execute "e ".fnameescape(name).".c | lefta vsplit CMakeLists.txt | split ".fnameescape(name).".h"
endfunction


