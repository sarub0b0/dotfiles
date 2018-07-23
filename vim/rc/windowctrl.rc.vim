"
" quickfix
"
autocmd MyAutoCmd FileType qf wincmd J

"
" help
"
autocmd MyAutoCmd BufRead,BufEnter */doc/* if &buftype ==# 'help' | wincmd L | setl nonumber | setl winfixwidth | vertical resize 90 | endif

"
" terminal
"
autocmd MyAutoCmd TermOpen * if &buftype == 'terminal' | setl nonumber | endif
command! -nargs=0 Terminal vertical botright new | terminal

"
" man
"
let g:ft_man_open_mode = 'vert'
let g:ft_man_folding_enable = 1
autocmd MyAutoCmd FileType man wincmd L | setl nonumber | setl winfixwidth | vertical resize 90

