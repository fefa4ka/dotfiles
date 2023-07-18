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

