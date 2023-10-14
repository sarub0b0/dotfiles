local ok, _ = pcall(require, 'ibl')
if not ok then
  print 'indent-blankline is not installed.'
  return
end

require("ibl").setup({
  enabled = true,
  indent = {
    char = '│',
    highlight = { 'VertSplit' }
  },
  scope = {
    enabled = true
  }
})

local hooks = require("ibl.hooks")

hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_space_indent_level
)

hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_tab_indent_level
)
