scriptencoding utf-8

autocmd MyAutoCmd BufNewFile,BufReadPre Dockerfile* setl ft=dockerfile
autocmd MyAutoCmd BufNewFile,BufReadPre *markdownlintrc setl ft=json
