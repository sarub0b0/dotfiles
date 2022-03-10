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
  else
    colorscheme default
  endif

else
  colorscheme default
endif

