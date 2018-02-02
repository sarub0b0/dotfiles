scriptencoding utf-8

augroup FileTypeDetect
    autocmd!
    autocmd BufRead,BufNewFile Guardfile setfiletype ruby
    autocmd FileType ruby call s:ruby_tab_config()
    autocmd FileType c,cpp,h,java call s:clang_format_config() | call s:ale_option()
augroup END

function! s:default_config()
    " タブ設定
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
endfunction

" clang format config {{{
function! s:clang_format_config()
    if executable('clang-format')
        source ~/dotfiles/vim/rc/plugins/gtags.vim

        augroup ClangFormatConfig
            autocmd!
            autocmd FileType c,cpp ClangFormatAutoEnable
        augroup END

        nnoremap <buffer> f :ClangFormat<CR>

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
    let g:ale_cpp_clang_options = '-std=c++14 -Wall -I' . l:include_dir
    let g:ale_cpp_gcc_options = '-std=c++14 -Wall -I' . l:include_dir
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
