autocmd MyAutoCmd FileType qf wincmd J

autocmd MyAutoCmd BufRead,BufEnter */doc/* if &buftype == 'help' | wincmd L | setl number | setl winfixwidth | vertical resize 90 | endif

let g:ft_man_open_mode = 'vert'
let g:ft_man_folding_enable = 1
autocmd MyAutoCmd FileType man wincmd L | setl number | setl winfixwidth | vertical resize 90

" command! -nargs=0 Terminal vertical botright new | terminal
