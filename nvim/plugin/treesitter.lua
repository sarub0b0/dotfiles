require('nvim-ts-autotag').setup({})

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'markdown', 'markdown_inline', 'yaml', 'c', 'lua', 'rust', 'json' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
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
