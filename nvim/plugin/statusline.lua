local ok, _ = pcall(require, 'lualine')
if not ok then
  print 'lualine is not installed.'
  return
end

require('lualine').setup({
  options = {
    theme = 'OceanicNext',
  },
  extensions = {
    'fugitive',
    'fzf',
    'man',
    'neo-tree',
    'quickfix',
    'trouble',
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end
      }
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "filename",
        symbols = {
          readonly = ''
        }
      }
    },
    lualine_x = { "encoding", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location", "searchcount", "selectioncount" }
  },
})
