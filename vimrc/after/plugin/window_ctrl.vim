
" =======================================================
" QuickFixとファイラー
" =======================================================

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


" =======================================================
" coc explorer
" =======================================================

" ファイル指定なしで起動した場合にエクスプローラーを起動

if get(g:, 'coc_enabled', 0)
  autocmd MyAutoCmd VimEnter * call s:open_coc_explorer()

  function! s:buffer_list() abort
    return filter(range(1, bufnr('$')), 'buflisted(v:val)')
  endfunction

  function! s:buffer_len() abort
    return len(s:buffer_list())
  endfunction

  function! s:open_coc_explorer() abort
    if s:buffer_len() > 1
      return
    endif
    if bufname() !=# ''
      return
    endif

    :CocCommand explorer
  endfunction
endif
