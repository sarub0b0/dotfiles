if has('termguicolors')
    set termguicolors
    let colorschemes = getcompletion('', 'color')
    for scheme in colorschemes
        if scheme == 'OceanicNext'
            colorscheme OceanicNext
            break
        else
            colorscheme elflord
        endif
    endfor

else
    colorscheme elflord
endif

