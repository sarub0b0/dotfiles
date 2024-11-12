if vim.b.did_after_ftplugin then
  return
end
vim.b.did_after_ftplugin = 1

vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
