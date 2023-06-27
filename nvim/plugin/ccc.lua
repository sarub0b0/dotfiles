local ok, _ = pcall(require, 'ccc')
if not ok then
  print 'ccc is not installed.'
  return
end

require('ccc').setup({
  highlighter = {
    auto_enable = true,
    lsp = true
  }
})
