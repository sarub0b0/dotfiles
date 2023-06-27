local ok, _ = pcall(require, 'diffview')
if not ok then
  print 'diffview is not installed.'
  return
end

require("diffview").setup({})
