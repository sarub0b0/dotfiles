if vim.b.did_ftplugin == 1 then
  return
end
vim.b.did_ftplugin = 1

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
