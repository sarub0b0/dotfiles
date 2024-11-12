if vim.b.did_after_ftplugin then
  return
end
vim.b.did_after_ftplugin = 1

vim.opt_local.textwidth = 0
