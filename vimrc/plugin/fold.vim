scriptencoding utf-8

"----------------------------------------------------
" If foldmethod is syntax
"----------------------------------------------------
autocmd MyAutoCmd BufReadPost * if &l:foldmethod ==# 'syntax' | call s:undo_redo_foldmethod()

function! s:undo_redo_foldmethod()
  nmap <silent> u :setlocal foldmethod=manual<CR>
        \:normal! u<CR>
        \:setlocal foldmethod=syntax<CR>

  nmap <silent> <C-r> :setlocal foldmethod=manual<CR>
        \:redo<CR>
        \:setlocal foldmethod=syntax<CR>
endfunction


