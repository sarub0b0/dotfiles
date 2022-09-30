if vim.g.did_load_filetype_dockerfile then
  return
end
vim.g.did_load_filetype_dockerfile = 1

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { 'Dockerfile*', 'dockerfile*' },
  callback = function()
    local filename = vim.fn.expand('%:t')
    if filename == 'dockerfile.lua' or filename == 'dockerfile.vim' then
      return
    end

    vim.opt_local.filetype = 'dockerfile'
  end,
  group = vim.g.augroup_names.my_filetypes
})
