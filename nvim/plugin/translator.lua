local ok, _ = pcall(require, 'translate')
if not ok then
  print 'translate is not installed.'
  return
end

require("translate").setup({})

vim.keymap.set('n', '<Leader>t', '<Cmd>Translate ja<CR>', { silent = true })
vim.keymap.set('v', '<Leader>t', '<Cmd>Translate ja<CR>', { silent = true })

vim.g.translator_target_lang = 'ja'
vim.g.translator_window_max_width = 0.8
vim.g.translator_window_max_height = 0.8

vim.keymap.set('n', '<Leader>t', '<Plug>Translate', { silent = true })
vim.keymap.set('v', '<Leader>t', '<Plug>TranslateV', { silent = true })
