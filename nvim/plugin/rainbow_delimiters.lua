local ok, _ = pcall(require, 'rainbow-delimiters')
if not ok then
  print 'rainbow-delimiters is not installed.'
  return
end

local rainbow_delimiters = require('rainbow-delimiters')

vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#ec5f67", ctermfg = 203 })
vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#fac863", ctermfg = 221 })
vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#6699cc", ctermfg = 68 })
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#f99157", ctermfg = 209 })
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#99c794", ctermfg = 114 })
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#c594c5", ctermfg = 176 })
vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#62b3b2", ctermfg = 73 })

require("rainbow-delimiters.setup").setup({
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local'],
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  }
})
