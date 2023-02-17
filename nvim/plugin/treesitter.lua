require('nvim-ts-autotag').setup({})

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    colors = {
      '#ffffff',
      '#ec5f67',
      '#f99157',
      '#fac863',
      '#99c794',
      '#62b3b2',
      '#6699cc',
      '#c594c5',
      '#ab7967',
    }
  },
  endwise = {
    enable = true
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    config = {
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      },
      typescript = {
        __default = '// %s',
        __multiline = '/* %s */'
      }
    }
  }
}
