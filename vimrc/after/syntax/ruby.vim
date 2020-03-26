scriptencoding utf-8

if exists('b:did_syntax_after')
  finish
endif
let b:did_syntax_after = 1

autocmd MyAutoCmd FileType ruby call s:ruby_file_comment()

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

