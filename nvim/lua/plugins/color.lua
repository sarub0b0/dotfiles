return {
  {
    "mhartington/oceanic-next",
    priority = 1000,
    lazy = false,
    config = function()
      vim.g.oceanic_next_terminal_italic = 1
      vim.g.oceanic_next_terminal_bold = 1

      local augroup = vim.api.nvim_create_augroup("HighlightOverride", {})

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        group = augroup,
        callback = function()
          vim.api.nvim_set_hl(0, 'Floaterm', { fg = "#d8dee9", bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'FloatermBorder', { fg = "#d8dee9", bg = 'NONE' })

          -- gitの差分の色を変更
          -- adrian5/oceanic-next-vimから抽出
          vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2d4a46" })
          vim.api.nvim_set_hl(0, "DiffChange", { bg = "#29445a" })
          vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#45353e" })

          vim.api.nvim_set_hl(0, 'DiffAdded', { fg = "#99c794" })
          vim.api.nvim_set_hl(0, "DiffFile", { fg = "#c594c5", bold = true })
          vim.api.nvim_set_hl(0, "DiffIndexLine", { fg = "#4d616b" })
          vim.api.nvim_set_hl(0, "DiffLine", { fg = "#6699cc" })
          vim.api.nvim_set_hl(0, "DiffRemoved", { fg = "#ec5f67" })
          vim.api.nvim_set_hl(0, "DiffSubname", { fg = "#5fb3b3" })

          vim.api.nvim_set_hl(0, "@text.diff.add", { link = "DiffAdded" })
          vim.api.nvim_set_hl(0, "@text.diff.delete", { link = "DiffRemoved" })
          -- end

          vim.api.nvim_set_hl(0, "GitSignsAddInline", { fg = "#99c794", bold = true })
          vim.api.nvim_set_hl(0, "GitSignsChangeInline", { fg = "#65737e" })
          vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { fg = "#ec5f67" })

          vim.api.nvim_set_hl(0, "NormalFloat", {})

          vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'VertSplit' })

          local status_line = vim.api.nvim_get_hl(0, { name = 'StatusLine' })
          vim.api.nvim_set_hl(0, 'WinBar', status_line)

          local status_line_nc = vim.api.nvim_get_hl(0, { name = 'StatusLineNC' })
          vim.api.nvim_set_hl(0, 'WinBarNC', status_line_nc)

          for _, hl in ipairs({
            'Normal',
            'LineNr',
            'SignColumn',
            'EndOfBuffer',
            'VertSplit',
            'Folded',
            'Floaterm',
            'FloatermBorder',
            'WinBar',
            'WinBarNC',
          }) do
            local args = vim.api.nvim_get_hl(0, { name = hl })

            args.bg = 'None'
            args.ctermbg = 'None'

            vim.api.nvim_set_hl(0, hl, args)
          end
        end,
      })

      vim.cmd.colorscheme('OceanicNext')
    end,
  },
  {
    'mvllow/modes.nvim',
    opts = {
      colors = {
        copy = '#fac863',
        delete = '#ec5f67',
        insert = '#99c794',
        visual = '#c594c5',
      },
      line_opacity = 0.5,
    }
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    init = function()
      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#ec5f67", ctermfg = 203 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#fac863", ctermfg = 221 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#6699cc", ctermfg = 68 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#f99157", ctermfg = 209 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#99c794", ctermfg = 114 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#c594c5", ctermfg = 176 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#62b3b2", ctermfg = 73 })
    end,
    main = "rainbow-delimiters.setup",
    opts = function()
      return {
        strategy = {
          [''] = require('rainbow-delimiters').strategy['global'],
          vim = require('rainbow-delimiters').strategy['local'],
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
      }
    end
  },
  {
    'uga-rosa/ccc.nvim',
    opts = function()
      local picker = require('ccc').picker

      local picker_ansi_escape = picker.ansi_escape({
        foreground = "#c0c5ce",
        background = "#1b2b34",
        black = "#16252b",
        red = "#ec5f67",
        green = "#99c794",
        yellow = "#fac863",
        blue = "#6699cc",
        magenta = "#c594c5",
        cyan = "#62b3b2",
        white = "#ffffff",
        bright_black = "#65737e",
        bright_red = "#ec5f67",
        bright_green = "#99c794",
        bright_yellow = "#fac863",
        bright_blue = "#6699cc",
        bright_magenta = "#c594c5",
        bright_cyan = "#62b3b2",
        bright_white = "#ffffff",
      })

      return {
        pickers = {
          picker_ansi_escape,
          picker.hex,
          picker.css_rgb,
          picker.css_hsl,
          picker.css_hwb,
          picker.css_lab,
          picker.css_lch,
          picker.css_oklab,
          picker.css_oklch,
        },
        highlighter = {
          auto_enable = false,
          lsp = true,
          excludes = {
            "packer",
          }
        }

      }
    end
  },
  'aklt/plantuml-syntax'
}
