if vim.b.my_current_syntax then
  return
end

vim.cmd([[
  syntax clear gitcommitSummary
  syntax match gitcommitSummary	"\%^.*" contained containedin=gitcommitFirstLine contains=@Spell
]])

vim.b.my_current_syntax = "gitcommit"
