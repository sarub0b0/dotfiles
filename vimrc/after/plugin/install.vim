
" =======================================================
" よく使うcoc extensionをインストールする
" =======================================================

let s:extensions = [
    \ 'coc-actions',
    \ 'coc-clangd',
    \ 'coc-cmake',
    \ 'coc-css',
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
    \ 'coc-snippets',
    \ 'coc-solargraph',
    \ 'coc-tabnine',
    \ 'coc-translator',
    \ 'coc-vimlsp',
    \ 'coc-yaml',
    \ ]

function! s:coc_all_install() abort
  for l:ext in s:extensions
    execute ':CocInstall ' . l:ext
  endfor
endfunction

command! -nargs=0 CocALLInstall call s:coc_all_install()
