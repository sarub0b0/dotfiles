if has('nvim')
    let g:clipboard = {'copy': {'+': 'pbcopy', '*': 'pbcopy'}, 'paste': {'+': 'pbpaste', '*': 'pbpaste'}, 'name': 'pbcopy', 'cache_enabled': 0}
    set clipboard&
    set clipboard+=unnamedplus
else
    set clipboard^=unnamedplus,autoselect
endif

" set clipboard=exclude:.*
