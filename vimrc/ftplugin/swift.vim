scriptencoding utf-8

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

nnoremap <Space>f :%!swift-format --mode format<CR>

