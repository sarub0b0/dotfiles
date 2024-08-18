return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      "someone-stole-my-name/yaml-companion.nvim",
    },
    opts = {
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
          },
          {
            "yaml schema",
            fmt = function()
              local schema = require("yaml-companion").get_buf_schema(0)

              if schema.result[1].name == "none" then
                return ""
              end

              return schema.result[1].name
            end
          }
        },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location", "searchcount", "selectioncount" }
      }
    }
  }
}
