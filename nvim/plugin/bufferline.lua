vim.opt.termguicolors = true

require('bufferline').setup({
  options = {
    mode = "buffers",
    numbers = 'ordinal',
    modified_icon = '●',
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
      }
    },
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    separator_style = "slant",
    always_show_bufferline = true,
    groups = {
      options = {
        toggle_hidden_on_enter = true
      },
      items = {
        {
          name = "Tests",
          priority = 2,
          matcher = function(buf)
            return buf.filename:match('%_test') or buf.filename:match('%_spec')
          end,

        },
        {
          name = "Docs",
          matcher = function(buf)
            return buf.filename:match('%.md') or buf.filename:match('%.txt')
          end,
        },
      }
    }
  }
})


vim.keymap.set('n', ']b', function() require('bufferline').cycle(1) end, { noremap = true })
vim.keymap.set('n', '[b', function() require('bufferline').cycle(-1) end, { noremap = true })
