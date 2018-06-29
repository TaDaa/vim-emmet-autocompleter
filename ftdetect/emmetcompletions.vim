augroup vim-emmet-autocompleter
    autocmd!
    au! FileType,Syntax * call emmetcompletions#setCompleter()
    au! FileType,Syntax * call emmetcompletions#setCompleter()
augroup END

