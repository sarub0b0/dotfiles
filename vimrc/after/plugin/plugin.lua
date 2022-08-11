if not (vim.g.vscode)  then

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "dot",
    "go",
    "gomod",
    "html",
    "http",
    "javascript",
    "json",
    "json5",
    "lua",
    "make",
    "perl",
    "php",
    "python",
    "ruby",
    "rust",
    "toml",
    "typescript",
    "vim",
    "yaml",
  },
  sync_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}


require('modes').setup {
  colors = {
    copy = '#fac863',
    delete = '#ec5f67',
    insert = '#99c794',
    visual = '#c594c5',
  },
  line_opacity = 0.5,
}

require('treesitter-context').setup {
    enable = true,
}

require('bufresize').setup {}

end

