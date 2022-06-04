if has('termguicolors') && !exists('g:vscode')
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

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

  let colorschemes = getcompletion(s:termcolor, 'color')
  if index(colorschemes, s:termcolor) >= 0
    execute 'colorscheme ' . s:termcolor

    let g:oceanic_next_terminal_italic = 1
    let g:oceanic_next_terminal_bold = 1

    " 31: let s:base02 = ['#4f5b66', '240']
    hi VertSplit ctermfg=240 guifg=#4f5b66 ctermbg=NONE guibg=NONE
  else
    colorscheme default
  endif

else
  colorscheme default
endif

