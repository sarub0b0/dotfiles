scriptencoding utf-8

if exists('b:did_ftplugin_after')
  finish
endif
let b:did_ftplugin_after = 1

nnoremap <Space>f :%!swift-format --mode format<CR>

