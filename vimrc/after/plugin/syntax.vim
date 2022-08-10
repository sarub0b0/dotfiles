if has('nvim') && !exists("g:vscode")
  exe 'hi Floaterm guibg=' . g:terminal_color_background
endif
