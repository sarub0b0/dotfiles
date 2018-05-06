scriptencoding utf-8

autocmd MyAutoCmd BufRead,BufNewFile Guardfile set filetype=ruby
autocmd MyAutoCmd FileType ruby call s:ruby_tab_config()
" autocmd MyAutoCmd FileType c,cpp,h,java call s:clang_format_config() | call s:ale_option()
autocmd MyAutoCmd FileType c,cpp,h,java call s:clang_option() | call s:ale_option()
autocmd MyAutoCmd FileType nerdtree set nolist
" autocmd MyAutoCmd FileType cs call s:csharp_setting()
autocmd MyAutoCmd BufRead,BufNewFile *.jade set filetype=pug
autocmd MyAutoCmd BufRead,BufNewFile *.fish set filetype=fish
autocmd MyAutoCmd FileType toml,vim,zsh,bash,help call s:fold_method_indent()

function! s:default_config()
    set tabstop=4 softtabstop=4 shiftwidth=4
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
    setlocal omnifunc=PmniSharp#Complete
    autocmd MyAutoCmd BufWritePost *.cs call OmniSharp#AddToProject()
    set foldmethod=syntax
endfunction

function! s:clang_option()
    set foldmethod=syntax
endfunction

" clang format config {{{
" function! s:clang_format_config()
"     set foldmethod=syntax
"     if executable('clang-format')

"         autocmd MyAutoCmd FileType c,cpp ClangFormatAutoEnable

"         nnoremap <buffer> ff :ClangFormat<CR>

"         let g:clang_format#code_style = 'google'

"         let g:clang_format#style_options = {
"                     \ 'AlignConsecutiveAssignments': 'true',
"                     \ 'AlignTrailingComments': 'true',
"                     \ 'DerivePointerAlignment': 'false',
"                     \ 'PointerAlignment': 'Right',
"                     \ 'IndentCaseLabels': 'true',
"                     \ 'KeepEmptyLinesAtTheStartOfBlocks': 'true',
"                     \ 'SpacesBeforeTrailingComments': 1,
"                     \ 'AlwaysBreakAfterDefinitionReturnType': 'false',
"                     \ 'AllowShortFunctionsOnASingleLine': 'None',
"                     \ 'AllowShortBlocksOnASingleLine': 'false',
"                     \ 'SortIncludes': 'false',
"                     \ 'BinPackArguments': 'false',
"                     \ 'BinPackParameters': 'false',
"                     \ 'SpaceAfterCStyleCast': 'true',
"                     \ 'ColumnLimit': 78,
"                     \ }
"     endif
" endfunction
" }}}

function! s:ruby_tab_config()
    setl tabstop=2
    setl softtabstop=2
    setl shiftwidth=2
endfunction

function! s:ale_option()
    let l:include_dir = expand($ALE_C_INCLUDE_PATH)
    let l:lib_dir = expand($ALE_C_LIB_PATH)
    if l:include_dir ==? ''
        let l:include_dir = '-I../include'
        let l:lib_dir = '-I../lib'
        let g:ale_cpp_clang_options = '-std=c++14 -Wall -Wno-unused-variable -Wno-unused-private-field ' . l:include_dir . l:lib_dir
        let g:ale_cpp_gcc_options = '-std=c++14 -Wall -Wno-unused-variable -Wno-unused-private-field ' . l:include_dir . l:lib_dir
        let g:ale_c_clang_options = '-std=c11 -Wall ' . l:include_dir . l:lib_dir
        let g:ale_c_gcc_options = '-std=c11 -Wall ' . l:include_dir . l:lib_dir
    endif

    let g:ale_cpp_clang_options = '-std=c++14 -Wall -Wno-unused-variable -Wno-unused-private-field -I' . l:include_dir . ' -L' . l:lib_dir
    let g:ale_cpp_gcc_options = '-std=c++14 -Wall -Wno-unused-variable -Wno-unused-private-field -I' . l:include_dir . ' -L' . l:lib_dir
    let g:ale_c_clang_options = '-std=c11 -Wall -I' . l:include_dir . ' -L' . l:lib_dir
    let g:ale_c_gcc_options = '-Wall -I' . l:include_dir . ' -L' . l:lib_dir

endfunction

function! s:delete_space_au()
endfunction

function! s:markdown_opt()
    autocmd MyAutoCmd FileType markdown,text set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
    " autocmd FileType markdown,text set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:% | call s:delete_space_au()
endfunction

function! s:fold_method_indent()
    autocmd MyAutoCmd BufRead,BufNewFile * setl foldmethod=indent
endfunction

