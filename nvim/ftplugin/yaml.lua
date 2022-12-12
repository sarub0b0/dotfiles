if vim.b.my_did_ftplugin then
  return
end
vim.b.my_did_ftplugin = 1

vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
