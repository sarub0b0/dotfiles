vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.mjml" },
  callback = function()
    vim.opt_local.filetype = "eruby"
  end,
  group = "filetypedetect",
})
