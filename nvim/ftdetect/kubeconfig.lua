if vim.g.did_load_filetype_kubeconfig then
  return
end
vim.g.did_load_filetype_kubeconfig = 1

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '$HOME/.kube/config*' },
  callback = function()
    vim.opt_local.filetype = 'yaml'
  end,
  group = vim.g.augroup_names.my_filetypes
})
