scriptencoding utf-8

let g:tex_flavor='latex'

autocmd MyAutoCmd BufRead,BufNewFile Guardfile set filetype=ruby
autocmd MyAutoCmd FileType ruby call s:two_indent_config()
" autocmd MyAutoCmd FileType c,cpp,h,java call s:clang_format_config() | call s:ale_option()
" autocmd MyAutoCmd FileType c,cpp,h,java call s:clang_option()
autocmd MyAutoCmd FileType nerdtree set nolist
autocmd MyAutoCmd FileType cs call s:csharp_setting()
autocmd MyAutoCmd BufRead,BufNewFile *.jade set filetype=pug
autocmd MyAutoCmd BufRead,BufNewFile *.fish set filetype=fish
autocmd MyAutoCmd FileType tex,plaintex call s:tex_foldmethod()
autocmd MyAutoCmd FileType python call s:python_setting()
autocmd MyAutoCmd FileType markdown call s:markdown_opt()
autocmd MyAutoCmd FileType sh call s:set_indent_format()
autocmd MyAutoCmd FileType yaml call s:yaml_setting()
autocmd MyAutoCmd FileType html,md,javascript,typescript,css,json call s:two_indent_config()

autocmd MyAutoCmd BufWinEnter,WinEnter term://* startinsert
autocmd MyAutoCmd BufLeave term://* stopinsert

function! s:yaml_setting()
    setl tabstop=2
    setl softtabstop=2
    setl shiftwidth=2
endfunction

function! s:markdown_setting()
endfunction

function! s:python_setting()
    command! -nargs=0 Yapf :%!yapf
endfunction

function! s:default_config()
    set tabstop=4 softtabstop=4 shiftwidth=4
endfunction

function! s:set_indent_format()
    command! -nargs=0 IndentFormat call s:indent_format()
    nnoremap <silent> <Space>f :IndentFormat<CR>
endfunction

function! s:indent_format()
    let l:view = winsaveview()
    normal! gg=G
    silent call winrestview(l:view)
endfunction

function! s:csharp_setting()
    :ALEDisable
    nnoremap <silent> <buffer> ma :OmniSharpAddToProject<CR>
    nnoremap <silent> <buffer> mb :OmniSharpBuild<CR>
    nnoremap <silent> <buffer> mc :OmniSharpFindSyntaxErrors<CR>
    nnoremap <silent> <buffer> mf :OmniSharpCodeFormat<CR>
    nnoremap <silent> <buffer> mj :OmniSharpGotoDefinition<CR>
    nnoremap <silent> <buffer> <C-w>mj <C-w>s:OmniSharpGotoDefinition<CR>
    nnoremap <silent> <buffer> mi :OmniSharpFindImplementations<CR>
    nnoremap <silent> <buffer> mr :OmniSharpRename<CR>
    nnoremap <silent> <buffer> mt :OmniSharpTypeLookup<CR>
    nnoremap <silent> <buffer> mu :OmniSharpFindUsages<CR>
    nnoremap <silent> <buffer> mx :OmniSharpGetCodeActions<CR>
    setlocal omnifunc=OmniSharp#Complete
    autocmd MyAutoCmd BufWritePost *.cs call OmniSharp#AddToProject()
    set foldmethod=syntax
endfunction

function! s:clang_option()
    " set foldmethod=syntax
    set foldmethod=manual
    let g:c_syntax_for_h = 1
endfunction

function! s:two_indent_config()
    setl tabstop=2
    setl softtabstop=2
    setl shiftwidth=2
endfunction

" function! s:ale_option()
"     let l:include_dir = expand($ALE_C_INCLUDE_PATH)
"     let l:lib_dir = expand($ALE_C_LIB_PATH)
"     if l:include_dir ==? ''
"         let l:include_dir = '-I../include'
"         let l:lib_dir = '-I../lib'
"     endif

"     let g:ale_cpp_clang_options = '-std=c++14 -Wall -Wno-unused-variable -Wno-unused-private-field -I' . l:include_dir . ' -L' . l:lib_dir
"     let g:ale_cpp_gcc_options = '-std=c++14 -Wall -Wno-unused-variable -Wno-unused-private-field -I' . l:include_dir . ' -L' . l:lib_dir
"     let g:ale_c_clang_options = '-std=c11 -Wall -I' . l:include_dir . ' -L' . l:lib_dir
"     let g:ale_c_gcc_options = '-Wall -I' . l:include_dir . ' -L' . l:lib_dir

" endfunction

function! s:delete_space_au()
endfunction
function! Markdown_fold(lnum)
    let l:line = getline(a:lnum)
    if l:line =~# '<style>'
        return 1
    endif
    if l:line =~# '</style>'
        return '<1'
    endif
    return '='
endfunction
function! s:markdown_opt()
    autocmd MyAutoCmd FileType markdown,text set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
    autocmd! DeleteLineEndSpaceCmd
    " autocmd FileType markdown,text set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:% | call s:delete_space_au()
    setl foldmethod=expr
    setl foldexpr=Markdown_fold(v:lnum)
endfunction

function! s:tex_foldmethod()
    nnoremap <silent><buffer><Space>z setl foldmethod=expr
endfunction

