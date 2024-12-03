vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*/.ssh/conf.d/*" },
  callback = function()
    vim.opt_local.filetype = "sshconfig"
  end,
  group = "filetypedetect",
})
