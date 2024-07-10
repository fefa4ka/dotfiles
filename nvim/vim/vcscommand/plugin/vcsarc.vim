" vim600: set foldmethod=marker:
"
" ARC extension for VCSCommand.
"
" Maintainer:    Vsevolod Velichko <torkvemada@sorokdva.net>
"
" Section: Documentation {{{1
"
" Options documentation: {{{2
"
" VCSCommandARCExec
"   This variable specifies the ARC executable.  If not set, it defaults to

" Section: Plugin header {{{1

if exists('VCSCommandDisableAll')
	finish
endif

if v:version < 700
	echohl WarningMsg|echomsg 'VCSCommand requires at least VIM 7.0'|echohl None
	finish
endif

if !exists('g:loaded_VCSCommand')
	runtime plugin/vcscommand.vim
endif

if !executable(VCSCommandGetOption('VCSCommandARCExec', 'arc'))
	finish
endif

let s:save_cpo=&cpo
set cpo&vim

" Section: Variable initialization {{{1

let s:arcFunctions = {}

" Section: Utility functions {{{1

" Function: s:Executable() {{{2
" Returns the executable used to invoke git suitable for use in a shell
" command.
function! s:Executable()
	return shellescape(VCSCommandGetOption('VCSCommandARCExec', 'arc'))
endfunction

" Function: s:DoCommand(cmd, cmdName, statusText, options) {{{2
" Wrapper to VCSCommandDoCommand to add the name of the ARC executable to the
" command argument.
function! s:DoCommand(cmd, cmdName, statusText, options)
	if VCSCommandGetVCSType(expand('%')) == 'arc'
		let fullCmd = s:Executable() . ' ' . a:cmd
		return VCSCommandDoCommand(fullCmd, a:cmdName, a:statusText, a:options)
	else
		throw 'ARC VCSCommand plugin called on non-ARC item.'
	endif
endfunction

" Section: VCS function implementations {{{1

" Function: s:arcFunctions.Identify(buffer) {{{2
function! s:arcFunctions.Identify(buffer)
	let oldCwd = VCSCommandChangeToCurrentFileDir(resolve(bufname(a:buffer)))
	try
		call s:VCSCommandUtility.system(s:Executable() . ' info --json')
		if(v:shell_error)
			return 0
		else
			return g:VCSCOMMAND_IDENTIFY_EXACT
		endif
	finally
		call VCSCommandChdir(oldCwd)
	endtry
endfunction

" Function: s:arcFunctions.Add() {{{2
function! s:arcFunctions.Add(argList)
	return s:DoCommand(join(['add'] + a:argList, ' '), 'add', join(a:argList, ' '), {})
endfunction

" Function: s:arcFunctions.Annotate(argList) {{{2
function! s:arcFunctions.Annotate(argList)
	if len(a:argList) == 0
		if &filetype == 'arcannotate'
			" Perform annotation of the version indicated by the current line.
			let options = matchstr(getline('.'),'^\x\+')
		else
			let options = ''
		endif
	elseif len(a:argList) == 1 && a:argList[0] !~ '^-'
		let options = a:argList[0]
	else
		let options = join(a:argList, ' ')
	endif

	return s:DoCommand('blame -r' . options, 'annotate', options, {})
endfunction

" Function: s:arcFunctions.Commit(argList) {{{2
function! s:arcFunctions.Commit(argList)
	let resultBuffer = s:DoCommand('commit -F "' . a:argList[0] . '"', 'commit', '', {})
	if resultBuffer == 0
		echomsg 'No commit needed.'
	endif
endfunction

" Function: s:arcFunctions.Delete() {{{2
function! s:arcFunctions.Delete(argList)
	return s:DoCommand(join(['rm'] + a:argList, ' '), 'delete', join(a:argList, ' '), {})
endfunction

" Function: s:arcFunctions.Diff(argList) {{{2
function! s:arcFunctions.Diff(argList)
	let options = {}
	let l:argList = deepcopy(a:argList)
	if match(l:argList, "^returnAsString$") != -1
		let options.returnAsString = 1
		call filter(l:argList, 'v:val != "returnAsString"')
	endif
    let caption = join(l:argList, ' ')

	return s:DoCommand(join(['diff'] + l:argList), 'diff', caption, options)
endfunction

" Function: s:arcFunctions.GetBufferInfo() {{{2
" Provides version control details for the current file.  Current version
" number and current repository version number are required to be returned by
" the vcscommand plugin.
" Returns: List of results:  [revision, repository, branch]

function! s:arcFunctions.GetBufferInfo()
	let originalBuffer = VCSCommandGetOriginalBuffer(bufnr('%'))
	let fileName = bufname(originalBuffer)
	let statusText = s:VCSCommandUtility.system(s:Executable() . ' status -bs -- "' . fileName . '"')
	if(v:shell_error)
		return []
	endif

    let [branch, status] = matchlist(statusText, '^## ([a-zA-Z0-9_-]+\.\.\.\S+\n\s+(.))')[1:2]
    if status == '?'
        return ['Unknown']
    elseif status == 'A'
        return ['New', 'New']
    elseif status == 'I'
        return ['Ignored']
    endif

	let statusText = s:VCSCommandUtility.system(s:Executable() . ' log -n1 -- "' . fileName . '"')
	if(v:shell_error)
		return []
	endif

	let [revision, repository] = matchlist(statusText, '^commit (\S+)\n.*(?:revision: (\d+))?')[1:2]
	if revision == ''
		" Error
		return ['Unknown']
    else
		return [revision, repository, branch]
	endif
endfunction

" Function: s:arcFunctions.Info(argList) {{{2
function! s:arcFunctions.Info(argList)
	return s:DoCommand(join(['log -n1'] + a:argList, ' '), 'info', join(a:argList, ' '), {})
endfunction

" Function: s:arcFunctions.Log(argList) {{{2
function! s:arcFunctions.Log(argList)
	return s:DoCommand(join(['log', '--oneline'] + a:argList), 'log', join(a:argList, ' '), {})
endfunction

" Function: s:arcFunctions.Revert(argList) {{{2
function! s:arcFunctions.Revert(argList)
	return s:DoCommand(join(['reset', '--hard', 'HEAD']), 'revert', '', {})
endfunction

" Function: s:arcFunctions.Review(argList) {{{2
function! s:arcFunctions.Review(argList)
	if len(a:argList) == 0
		let revision = 'HEAD'
	else
		let revision = a:argList[0]
	endif

	let oldCwd = VCSCommandChangeToCurrentFileDir(resolve(bufname(VCSCommandGetOriginalBuffer('%'))))
	try
		let prefix = s:VCSCommandUtility.system(s:Executable() . ' rev-parse --show-prefix')
	finally
		call VCSCommandChdir(oldCwd)
	endtry

	let prefix = substitute(prefix, '\n$', '', '')
	let blob = '"' . revision . ':' . prefix . '/<VCSCOMMANDFILE>"'
	return s:DoCommand('show ' . blob, 'review', revision, {})
endfunction

" Function: s:arcFunctions.Status(argList) {{{2
function! s:arcFunctions.Status(argList)
	let options = ['-v']
	if len(a:argList) != 0
		let options = a:argList
	endif
	return s:DoCommand(join(['status'] + options, ' '), 'status', join(options, ' '), {})
endfunction

" Function: s:arcFunctions.Update(argList) {{{2
function! s:arcFunctions.Update(argList)
    throw 'Not applicable to arc'
endfunction

" Annotate setting {{{2

" Section: Plugin Registration {{{1
let s:VCSCommandUtility = VCSCommandRegisterModule('arc', expand('<sfile>'), s:arcFunctions, [])

let &cpo = s:save_cpo
