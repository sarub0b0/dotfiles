vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '$HOME/.kube/config*' },
  callback = function()
    vim.opt_local.filetype = 'yaml'
  end,
  group = 'filetypedetect'
})
