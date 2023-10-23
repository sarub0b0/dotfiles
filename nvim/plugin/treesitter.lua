for _, value in ipairs({ 'nvim-ts-autotag', 'nvim-treesitter' }) do
  local ok, _ = pcall(require, value)
  if not ok then
    print(value .. ' is not installed.')
    return
  end
end

require('nvim-ts-autotag').setup({})

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'markdown',
    'markdown_inline',
    'yaml',
    'c',
    'lua',
    'rust',
    'json',
    'gitcommit',
    'gitignore',
    'gitattributes',
    'git_rebase',
    'git_config',
    'diff'
  },
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


