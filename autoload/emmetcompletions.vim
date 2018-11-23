if !exists('g:emmet_completions_py_cmd')
    if has('python3')
        let g:emmet_completions_py_cmd = "py3"
    elseif has('python')
        let g:emmet_completions_py_cmd = "py"
    else
        finish
    endif
endif
if !exists('g:emmet_completions_use_omnifunc')
	let g:emmet_completions_use_omnifunc=0
endif
let s:recalled = 0

exec g:emmet_completions_py_cmd join([
    \ "import emmet,vim",
    \ "emmet.completer.addSymbolsFromFile('html',vim.eval('g:emmet_completions_plugin_current_directory')+'/completions/html.json')",
    \ "emmet.completer.addSymbolsFromFile('svg',vim.eval('g:emmet_completions_plugin_current_directory')+'/completions/svg.json')",
    \ "emmet.completer.handleType('html',['html','svg'])",
    \ "emmet.completer.handleType('svg',['svg'])"
\ ], "\n")

function! emmetcompletions#setCompleter()
    exec g:emmet_completions_py_cmd join([
        \ "import emmet, vim",
        \ "vim.vars['emmet_completions_types'] = emmet.completer.types"
    \ ], "\n")
    if has_key(g:emmet_completions_types, &ft)
        if g:emmet_completions_use_omnifunc == 1
            setlocal omnifunc=emmetcompletions#Complete
        else
            set completefunc=emmetcompletions#Complete
        endif
    endif
endfunction

function! emmetcompletions#Complete(findstart,base)
if a:findstart
    let l:project=resolve(expand('%:p:h').'/..')
    let l:type=&ft
    let l:buffer_name=resolve(expand('%:p'))
    let l:line = line('.') - 1
    let l:column = col('.') - 1
    exec g:emmet_completions_py_cmd join([
        \ "import sys,vim",
        \ "import emmet",
        \ "result = emmet.getCompletions(line=int(vim.eval('l:line')),column=int(vim.eval('l:column')),project=vim.eval('l:project'),type=vim.eval('l:type'),name=vim.eval('l:buffer_name'),buffer=vim.current.buffer)",
        \ "vim.command('let s:c_result= %s'% result)"
    \], "\n")
    return s:c_result['column_start']
endif
return s:c_result
endfunction
