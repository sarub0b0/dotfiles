vim.g.translator_target_lang = 'ja'
-- Echo translation in the cmdline
-- vim.keymap.set('n', '<Leader>t', '<Plug>Translate', { silent = true })
-- vim.keymap.set('v', '<Leader>t', '<Plug>TranslateV', { silent = true })
-- Display translation in a window
vim.keymap.set('n', '<Leader>t', '<Plug>TranslateW', { silent = true })
vim.keymap.set('v', '<Leader>t', '<Plug>TranslateWV', { silent = true })
-- Replace the text with translation
-- vim.keymap.set('n', '<Leader>r', '<Plug>TranslateR', { silent = true })
-- vim.keymap.set('v', '<Leader>r', '<Plug>TranslateRV', { silent = true })
-- Translate the text in clipboard
-- vim.keymap.set('n', '<Leader>x', "<Plug>TranslateX", { silent = true })
