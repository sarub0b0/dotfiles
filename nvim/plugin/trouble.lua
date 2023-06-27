local ok, _ = pcall(require, 'trouble')
if not ok then
  print 'trouble is not installed.'
  return
end

require("trouble").setup({
  auto_close = true,
})

vim.keymap.set('n', '<Space>t', '<Cmd>TroubleToggle<CR>', { noremap = true, silent = true })
