scriptencoding utf-8
autocmd MyAutoCmd FileType text,tex,ruby,c,cpp,python call s:plain_text()
autocmd MyAutoCmd FileType ruby call s:ruby_file_comment()

autocmd MyAutoCmd Syntax * call s:error_syntax()
function! s:error_syntax()
    highlight link qfError ErrorMsg
    highlight link QuickFixLine CursorLine
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
