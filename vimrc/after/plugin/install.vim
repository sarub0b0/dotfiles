
" =======================================================
" よく使うcoc extensionをインストールする
" =======================================================

let g:coc_global_extensions = [
    \ 'coc-actions',
    \ 'coc-clangd',
    \ 'coc-cmake',
    \ 'coc-css',
    \ 'coc-docker',
    \ 'coc-emoji',
    \ 'coc-eslint',
    \ 'coc-explorer',
    \ 'coc-floaterm',
    \ 'coc-git',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-markdownlint',
    \ 'coc-pairs',
    \ 'coc-prettier',
    \ 'coc-python',
    \ 'coc-sh',
    \ 'coc-snippets',
    \ 'coc-solargraph',
    \ 'coc-translator',
    \ 'coc-tsserver',
    \ 'coc-vetur',
    \ 'coc-vimlsp',
    \ 'coc-yaml',
    \ ]

" function! s:coc_all_install() abort
"   for l:ext in s:extensions
"     execute ':CocInstall ' . l:ext
"   endfor
" endfunction

" command! -nargs=0 CocALLInstall call s:coc_all_install()


" function! ExtensionsList(timer) abort
"   let l:stats = CocAction('extensionStats')

"   if type(l:stats) != v:t_list
"     return
"   endif

"   call timer_stop(a:timer)

"   call filter(l:stats, 'v:val["isLocal"] == v:false')
"   let g:coc_extensions_list = map(l:stats, 'v:val["id"]')
" endfunction
" let s:timer_start = timer_start(500, 'ExtensionsList', {'repeat': 3})
