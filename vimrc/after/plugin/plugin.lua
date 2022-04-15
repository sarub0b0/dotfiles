if not (vim.g.vscode)  then

require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  sync_install = false,

  highlight = {
    enable = true
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
  focus_only = true
}

require('treesitter-context').setup {
    enable = true,
}

end

