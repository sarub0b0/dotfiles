scriptencoding utf-8
autocmd MyAutoCmd FileType text,tex,rb,c,cpp,python call s:plain_text()

function! s:plain_text() abort
    syntax match txtChapter /^[0-9] .*$\|^[0-9]\. .*$\|^[0-9]\(\.[0-9]\)\+ .*$\|.*TODO.*\|^[0-9]章$\|^[0-9].[0-9]節$\|.*\*\*\*.*/
    highlight default Text cterm=bold,underline gui=bold,underline ctermfg=221 guifg=#fac863
    highlight link txtChapter Text
    let b:current_syntax = 'text'
endfunction

