local ok, _ = pcall(require, 'ccc')
if not ok then
  print 'ccc is not installed.'
  return
end

local picker = require('ccc').picker

require('ccc').setup({
  pickers = {
    picker.ansi_escape({
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
    }),
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
  },
})
