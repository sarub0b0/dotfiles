if has('termguicolors')
    set termguicolors

    let s:termcolor = 'OceanicNext'

    if has('nvim')
        augroup TransparentBG
            autocmd!
            autocmd Colorscheme * highlight Normal guibg=none
            autocmd Colorscheme * highlight NonText guibg=none
            autocmd Colorscheme * highlight LineNr guibg=none
            autocmd Colorscheme * highlight Folded guibg=none
            autocmd Colorscheme * highlight EndOfBuffer guibg=none
        augroup END
    endif

    let colorschemes = getcompletion('', 'color')
    for scheme in colorschemes
        if scheme ==# s:termcolor
            execute 'colorscheme ' . s:termcolor
            break
        else
            colorscheme default
        endif
    endfor

else
    colorscheme default
endif

