if !has('python')
	finish
endif
if !exists('g:emmet_completions_use_omnifunc')
	let g:emmet_completions_use_omnifunc=0
endif
let s:recalled = 0

python << EOF
import emmet,vim
emmet.completer.addSymbolsFromFile('html',vim.eval('g:emmet_completions_plugin_current_directory')+'/completions/html.json')
emmet.completer.addSymbolsFromFile('svg',vim.eval('g:emmet_completions_plugin_current_directory')+'/completions/svg.json')
emmet.completer.handleType('html',['html','svg'])
emmet.completer.handleType('svg',['svg'])
EOF

function! emmetcompletions#setCompleter()
    if g:emmet_completions_use_omnifunc == 1
        set omnifunc=emmetcompletions#Complete
    else
        set completefunc=emmetcompletions#Complete
    endif
endfunction

function! emmetcompletions#Complete(findstart,base)
if a:findstart
    let l:project=resolve(expand('%:p:h').'/..')
    let l:type=&ft
    let l:buffer_name=resolve(expand('%:p'))
    let l:line = line('.') - 1
    let l:column = col('.') - 1
python << EOF
import sys,vim
import emmet
result = emmet.getCompletions(line=int(vim.eval('l:line')),column=int(vim.eval('l:column')),project=vim.eval('l:project'),type=vim.eval('l:type'),name=vim.eval('l:buffer_name'),buffer=vim.current.buffer)
vim.command('let s:c_result= %s'% result)
EOF
return s:c_result['column_start']
endif

return s:c_result

endfunction
