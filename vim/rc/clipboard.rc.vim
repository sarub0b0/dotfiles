if has('nvim')
    set clipboard&
    set clipboard+=unnamedplus
else
    set clipboard^=unnamedplus,autoselect
endif


