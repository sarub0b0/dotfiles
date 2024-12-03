return {
  "uga-rosa/translate.nvim",
  {
    "voldikss/vim-translator",
    init = function()
      vim.g.translator_target_lang = "ja"
      vim.g.translator_window_max_width = 0.8
      vim.g.translator_window_max_height = 0.8
    end,
    keys = {
      { "<Leader>t", "<Plug>TranslateW", silent = true },
      { "<Leader>t", "<Plug>TranslateWV", mode = "v", silent = true },
    },
  },
}
