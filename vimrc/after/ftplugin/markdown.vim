scriptencoding utf-8

if exists('b:did_ftplugin_after')
  finish
endif
let b:did_ftplugin_after = 1

setl tabstop=4
setl softtabstop=4
setl shiftwidth=4

nnoremap <silent> <leader>f :<C-u>TableFormat<CR>
