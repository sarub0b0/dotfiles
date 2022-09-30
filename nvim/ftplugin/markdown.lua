if vim.b.my_did_ftplugin then
  return
end
vim.b.my_did_ftplugin = 1

vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

vim.keymap.set('n', '<leader>f', '<Cmd>TableFormat<CR>', { noremap = true, silent = true })
