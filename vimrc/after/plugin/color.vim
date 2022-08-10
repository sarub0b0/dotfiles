if has('termguicolors') && !exists('g:vscode')
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  let s:termcolor = 'OceanicNext'

  if has('nvim')
    augroup TransparentBG
      autocmd!
      autocmd Colorscheme * highlight Normal guibg=NONE ctermbg=NONE
      autocmd Colorscheme * highlight NonText guibg=NONE ctermbg=NONE
      autocmd Colorscheme * highlight LineNr guibg=NONE ctermbg=NONE
      autocmd Colorscheme * highlight Folded guibg=NONE ctermbg=NONE
      autocmd Colorscheme * highlight EndOfBuffer guibg=NONE ctermbg=NONE
    augroup END
  endif

  let colorschemes = getcompletion(s:termcolor, 'color')
  if index(colorschemes, s:termcolor) >= 0
    let g:oceanic_next_terminal_bold = 1
    let g:oceanic_next_terminal_italic = 1

    execute 'colorscheme ' . s:termcolor

    execute "hi VertSplit guifg=#343d46 ctermfg=237 guibg=NONE ctermbg=NONE"
  else
    colorscheme default
  endif

else
  colorscheme default
endif

