if vim.g.did_load_filetype_markdownlintrc then
  return
end
vim.g.did_load_filetype_markdownlintrc = 1

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*markdownlintrc' },
  callback = function()
    vim.opt_local.filetype = 'json'
  end,
  group = vim.g.augroup_names.my_filetypes
})
