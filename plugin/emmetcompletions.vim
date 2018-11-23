if !exists('g:emmet_completions_py_cmd')
    if has('python3')
        let g:emmet_completions_py_cmd = "py3"
    elseif has('python')
        let g:emmet_completions_py_cmd = "py"
    else
        finish
    endif
endif

let g:emmet_completions_plugin_current_directory = resolve(expand('<sfile>:p:h').'/../emmet-autocompleter')
exec g:emmet_completions_py_cmd join([
    \ "import sys,vim",
    \ "sys.path.append(vim.eval('g:emmet_completions_plugin_current_directory'))"
\ ], "\n")
