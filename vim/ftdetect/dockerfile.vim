if exists('g:did_load_filetype_dockerfile')
  finish
endif
let g:did_load_filetype_dockerfile = 1


augroup MyFileTypes
  autocmd! BufNewFile,BufRead Dockerfile.* set filetype=dockerfile
augroup END
