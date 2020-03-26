scriptencoding utf-8

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
" ================================================
" プロジェクト固有の設定をロードする
" ================================================
autocmd MyAutoCmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))

function! s:vimrc_local(loc)
  let l:files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for l:i in reverse(filter(l:files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" ================================================
" カーソル位置のハイライト情報を表示するコマンド
" ================================================
function! s:get_syn_id(transparent)
  let synid = synID(line('.'), col('.'), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, 'name')
  let ctermfg = synIDattr(a:synid, 'fg', 'cterm')
  let ctermbg = synIDattr(a:synid, 'bg', 'cterm')
  let guifg = synIDattr(a:synid, 'fg', 'gui')
  let guibg = synIDattr(a:synid, 'bg', 'gui')
  return {
        \ 'name': name,
        \ 'ctermfg': ctermfg,
        \ 'ctermbg': ctermbg,
        \ 'guifg': guifg,
        \ 'guibg': guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo 'name: ' . baseSyn.name .
        \ ' ctermfg=' . baseSyn.ctermfg .
        \ ' ctermbg=' . baseSyn.ctermbg .
        \ ' guifg=' . baseSyn.guifg .
        \ ' guibg=' . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo 'link to'
  echo 'name: ' . linkedSyn.name .
        \ ' ctermfg=' . linkedSyn.ctermfg .
        \ ' ctermbg=' . linkedSyn.ctermbg .
        \ ' guifg=' . linkedSyn.guifg .
        \ ' guibg=' . linkedSyn.guibg

endfunction

function! s:get_highlight()
  let l:baseSyn = s:get_syn_attr(s:get_syn_id(0))
  let l:linkedSyn = s:get_syn_attr(s:get_syn_id(1))

  execute "hi " . l:baseSyn.name
  execute "hi " . l:linkedSyn.name
endfunction

command! SyntaxInfo call s:get_syn_info()
command! VimShowHlItem call s:get_highlight()



" ================================================
" 何に使っていたかもうわからない
" ================================================
command! -nargs=0 DispQfType    call <SID>DispQfType()

function! s:DispQfType()
  let l:type = s:GetQfType()
  redraw
  if l:type ==# 'L'
    echo 'This window is Location List.'
    return 0
  elseif l:type ==# 'Q'
    echo 'This window is Quickfix List.'
    return 1
  else
    echo 'This window is not Location List or Quickfix List.'
    return 2
  endif
endfunction

function! s:GetQfType()
  if getwinvar(0, '&buftype') ==# 'quickfix'
    try
      let l:ret = 'L'
      let l:save_winnr = winnr()
      let l:wrcmd = winrestcmd()
      let l:wsv = winsaveview()
      lopen
      if winnr() != l:save_winnr
        lclose
        exe l:save_winnr . 'wincmd w'
        exe l:wrcmd
        let l:ret = 'Q'
      endif
      call winrestview(l:wsv)
      return l:ret
    catch /E776/
      return 'Q'
    endtry
  else
    return ''
  endif
endfunction


" ================================================
" rsync
" ================================================
function! s:rsync_function(...)
  if a:0 == 2
    let l:list = a:000
    let l:pwd = getcwd()
    let l:pwd = "."
    let l:cmd = ":!rsync -avc " . l:pwd . " " . l:list[0] . ":" . l:list[1]
    execute l:cmd
  else
    echo "args: dst-host dst-dir"
  endif
endfunction

command! -nargs=+ Rsync call s:rsync_function(<f-args>)


