return {
  {
    "voldikss/vim-floaterm",
    init = function()
      vim.g.floaterm_keymap_toggle = "\\\\"
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
    end,
  },
}
