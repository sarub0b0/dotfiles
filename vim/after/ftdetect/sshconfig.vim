if exists('g:did_load_filetype_sshconfig')
  finish
endif
let g:did_load_filetype_sshconfig = 1

augroup MyFileTypes
  autocmd! BufNewFile,BufRead */.ssh/conf.d/* set filetype=sshconfig
augroup END
