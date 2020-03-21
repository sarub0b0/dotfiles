scriptencoding utf-8
autocmd MyAutoCmd FileType text,tex,ruby,c,cpp,python call s:plain_text()
autocmd MyAutoCmd FileType ruby call s:ruby_file_comment()

autocmd MyAutoCmd Syntax * call s:error_syntax()
autocmd MyAutoCmd Syntax * call s:warning_syntax()


function! s:error_syntax()
  highlight link qfError ErrorMsg
  highlight link QuickFixLine CursorLine
endfunction

function! s:warning_syntax()
  " highlight link ALEWarningLine Comment
  " highlight link ALEWarning Comment
endfunction


function! s:plain_text() abort
  syntax match txtChapter /^[0-9] .*$\|^[0-9]\. .*$\|^[0-9]\(\.[0-9]\)\+ .*$\|.*TODO.*\|^[0-9]章$\|^[0-9].[0-9]節$\|.*\*\*\*.*/
  highlight default Text cterm=bold,underline gui=bold,underline ctermfg=221 guifg=#fac863
  highlight link txtChapter Text

  " syntax match txtTest /.*TEST.*/
  " highlight default testText ctermfg=15 ctermbg=68 guifg=#ffffff guibg=#6699cc
  " highlight link txtTest testText

  syntax match txtBold /\*\*.*\*\*/
  highlight default textBold cterm=bold gui=bold ctermfg=114
  highlight link txtBold textBold

  let b:current_syntax = 'text'
endfunction

function! s:ruby_file_comment() abort
  syntax match txtChapter /.*TODO.*\|.*\*\*\*.*/
  highlight default Text cterm=bold,underline gui=bold,underline ctermfg=221 guifg=#fac863
  highlight link txtChapter Text

  syntax match txtTest /.*TEST.*/
  highlight default testText ctermfg=15 ctermbg=68 guifg=#ffffff guibg=#6699cc
  highlight link txtTest testText

  syntax match txtBold /.*\*\*.*\*\*/
  highlight default textBold cterm=bold gui=bold ctermfg=114
  highlight link txtBold ModeMsg

  let b:current_syntax = 'ruby'
endfunction

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
