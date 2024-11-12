if vim.b.did_after_ftplugin then
  return
end
vim.b.did_after_ftplugin = 1

if vim.fn.expand('%:e') == 'mjml' then
  vim.b.eruby_subtype = 'html'
end
