if vim.g.did_load_filetype_sshconfig then
  return
end

vim.g.did_load_filetype_sshconfig = 1

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*/.ssh/conf.d/*' },
  callback = function()
    vim.opt_local.filetype = 'sshconfig'
  end,
  group = vim.g.augroup_names.my_filetypes
})
