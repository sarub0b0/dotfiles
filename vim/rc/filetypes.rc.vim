scriptencoding utf-8

let g:tex_flavor='latex'

autocmd MyAutoCmd BufRead,BufNewFile Guardfile set filetype=ruby
autocmd MyAutoCmd FileType ruby call s:two_indent_config()
autocmd MyAutoCmd FileType nerdtree set nolist
autocmd MyAutoCmd BufRead,BufNewFile *.jade set filetype=pug
autocmd MyAutoCmd BufRead,BufNewFile *.fish set filetype=fish
autocmd MyAutoCmd FileType tex,plaintex call s:tex_foldmethod()
autocmd MyAutoCmd FileType markdown call s:markdown_opt()
autocmd MyAutoCmd FileType html,md,javascript,typescript,css,json,yaml,vim call s:two_indent_config()

function! s:default_config()
  set tabstop=4 softtabstop=4 shiftwidth=4
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
