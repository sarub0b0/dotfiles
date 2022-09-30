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
  }
}
