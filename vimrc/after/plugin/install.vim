
" =======================================================
" ファイルに書かれているcoc extensionをインストールする
" =======================================================
function! s:coc_install(filename)
  echomsg "Start install " . a:filename
  let l:install_list = []
  let l:idx = 1
  for l:ext in readfile(a:filename)
    echomsg "(" . l:idx . ") " . l:ext
    let l:idx = l:idx + 1
    call coc#util#install_extension([l:ext])
  endfor
endfunction

command! -nargs=1 -complete=file CocBeginInstall call s:coc_install("<args>")
