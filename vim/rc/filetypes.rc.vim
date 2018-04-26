scriptencoding utf-8

autocmd MyAutoCmd BufRead,BufNewFile Guardfile setfiletype ruby
autocmd MyAutoCmd FileType ruby call s:ruby_tab_config()
autocmd MyAutoCmd FileType c,cpp,h,java call s:clang_format_config() | call s:ale_option()
autocmd MyAutoCmd FileType nerdtree set nolist
autocmd MyAutoCmd FileType cs call s:csharp_setting()
autocmd MyAutoCmd BufRead,BufNewFile *.jade setfiletype pug
autocmd MyAutoCmd BufRead,BufNewFile *.fish setfiletype fish
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
    augroup CSharpSetting
        autocmd!
        autocmd BufWritePost *.cs call OmniSharp#AddToProject()
    augroup END
    set foldmethod=syntax
endfunction

" clang format config {{{
function! s:clang_format_config()
    set foldmethod=syntax
    if executable('clang-format')

        augroup ClangFormatConfig
            autocmd!
            autocmd FileType c,cpp ClangFormatAutoEnable
        augroup END

        nnoremap <buffer> ff :ClangFormat<CR>

        let g:clang_fotmat#code_style = 'google'

        let g:clang_format#style_options = {
                    \ 'AlignConsecutiveAssignments': 'true',
                    \ 'AlignTrailingComments': 'true',
                    \ 'DerivePointerAlignment': 'false',
                    \ 'PointerAlignment': 'Right',
                    \ 'IndentCaseLabels': 'true',
                    \ 'KeepEmptyLinesAtTheStartOfBlocks': 'true',
                    \ 'SpacesBeforeTrailingComments': 1,
                    \ 'AlwaysBreakAfterDefinitionReturnType': 'false',
                    \ 'AllowShortFunctionsOnASingleLine': 'None',
                    \ 'AllowShortBlocksOnASingleLine': 'false',
                    \ 'SortIncludes': 'false',
                    \ 'BinPackArguments': 'false',
                    \ 'BinPackParameters': 'false',
                    \ 'SpaceAfterCStyleCast': 'true',
                    \ 'ColumnLimit': 78,
                    \ }
    endif
endfunction
" }}}

function! s:ruby_tab_config()
    setl tabstop=2
    setl softtabstop=2
    setl shiftwidth=2
endfunction

function! s:ale_option()
    let l:include_dir = expand($ALE_C_INCLUDE_PATH)
    let g:ale_cpp_clang_options = '-std=c++14 -Wall -Wno-unused-variable -Wno-unused-private-field -I' . l:include_dir
    let g:ale_cpp_gcc_options = '-std=c++14 -Wall -Wno-unused-variable -Wno-unused-private-field -I' . l:include_dir
    let g:ale_c_clang_options = '-Wall -I' . l:include_dir
    let g:ale_c_gcc_options = '-Wall -I' . l:include_dir

endfunction

function! s:delete_space_au()
    augroup DeleteSpace
        autocmd!
    augroup END
endfunction

function! s:markdown_opt()
    augroup MarkdownOption
        autocmd!
        autocmd FileType markdown,text set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:% | call s:delete_space_au()
    augroup END
endfunction

function! s:fold_method_indent()
    augroup FoldMethod
        autocmd!
        autocmd BufRead,BufNewFile * setl foldmethod=indent
    augroup END
endfunction
" augroup autoformat_settings
"   autocmd FileType bzl AutoFormatBuffer buildifier
"   autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
"   autocmd FileType dart AutoFormatBuffer dartfmt
"   autocmd FileType go AutoFormatBuffer gofmt
"   autocmd FileType gn AutoFormatBuffer gn
"   autocmd FileType html,css,json AutoFormatBuffer js-beautify
"   autocmd FileType java AutoFormatBuffer google-java-format
"   autocmd FileType python AutoFormatBuffer yapf
"    Alternative: autocmd FileType python AutoFormatBuffer autopep8
" augroup END
