local ok, _ = pcall(require, 'modes')
if not ok then
  print 'modes is not installed.'
  return
end

require('modes').setup {

  colors = {
    copy = '#fac863',
    delete = '#ec5f67',
    insert = '#99c794',
    visual = '#c594c5',
  },
  line_opacity = 0.5,
}
