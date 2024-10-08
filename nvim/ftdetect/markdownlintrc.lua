vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*markdownlintrc' },
  callback = function()
    vim.opt_local.filetype = 'json'
  end,
  group = 'filetypedetect'
})
