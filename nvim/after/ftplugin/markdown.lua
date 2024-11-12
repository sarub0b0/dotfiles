if vim.b.did_after_ftplugin then
  return
end
vim.b.did_after_ftplugin = 1

vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

vim.keymap.set('n', '<leader>f', '<Cmd>TableFormat<CR>', { noremap = true, silent = true })
