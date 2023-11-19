for _, value in ipairs({ 'nvim-ts-autotag', 'nvim-treesitter', 'ts_context_commentstring' }) do
  local ok, _ = pcall(require, value)
  if not ok then
    print(value .. ' is not installed.')
    return
  end
end

vim.g.skip_ts_context_commentstring_module = true

require('ts_context_commentstring').setup({
  enable_autocmd = false,
  languages = {
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
})

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
}
