if vim.g.did_load_filetype_binary then
  return
end
vim.g.did_load_filetype_binary = 1

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.bin' },
  callback = function()
    vim.opt_local.filetype = 'binary'
  end,
  group = vim.g.augroup_names.my_filetypes
})
