vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.bin' },
  callback = function()
    vim.opt_local.filetype = 'binary'
  end,
  group = 'filetypedetect'
})
