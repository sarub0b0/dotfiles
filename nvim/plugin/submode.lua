local ok, _ = pcall(vim.fn['submode#current'])
if not ok then
  print 'submode is not installed.'
  return
end

vim.fn['submode#enter_with']('bufmove', 'n', '', 's>', '<C-w>>')
vim.fn['submode#enter_with']('bufmove', 'n', '', 's<', '<C-w><')
vim.fn['submode#enter_with']('bufmove', 'n', '', 's+', '<C-w>+')
vim.fn['submode#enter_with']('bufmove', 'n', '', 's-', '<C-w>-')
vim.fn['submode#map']('bufmove', 'n', '', '>', '<C-w>>')
vim.fn['submode#map']('bufmove', 'n', '', '<', '<C-w><')
vim.fn['submode#map']('bufmove', 'n', '', '+', '<C-w>+')
vim.fn['submode#map']('bufmove', 'n', '', '-', '<C-w>-')
