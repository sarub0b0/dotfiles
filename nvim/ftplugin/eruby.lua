if vim.b.my_did_ftplugin then
  return
end
vim.b.my_did_ftplugin = 1

if vim.fn.expand('%:e') == 'mjml' then
  vim.b.eruby_subtype = 'html'
end
