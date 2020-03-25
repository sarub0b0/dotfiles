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
  autocmd MyAutoCmd BufWinEnter,WinEnter term://* startinsert
  autocmd MyAutoCmd BufLeave term://* stopinsert

  autocmd MyAutoCmd TermOpen * if &buftype == 'terminal' | setl nonumber | startinsert| endif
  command! -nargs=0 Terminal vertical botright new | startinsert | terminal
endif
"
" man
"
let g:ft_man_open_mode = 'vert'
let g:ft_man_folding_enable = 1
autocmd MyAutoCmd FileType man wincmd L | setl nonumber | setl winfixwidth | vertical resize 80

" vim終了時のquickfixとfilerの管理
" quickfixかfiler以外のウィンドウが全て閉じられたら、quickfixを閉じる
autocmd MyAutoCmd WinEnter * call s:auto_close_quickfix_or_filer()

function! s:auto_close_quickfix_or_filer() abort
  if winnr('$') > 1
    return
  endif
  if getwinvar(1, '&filetype') =~# '\v(qf|coc-explorer)'
    quit
  endif
endfunction


" filerとquickfixが開いていた場合に自動的に全て閉じる
autocmd MyAutoCmd WinEnter * call s:auto_close_quickfix_and_filer()

function! s:auto_close_quickfix_and_filer() abort
  if winnr('$') > 2
    return
  endif
  if getwinvar(2, '&filetype') ==# 'qf' && getwinvar(1, '&filetype') ==# 'coc-explorer'
    quit
    quit
  endif
endfunction


" coc explorer
" ファイル指定なしで起動した場合にエクスプローラーを起動
autocmd MyAutoCmd BufNewRead * call s:open_coc_explorer()

function! s:buffer_list() abort
  return filter(range(1, bufnr('$')), 'buflisted(v:val)')
endfunction

function! s:buffer_len() abort
  return len(s:buffer_list())
endfunction

function! s:open_coc_explorer() abort
  if s:buffer_len() > 1 && bufname() !=# ''
    return
  endif

  :CocCommand explorer
endfunction
