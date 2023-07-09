local ok, _ = pcall(require, 'indent_blankline')
if not ok then
  print 'indent-blankline is not installed.'
  return
end

require("indent_blankline").setup({
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  use_treesitter_scope = true,
  show_first_indent_level = false,
})
