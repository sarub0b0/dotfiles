return {
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    lazy = false,
    init = function()
      vim.opt.termguicolors = true
    end,
    opts = function()
      return {
        options = {
          mode = "buffers",
          numbers = 'ordinal',
          modified_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = 'Directory',
              separator = true,
            },
            {
              filetype = "vista_kind",
              text = "Vista",
              separator = true,
            },
            {
              filetype = "neo-tree",
              text = "NeoTree",
              separator = true,
            }
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = true,
          separator_style = "thin",
          always_show_bufferline = true,
          groups = {
            options = {
              toggle_hidden_on_enter = true
            },
            items = {
              require('bufferline.groups').builtin.ungrouped,
              {
                name = "Tests",
                matcher = function(buf)
                  return buf.name:match('%_test') or buf.name:match('%_spec')
                end,
              },
              {
                name = "Docs",
                matcher = function(buf)
                  return buf.name:match('%.md') or buf.name:match('%.txt')
                end,
              },
            }
          }
        }
      }
    end,
    keys = {
      { '<leader>1', function() require('bufferline').go_to(1) end },
      { '<leader>2', function() require('bufferline').go_to(2) end },
      { '<leader>3', function() require('bufferline').go_to(3) end },
      { '<leader>4', function() require('bufferline').go_to(4) end },
      { '<leader>5', function() require('bufferline').go_to(5) end },
      { '<leader>6', function() require('bufferline').go_to(6) end },
      { '<leader>7', function() require('bufferline').go_to(7) end },
      { '<leader>8', function() require('bufferline').go_to(8) end },
      { '<leader>9', function() require('bufferline').go_to(9) end },
      { '<leader>$', function() require('bufferline').go_to(9) end },
      { ']b',        function() require('bufferline').cycle(1) end },
      { '[b',        function() require('bufferline').cycle(-1) end },
    }
  }
}
