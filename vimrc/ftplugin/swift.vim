scriptencoding utf-8

if exists('b:my_did_ftplugin')
  finish
endif
let b:my_did_ftplugin = 1

nnoremap <Space>f :%!swift-format --mode format<CR>

