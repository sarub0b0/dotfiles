scriptencoding utf-8

" =======================================================
" quickfix
" =======================================================
autocmd MyAutoCmd FileType qf wincmd J

" =======================================================
" help
" =======================================================

autocmd MyAutoCmd BufRead,BufEnter */doc/* if &buftype ==# 'help' | wincmd L | setl nonumber | setl winfixwidth | vertical resize 80 | endif


" =======================================================
" terminal
" =======================================================

if has('nvim')
  autocmd MyAutoCmd BufWinEnter,WinEnter term://* startinsert
  autocmd MyAutoCmd BufLeave term://* stopinsert

  autocmd MyAutoCmd TermOpen * if &buftype == 'terminal' | setl nonumber | startinsert| endif
  command! -nargs=0 Terminal vertical botright new | startinsert | terminal
else
  " command! Terminal call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: &columns/2, minheight: &lines/2, line: 1, col: &columns/2, pos: 'topleft', resize: 'true' })
endif


" =======================================================
" man
" =======================================================

let g:ft_man_open_mode = 'vert'
let g:ft_man_folding_enable = 1
autocmd MyAutoCmd FileType man wincmd L | setl nonumber | setl winfixwidth | vertical resize 80


