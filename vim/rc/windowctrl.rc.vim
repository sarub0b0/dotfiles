
augroup QuickFixWindowDown
    autocmd!
    autocmd FileType qf wincmd J
augroup END

augroup HelpWindowRight
    autocmd!
    autocmd BufRead,BufEnter */doc/* if &buftype == 'help' | wincmd L | setl number | setl winfixwidth | vertical resize 90 | endif
augroup END

augroup ManWindowRight
    autocmd!
    let g:ft_man_open_mode = 'vert'
    let g:ft_man_folding_enable = 1
    autocmd FileType man wincmd L | setl number | setl winfixwidth | vertical resize 90
augroup END

" command! -nargs=0 Terminal vertical botright new | terminal
