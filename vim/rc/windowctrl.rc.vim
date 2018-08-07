"
" quickfix
"
autocmd MyAutoCmd FileType qf wincmd J

"
" help
"
autocmd MyAutoCmd BufRead,BufEnter */doc/* if &buftype ==# 'help' | wincmd L | setl nonumber | setl winfixwidth | vertical resize 80 | endif

"
" terminal
"
if has('nvim')
    autocmd MyAutoCmd TermOpen * if &buftype == 'terminal' | setl nonumber | endif
    command! -nargs=0 Terminal vertical botright new | terminal
endif
"
" man
"
let g:ft_man_open_mode = 'vert'
let g:ft_man_folding_enable = 1
autocmd MyAutoCmd FileType man wincmd L | setl nonumber | setl winfixwidth | vertical resize 80

